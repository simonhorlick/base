load("@io_bazel_rules_go//go:def.bzl", "go_repositories", "new_go_repository")

# rpc_repositories expects to already have java_base_repositories loaded.
def rpc_repositories():
  native.git_repository(
    name = "protobuf",
    # v3.1.0 with changes to compile javanano too.
    commit = "8bac8720a3396db6e687a1716e24f588d6f165d4",
    remote = "https://github.com/simonhorlick/protobuf.git",
  )

  native.git_repository(
    name = "grpc",
    commit = "11ae5a77d6b2a059ef3fe4742ff2cc8b03b17139",
    remote = "https://github.com/grpc/grpc.git",
  )

  native.new_git_repository(
    name = "grpc_java",
    remote = "https://github.com/grpc/grpc-java.git",
    commit = "ea4390cf5c44e066e1649418f69822029bb58f1e",
    build_file = str(Label("//third_party:grpc-java.BUILD")),
  )

  native.maven_jar(
    name = "com_google_instrumentation_instrumentation_api",
    artifact = "com.google.instrumentation:instrumentation-api:0.3.0",
    sha1 = "a2e145e7a7567c6372738f5c5a6f3ba6407ac354",
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
    commit = "686368427ddb9a51628d63db6c74fbc96a206e1f",
  )

  new_go_repository(
    name = "com_github_golang_glog",
    commit = "23def4e6c14b4da8ac2ed8007337bc5eb5007998",
    importpath = "github.com/golang/glog",
  )

  new_go_repository(
    name = "com_github_golang_protobuf",
    importpath = "github.com/golang/protobuf",
    commit = "8ee79997227bf9b34611aee7946ae64735e6fd93",
  )

  new_go_repository(
    name = "org_golang_x_net",
    commit = "de35ec43e7a9aabd6a9c54d2898220ea7e44de7d",
    importpath = "golang.org/x/net",
  )

  new_go_repository(
    name = "org_golang_google_grpc",
    # Note that this needs to be kept in line with com_github_golang_protobuf so the
    # generated sources are compatible.
    tag = "v1.0.4",
    importpath = "google.golang.org/grpc",
  )

  new_go_repository(
    name = "com_github_gorilla_handlers",
    tag = "v1.2",
    importpath = "github.com/gorilla/handlers",
  )

  #
  # Transitive dependencies for netty
  #

  native.git_repository(
    name = "io_netty_netty",
    remote = "https://github.com/simonhorlick/netty.git",
    tag = "netty-4.1.6-bazel.Final",
  )

  native.maven_jar(
      name = "apache_commons_logging",
      artifact = "commons-logging:commons-logging:1.1.1",
      sha1 = "5043bfebc3db072ed80fbd362e7caf00e885d8ae",
  )

  native.maven_jar(
      name = "org_apache_log4j_log4j",
      artifact = "log4j:log4j:1.2.17",
      sha1 = "5af35056b4d257e4b64b9e8069c0746e8b08629f",
  )

  native.maven_jar(
      name = "org_apache_logging_log4j_log4j_api",
      artifact = "org.apache.logging.log4j:log4j-api:2.7",
      sha1 = "8de00e382a817981b737be84cb8def687d392963",
  )

  native.maven_jar(
      name = "javassist",
      artifact = "org.javassist:javassist:3.21.0-GA",
      sha1 = "598244f595db5c5fb713731eddbb1c91a58d959b",
  )

  native.maven_jar(
      name = "com_jcraft_jzlib",
      artifact = "com.jcraft:jzlib:1.1.3",
      sha1 = "c01428efa717624f7aabf4df319939dda9646b2d",
  )

  native.maven_jar(
      name = "org_eclipse_jetty_alpn_alpn_api",
      artifact = "org.eclipse.jetty.alpn:alpn-api:1.1.2.v20150522",
      sha1 = "3db64cbc5da220eda54b30843977622f520eab19",
  )

  native.maven_jar(
      name = "org_eclipse_jetty_npn_npn_api",
      artifact = "org.eclipse.jetty.npn:npn-api:1.1.1.v20141010",
      sha1 = "64d9cd3cb5079c120d37538f2d0d42665f951892",
  )

  native.maven_jar(
      name = "org_jctools_jctools_core",
      artifact = "org.jctools:jctools-core:1.2.1",
      sha1 = "ed2af5a88cdfc52df8dcb00f0c03a42d70605930",
  )

  native.maven_jar(
      name = "io_netty_netty_tcnative_boringssl_static",
      artifact = "io.netty:netty-tcnative-boringssl-static:jar:1.1.33.Fork26",
      sha1 = "03f6a7805566d6fccd8a128f6688c3541a7069d5",
  )

  native.maven_jar(
      name = "org_bouncycastle_bcprov_jdk15on",
      artifact = "org.bouncycastle:bcprov-jdk15on:jar:1.56",
      sha1 = "a153c6f9744a3e9dd6feab5e210e1c9861362ec7",
  )

  native.maven_jar(
      name = "org_bouncycastle_bcpkix_jdk15on",
      artifact = "org.bouncycastle:bcpkix-jdk15on:jar:1.56",
      sha1 = "4648af70268b6fdb24674fb1fd7c1fcc73db1231",
  )
