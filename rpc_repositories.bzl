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
  native.maven_jar(
    name = "me_dinowernli_java_grpc_prometheus",
    artifact = "me.dinowernli:java-grpc-prometheus:0.1.0",
    sha1 = "262c766a0946ce5936341a57bffd5ceeff7aa389",
    server = "com_github_raw_dinowernli",
  )

  native.maven_server(
    name = "com_github_raw_dinowernli",
    url = "https://raw.github.com/dinowernli/maven-repos/master",
  )

  native.maven_jar(
    name = "io_prometheus_simpleclient",
    artifact = "io.prometheus:simpleclient:0.0.19",
    sha1 = "c1424b444a7ec61e056a180d52470ff397bc428d",
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
