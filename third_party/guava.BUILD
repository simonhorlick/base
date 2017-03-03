package(default_visibility = ["//visibility:public"])

licenses(["notice"])

java_library(
    name = "guava",
    srcs = glob([
        "upstream/guava/src/com/google/**/*.java",
    ]),
    javacopts = [
        "-extra_checks:off",
    ],
    deps = [
        "@error_prone//annotations",
        "@j2objc:annotations",
        "@jsr305",
        "@org_codehaus_mojo_animal_sniffer_annotations//jar",
    ],
)
