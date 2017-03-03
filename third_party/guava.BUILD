package(default_visibility = ["//visibility:public"])

licenses(["notice"])

java_library(
    name = "guava",
    srcs = glob([
        "guava/src/com/google/**/*.java",
    ]),
    javacopts = [
        "-extra_checks:off",
    ],
    deps = [
        "@error_prone//annotations",
        "@com_google_j2objc_j2objc_annotations//jar",
        "@com_google_code_findbugs_jsr305//jar",
        "@org_codehaus_mojo_animal_sniffer_annotations//jar",
    ],
)
