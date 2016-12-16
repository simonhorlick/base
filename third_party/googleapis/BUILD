load("//tools/build_rules:genproto.bzl", "proto_library")

licenses(["notice"])

package(default_visibility = ["//visibility:public"])

proto_library(
    name = "annotations_proto",
    srcs = [
        "google/api/http.proto",
        "google/api/annotations.proto",
        "google/protobuf/descriptor.proto",
    ],
)

filegroup(
    name = "googleapis",
    srcs = [
        "google/api/http.proto",
        "google/api/annotations.proto",
        "google/protobuf/descriptor.proto",
    ],
)
