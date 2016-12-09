package(default_visibility = ["//visibility:public"])

licenses(["unencumbered"])  # BSD

cc_binary(
    name = "plugin",
    srcs = [
        "compiler/src/java_plugin/cpp/java_generator.cpp",
        "compiler/src/java_plugin/cpp/java_generator.h",
        "compiler/src/java_plugin/cpp/java_plugin.cpp",
    ],
    deps = [
        "@protobuf//:protoc_lib",
    ],
)

cc_binary(
    name = "grpc_java_plugin",
    srcs = [
        "compiler/src/java_plugin/cpp/java_generator.cpp",
        "compiler/src/java_plugin/cpp/java_generator.h",
        "compiler/src/java_plugin/cpp/java_plugin.cpp",
    ],
    deps = [
        "@protobuf//:protoc_lib",
    ],
)

java_library(
    name = "core",
    srcs = glob([
        "core/src/main/java/**/*.java",
    ]),
    # For Android support.
    javacopts = [
        "-source 7",
        "-target 7",
        "-extra_checks:off",  #error-prone checks fail, so disable them for now.
    ],
    deps = [
        "@com_google_code_findbugs_jsr305//jar",
        "@guava//jar",
        "@error_prone//annotations",
    ],
)

java_library(
    name = "grpc-netty",
    srcs = glob([
        "netty/src/main/java/**/*.java",
    ]),
    resources = glob([
        "netty/src/main/resources/**/*",
    ]),
    deps = [
        ":core",
        "@io_netty_netty_all//jar",
        "@com_google_code_findbugs_jsr305//jar",
        "@guava//jar",
    ],
)

java_library(
    name = "protobuf",
    srcs = glob([
        "protobuf/src/main/java/**/*.java",
        "protobuf-lite/src/main/java/**/*.java",
        "protobuf-nano/src/main/java/**/*.java",
    ]),
    # For Android support.
    javacopts = [
        "-source 7",
        "-target 7",
    ],
    deps = [
        ":core",
        "@com_google_code_findbugs_jsr305//jar",
        "@guava//jar",
        "@protobuf//:protobuf_java",
        "@protobuf//:protobuf_java_util",
    ],
)

java_library(
    name = "grpc-okhttp",
    srcs = glob([
        "okhttp/third_party/okhttp/java/**/*.java",
        "okhttp/src/main/java/**/*.java",
    ]),
    # For Android support.
    javacopts = [
        "-source 7",
        "-target 7",
    ],
    resources = glob([
        "okhttp/src/main/resources/**/*",
    ]),
    deps = [
        ":core",
        "@com_google_code_findbugs_jsr305//jar",
        "@guava//jar",
        "@okhttp//:okhttp",
        "@okio//:okio",
    ],
)

java_library(
    name = "stub",
    srcs = glob([
        "stub/src/main/java/**/*.java",
    ]),
    # For Android support.
    javacopts = [
        "-source 7",
        "-target 7",
    ],
    deps = [
        ":core",
        "@com_google_code_findbugs_jsr305//jar",
        "@guava//jar",
    ],
)

java_library(
    name = "grpc-java",
    exports = [
        #':auth', # don't need for plain grpc
        ":core",
        ":protobuf",
        ":stub",
        "@com_google_code_findbugs_jsr305//jar",
        "@protobuf//:protobuf_java",
        "@guava//jar",
    ],
)

## Testing
#java_library(
#    name = "testing",
#    testonly = 1,
#    srcs = glob([
#        "testing/src/main/**/*.java",
#    ]),
#    deps = [
#        ":grpc-java",
#    ],
#)
#
#java_library(
#    name = "interop",
#    testonly = 1,
#    srcs = glob([
#        "interop-testing/src/generated/**/*.java",
#        "interop-testing/src/main/**/*.java",
#    ]),
#    deps = [
#        ":grpc-java",
#        ":testing",
#        "//third_party/google_auth_library_oauth2_http",
#        "@junit//jar",
#        "@mockito//",
#        "//third_party/netty",
#    ],
#)
#
#java_test(
#    name = "interop_test",
#    srcs = glob([
#        "interop-testing/src/test/**/*.java",
#    ]),
#    args = [
#        "io.grpc.stub.StubConfigTest",
#        "io.grpc.testing.integration.InProcessTest",
#    ],
#    tags = [
#        "manual",
#    ],
#    runtime_deps = [
#        "@junit//jar",
#    ],
#    deps = [
#        ":grpc-java",
#        ":interop",
#        ":testing",
#        "@junit//jar",
#        "@mockito//",
#        "//third_party/netty",
#        "@okhttp//",
#    ],
#)
