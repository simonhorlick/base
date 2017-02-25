# Copyright 2014 The Bazel Authors. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# These rules try and mimick the proposed native proto library rules that are
# being introduced in Bazel.
#
# The proto_library rule is language-agnostic and simply collects dependencies
# between proto files. Therefore a proto_library may only depend on other
# proto_library rules. An important feature of the proto_library rule is that
# each proto_library rule adds the current package to the import path of the
# protoc invocation (the --proto_path arguments).
#
# The java_proto_library takes a set of proto_library dependencies and runs
# them through the protocol buffer compiler with both java and grpc outputs.
# The outputs are collected as a single .srcjar which is then compiled as a
# normal java_library.


def gensrcjar_impl(ctx):
    proto_src_deps = []
    proto_src_imports = []
    for dep in ctx.attr.deps:
        proto_src_deps.extend(dep.proto_library.srcs)
        proto_src_imports.extend(dep.proto_library.imports)

    proto_src_files = []
    for target in proto_src_deps:
        for f in target.files:
            proto_src_files.append(f)

    paths = []
    for f in proto_src_files:
        paths.append(f.path)

    inputs, outputs, arguments = proto_src_files, [], []

    # Strip the 'src' from the .srcjar output so protoc will output a single .jar
    # file containing all of the generated sources.
    srcjar = ctx.new_file(ctx.outputs.srcjar.basename[:-6] + "jar")
    outputs += [srcjar]

    for path in proto_src_imports:
        arguments += ["--proto_path=" + path]

    java_grpc_plugin = ctx.executable.grpc_java_plugin
    inputs += [java_grpc_plugin]

    arguments += ["--plugin=protoc-gen-java_rpc=" + java_grpc_plugin.path]

    if ctx.attr.is_nano:
      arguments += [
          "--java_rpc_out=nano=true:" + srcjar.path,
          "--javanano_out=generate_equals=true,enum_style=java,store_unknown_fields=true,ignore_services=true:" + srcjar.path
      ]
    else:
      arguments += [
          "--java_rpc_out=" + srcjar.path,
          "--java_out=" + srcjar.path
      ]

    # Now append all of the source .proto files to the arguments list.
    for src in proto_src_files:
        arguments += [src.path]

    # Generate java sources from the given proto files.
    ctx.action(
        mnemonic="GenProto",
        inputs=inputs,
        outputs=[srcjar],
        arguments=arguments,
        executable=ctx.executable._proto_compiler)

    # This is required because protoc only understands .jar extensions, but Bazel
    # requires source JAR files end in .srcjar.
    ctx.action(
        mnemonic="FixProtoSrcJar",
        inputs=[srcjar],
        outputs=[ctx.outputs.srcjar],
        arguments=[srcjar.path, ctx.outputs.srcjar.path],
        command="cp $1 $2")

    # Fixup the resulting outputs to keep the source-only .jar out of the result.
    outputs += [ctx.outputs.srcjar]
    outputs = [e for e in outputs if e != srcjar]

    return struct(runfiles=ctx.runfiles(collect_default=True))


gensrcjar = rule(
    gensrcjar_impl,
    attrs={
        "deps": attr.label_list(providers=["proto_library"]),
        "grpc_java_plugin": attr.label(
            cfg="host",
            executable=True,
            single_file=True, ),
        "_proto_compiler": attr.label(
            cfg="host",
            default=Label("@protobuf//:protoc"),
            executable=True,
            single_file=True, ),
        "is_nano": attr.bool(
            default=False,
            mandatory=False, ),
        "_jar": attr.label(
            cfg="host",
            default=Label("@bazel_tools//tools/jdk:jar"),
            allow_files=True,
            executable=True,
            single_file=True, ),
        # The jdk dependency is required to ensure dependent libraries are found
        # when we invoke jar (see issue #938).
        # TODO(bazel-team): Figure out why we need to pull this in explicitly;
        # the jar dependency above should just do the right thing on its own.
        "_jdk": attr.label(
            default=Label("@bazel_tools//tools/jdk:jdk"),
            allow_files=True, ),
    },
    outputs={"srcjar": "lib%{name}.srcjar"},
    output_to_genfiles=True, )


def proto_library_impl(ctx):
    depsrcs = []

    # Add the current package to the --proto_path of the final protoc
    # invocation.
    depimports = [ctx.label.package]

    for imp in ctx.attr.imports:
        depimports.append(imp)

    # Collect all dependent source .protos and dependent import paths.
    for dep in ctx.attr.deps:
        depsrcs.extend(dep.proto_library.srcs)
        depimports.extend(dep.proto_library.imports)

    for src in ctx.attr.srcs:
        depsrcs.append(src)

    return struct(proto_library=struct(srcs=depsrcs, imports=depimports))


proto_library = rule(
    implementation=proto_library_impl,
    attrs={
        "srcs": attr.label_list(allow_files=True),
        "deps": attr.label_list(),
        "imports": attr.string_list(),
        # This creates an implicit dependency on the protobuf compiler.
        "_compiler": attr.label(
            cfg = "host",
            default=Label("@protobuf//:protoc"),
            allow_single_file=True,
            executable=True),
    })


def java_proto_library(name, deps):
    grpc_java_plugin = Label("@grpc_java//:grpc_java_plugin")

    # Emit a rule that when executed outputs protobuf java sources.
    gensrcjar(
        name=name + "_srcjar", deps=deps, grpc_java_plugin=grpc_java_plugin)

    deps = deps + [
        str(Label("@grpc_java//:grpc-java")),
        # This contains compiled well-known protos
        str(Label("@protobuf//:protobuf_java")),
        str(Label("@guava//jar")),
    ]

    # Emit a java library rule that compiles the generated sources.
    native.java_library(
        name=name,
        srcs=[name + "_srcjar"],
        deps=deps,
        tags=["intellij-import-target-output"],
        javacopts = [
            "-source 7",
            "-target 7",
        ])

def javanano_proto_library(name, deps):
    grpc_java_plugin = Label("@grpc_java//:grpc_java_plugin")

    # Emit a rule that when executed outputs protobuf java sources.
    gensrcjar(
        name=name + "_srcjar", deps=deps, grpc_java_plugin=grpc_java_plugin, is_nano=True)

    deps = deps + [
        str(Label("@grpc_java//:grpc-java")),
        str(Label("@grpc_java//:protobuf-nano")),
        str(Label("@protobuf//:protobuf_javanano")),
        str(Label("@guava//jar")),
    ]

    # Emit a java library rule that compiles the generated sources.
    native.java_library(
        name=name,
        srcs=[name + "_srcjar"],
        deps=deps,
        tags=["intellij-import-target-output"],
        javacopts = [
            "-source 7",
            "-target 7",
        ])
