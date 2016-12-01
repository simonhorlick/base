licenses(["notice"])  # Apache 2

package(default_visibility = ["//visibility:public"])

genrule(
    name = "generate_version",
    srcs = ["okhttp/src/main/java-templates/com/squareup/okhttp/internal/Version.java"],
    outs = ["okhttp/src/main/java/com/squareup/okhttp/internal/Version.java"],
    cmd = "sed 's/\$${project.version}/2.7.5/g' $< >$@",
)

java_library(
    name = "okhttp",
    srcs = glob([
        "okhttp/src/main/java/**/*.java",
    ]) + [":generate_version"],
    javacopts = [
        "-source 7",
        "-target 7",
    ],
    deps = [
        "//external:android",
        "@okio//:okio",
    ],
)
