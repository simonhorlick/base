load("@io_bazel_rules_go//go:def.bzl", "go_repositories", "new_go_repository")

# rpc_repositories expects to already have java_base_repositories loaded.
def rpc_repositories():
  native.git_repository(
    name = "protobuf",
    # v3.1.0 with changes to compile javanano too.
    commit = "81c032bb247bd28d3b6fb8c6fe5469bdccad19d4",
    remote = "https://github.com/simonhorlick/protobuf.git",
  )

  native.git_repository(
    name = "grpc",
    commit = "2a69139aa7f609e439c24a46754252a5f9d37500",
    remote = "https://github.com/grpc/grpc.git",
  )

  native.new_git_repository(
    name = "grpc_java",
    remote = "https://github.com/grpc/grpc-java.git",
    tag = "v1.0.0",
    build_file = str(Label("//third_party:grpc-java.BUILD")),
  )

  # For exporting metrics from grpc.
  native.git_repository(
    name = "me_dinowernli_java_grpc_prometheus",
    remote = "https://github.com/simonhorlick/java-grpc-prometheus.git",
    commit = "2bdb22e4d415b81fd976a9dbb86dfe72e5b3da7f",
  )

  # For me_dinowernli_java_grpc_prometheus
  native.bind(
      name = "grpc_core",
      actual = "@grpc_java//:core",
  )
  native.bind(
      name = "grpc_stub",
      actual = "@grpc_java//:stub",
  )
  native.bind(
      name = "prometheus_client",
      actual = "@io_prometheus_simpleclient//jar",
  )

  native.maven_jar(
    name = "io_prometheus_simpleclient",
    artifact = "io.prometheus:simpleclient:0.0.19",
    sha1 = "c1424b444a7ec61e056a180d52470ff397bc428d",
  )

  native.maven_jar(
    name = "io_prometheus_simpleclient_common",
    artifact = "io.prometheus:simpleclient_common:0.0.19",
    sha1 = "aa0d4a87c02e71924c913fbb4629b7ca5966a5ff",
  )

  native.maven_jar(
    name = "io_netty_netty_all",
    artifact = "io.netty:netty-all:4.1.3.Final",
    sha1 = "5304532edd11da8ab899baeab80aaf36ccf89d6e",
  )

  native.maven_jar(
    name = "okhttp",
    artifact = "com.squareup.okhttp:okhttp:2.7.4",
    sha1 = "f2c0782541a970b3c15f5e742999ca264b34d0bd",
  )

  native.maven_jar(
    name = "okio",
    artifact = "com.squareup.okio:okio:1.6.0",
    sha1 = "98476622f10715998eacf9240d6b479f12c66143",
  )

  new_go_repository(
    name = "com_github_grpc_ecosystem_grpc_gateway",
    importpath = "github.com/grpc-ecosystem/grpc-gateway",
    commit = "372984b6925646ccd2e7987037106b4337def2a9",
  )

  new_go_repository(
    name = "com_github_golang_glog",
    commit = "23def4e6c14b4da8ac2ed8007337bc5eb5007998",
    importpath = "github.com/golang/glog",
  )

  new_go_repository(
    name = "com_github_golang_protobuf",
    importpath = "github.com/golang/protobuf",
    commit = "1f49d83d9aa00e6ce4fc8258c71cc7786aec968a",
  )

  new_go_repository(
    name = "org_golang_x_net",
    commit = "de35ec43e7a9aabd6a9c54d2898220ea7e44de7d",
    importpath = "golang.org/x/net",
  )

  new_go_repository(
    name = "org_golang_google_grpc",
    tag = "v1.0.1-GA",
    importpath = "google.golang.org/grpc",
  )
