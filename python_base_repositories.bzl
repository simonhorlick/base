def python_base_repositories():
  native.new_git_repository(
      name = "com_twistedmatrix_twisted",
      remote = "https://github.com/twisted/twisted.git",
      tag = "twisted-16.5.0",
      build_file = str(Label("//third_party:twisted.BUILD")),
  )

  # Transitive dependency for twisted
  native.new_git_repository(
      name = "com_github_hawkowl_incremental",
      remote = "https://github.com/hawkowl/incremental",
      tag = "incremental-16.10.1",
      build_file = str(Label("//third_party:incremental.BUILD")),
  )
