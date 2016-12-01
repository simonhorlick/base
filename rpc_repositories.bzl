# rpc_repositories expects to already have java_base_repositories loaded.
def rpc_repositories():
  native.git_repository(
    name = "protobuf",
    # v3.1.0 with changes to compile javanano too.
    commit = "5e8d377e396e9f4bedf6a460b49ff66c90d943b2",
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
    sha1 = "539df70269cc254a58cccc5d8e43286b4a73bf30",
    server = "com_github_raw_dinowernli",
  )

  native.maven_server(
    name = "com_github_raw_dinowernli",
    url = "https://raw.github.com/dinowernli/maven-repos/master",
  )

  # This bind is required for protobuf_java_util
  native.bind(
    name = "gson",
    actual = "@com_google_code_gson_gson//jar",
  )

  # This bind is required for protobuf_java_util
  native.bind(
    name = "guava",
    actual = "@com_google_guava_guava//jar",
  )
