workspace(name = "com_github_simonhorlick_base")

# See example.WORKSPACE for an idea of how to use these dependencies.

# This needs to come before rpc repositories.
git_repository(
    name = "io_bazel_rules_go",
    remote = "https://github.com/bazelbuild/rules_go.git",
    tag = "0.4.0",
)

load("@io_bazel_rules_go//go:def.bzl",
     "go_repositories",
     "new_go_repository")

go_repositories()

load("//:java_base_repositories.bzl", "java_base_repositories")
load("//:java_test_repositories.bzl", "java_test_repositories")
load("//:python_base_repositories.bzl", "python_base_repositories")
load("//:rpc_repositories.bzl", "rpc_repositories")

java_base_repositories()
java_test_repositories()
python_base_repositories()
rpc_repositories()
