load("@bazel_tools//tools/build_defs/docker:docker.bzl", "docker_build")

# Extract .xz files
genrule(
    name = "jessie_tar",
    srcs = ["docker-brew-debian-e9bafb113f432c48c7e86c616424cb4b2f2c7a51/jessie/rootfs.tar.xz"],
    outs = ["jessie_tar.tar"],
    cmd = "cat $< | xzcat >$@",
)

docker_build(
    name = "jessie",
    tars = [":jessie_tar"],
    visibility = ["//visibility:public"],
)
