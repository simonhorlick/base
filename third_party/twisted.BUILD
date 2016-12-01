package(default_visibility = ["//visibility:public"])

py_library(
    name = "common",
    srcs = glob(["src/twisted/*.py"]),
    imports = ["src"],
    deps = ["@com_github_hawkowl_incremental//:incremental"],
)

py_library(
    name = "cred",
    srcs = glob(["src/twisted/cred/*.py"]),
    imports = ["src"],
)

py_library(
    name = "internet",
    srcs = glob(["src/twisted/internet/*.py"]),
    imports = ["src"],
)

py_library(
    name = "logger",
    srcs = glob(["src/twisted/logger/*.py"]),
    imports = ["src"],
)

py_library(
    name = "persisted",
    srcs = glob(["src/twisted/persisted/*.py"]),
    imports = ["src"],
)

py_library(
    name = "protocols",
    srcs = glob(["src/twisted/protocols/*.py"]),
    imports = ["src"],
)

py_library(
    name = "python",
    srcs = glob(["src/twisted/python/*.py"]),
    imports = ["src"],
)

py_library(
    name = "spread",
    srcs = glob(["src/twisted/spread/*.py"]),
    imports = ["src"],
)

py_library(
    name = "web",
    srcs = glob(["src/twisted/web/*.py"]),
    imports = ["src"],
    deps = [
        ":common",
        ":cred",
        ":logger",
        ":persisted",
        ":protocols",
        ":python",
        ":spread",
        "@com_github_hawkowl_incremental//:incremental",
    ],
)
