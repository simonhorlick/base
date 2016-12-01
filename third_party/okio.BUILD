licenses(["notice"])  # Apache 2

package(default_visibility = ["//visibility:public"])

java_library(
    name = "okio",
    srcs = glob(["okio/src/main/java/**/*.java"]),
    javacopts = [
        "-source 7",
        "-target 7",
    ],
    deps = [
        "@animal_sniffer//:annotations",
    ],
)
