# Commonly used java library dependencies
def java_base_repositories():
  native.maven_jar(
    name = "jcip_annotations",
    artifact = "net.jcip:jcip-annotations:1.0",
    sha1 = "",
  )

  native.maven_jar(
    name = "com_google_code_gson_gson",
    artifact = "com.google.code.gson:gson:2.8.0",
    sha1 = "c4ba5371a29ac9b2ad6129b1d39ea38750043eff",
  )

  native.maven_jar(
    name = "com_google_guava_guava",
    artifact = "com.google.guava:guava:19.0",
    sha1 = "6ce200f6b23222af3d8abb6b6459e6c44f4bb0e9",
  )

  # grpc uses annotations provided by this library
  native.git_repository(
    name = "error_prone",
    commit = "4c2a0a40af9a9f2dc9855c1ef31dfd84290a8870",
    remote = "https://github.com/simonhorlick/error-prone.git",
  )

  native.maven_jar(
    name = "com_google_code_findbugs_jsr305",
    artifact = "com.google.code.findbugs:jsr305:3.0.1",
    sha1 = "f7be08ec23c21485b9b5a1cf1654c2ec8c58168d",
  )

  native.maven_jar(
    name = "org_slf4j_slf4j_api",
    artifact = "org.slf4j:slf4j-api:1.7.7",
    sha1 = "a4cf4688fe1c7e3a63aa636cc96d013af537768e"
  )

  native.maven_jar(
    name = "org_slf4j_slf4j_simple",
    artifact = "org.slf4j:slf4j-simple:1.7.7",
    sha1 = "a4cf4688fe1c7e3a63aa636cc96d013af537768e"
  )