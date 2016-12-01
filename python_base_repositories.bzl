def python_base_repositories():
  native.new_git_repository(
      name = "com_twistedmatrix_twisted",
      remote = "https://github.com/twisted/twisted.git",
      build_file = "third_party/twisted.BUILD",
      tag = "twisted-16.5.0",
  )

  # Transitive dependency for twisted
  native.new_git_repository(
      name = "com_github_hawkowl_incremental",
      remote = "https://github.com/hawkowl/incremental",
      build_file = "third_party/incremental.BUILD",
      tag = "incremental-16.10.1",
  )