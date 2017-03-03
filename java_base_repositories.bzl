# Commonly used java library dependencies
def java_base_repositories():
  native.maven_jar(
    name = "jcip_annotations",
    artifact = "net.jcip:jcip-annotations:1.0",
    sha1 = "afba4942caaeaf46aab0b976afd57cc7c181467e",
  )

  native.maven_jar(
    name = "gson",
    artifact = "com.google.code.gson:gson:2.8.0",
    sha1 = "c4ba5371a29ac9b2ad6129b1d39ea38750043eff",
  )

  native.maven_jar(
      name = "com_google_j2objc_j2objc_annotations",
      artifact = "com.google.j2objc:j2objc-annotations:1.3",
      sha1 = "ba035118bc8bac37d7eff77700720999acd9986d",
  )

  native.maven_jar(
      name = "org_codehaus_mojo_animal_sniffer_annotations",
      artifact = "org.codehaus.mojo:animal-sniffer-annotations:1.15",
      sha1 = "3f19b51588ad71482ce4c169f54f697b6181d1b4",
  )

  # Guava v21 adds Java 8 features that aren't supported on Android. As of v21
  # there is no way to support Android, so until that happens we stick to v20.
  native.new_git_repository(
      name = "com_google_guava",
      tag = "v20.0",
      remote = "https://github.com/google/guava.git",
      build_file = str(Label("//third_party:guava.BUILD")),
  )

  # grpc uses annotations provided by this library
  native.git_repository(
    name = "error_prone",
    tag = "v2.0.18",
    remote = "https://github.com/google/error-prone.git",
  )

  native.maven_jar(
    name = "com_google_code_findbugs_jsr305",
    artifact = "com.google.code.findbugs:jsr305:3.0.1",
    sha1 = "f7be08ec23c21485b9b5a1cf1654c2ec8c58168d",
  )

  native.maven_jar(
    name = "org_slf4j_slf4j_api",
    artifact = "org.slf4j:slf4j-api:1.7.7",
    sha1 = "2b8019b6249bb05d81d3a3094e468753e2b21311"
  )

  native.maven_jar(
    name = "org_slf4j_slf4j_simple",
    artifact = "org.slf4j:slf4j-simple:1.7.7",
    sha1 = "8095d0b9f7e0a9cd79a663c740e0f8fb31d0e2c8"
  )
