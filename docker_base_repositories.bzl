def docker_base_repositories():
  # Debian base image for docker containers.
  native.new_http_archive(
      name = "com_github_tianon_docker_brew_debian",
      url = "https://codeload.github.com/tianon/docker-brew-debian/zip/e9bafb113f432c48c7e86c616424cb4b2f2c7a51",
      build_file = "third_party/debian.BUILD",
      type = "zip",
      sha256 = "515d385777643ef184729375bc5cb996134b3c1dc15c53acf104749b37334f68",
  )

  # Java runtime layer for docker containers.
  native.http_file(
      name = "openjdk_8_jre_headless",
      url = "http://ftp.debian.org/debian/pool/main/o/openjdk-8/openjdk-8-jre-headless_8u111-b14-2~bpo8+1_amd64.deb",
      sha256 = "b1cd4c241e851fae0c7c615ee40ec30bc63da3025efb4aa887ac99728809a0c4",
  )

  # Required by jvm runtime.
  native.http_file(
    name = "glib2",
    url = "http://ftp.debian.org/debian/pool/main/g/glib2.0/libglib2.0-0_2.42.1-1+b1_amd64.deb",
    sha256 = "a4b30c84c0c050f23a986fbc576daa04b246ab816ec0fcb0b471d19aa2689a97",
  )

  # Required by jvm runtime.
  native.http_file(
    name = "ffi",
    url = "http://ftp.debian.org/debian/pool/main/libf/libffi/libffi6_3.1-2+b2_amd64.deb",
    sha256 = "481af9931f3352a51a579511a20ff3d57068681d6c760513590200a71fe49a50",
  )

  # This is needed by grpc. We could use the boringssl that we've got in
  # third_party, but I have no idea how to cross-compile for the linux docker
  # container.
  native.http_file(
    name = "libssl_linux_deb",
    url = "http://security.debian.org/debian-security/pool/updates/main/o/openssl/libssl1.0.0_1.0.1t-1+deb8u5_amd64.deb",
    sha256 = "e38239b8ab5e2b944aafe1f7484f3cab1100f8807a2e104b026adebda71afba6",
  )

  native.http_file(
    name = "libapr1_linux_deb",
    url = "http://ftp.debian.org/debian/pool/main/a/apr/libapr1_1.5.1-3_amd64.deb",
    sha256 = "92c3e71e6d33cb64e808c601ded60c8289bb990f2ab7d5e2c0b2c242e766363f",
  )

  native.http_file(
    name = "ca_certificates",
    url = "http://ftp.debian.org/debian/pool/main/c/ca-certificates/ca-certificates_20141019+deb8u1_all.deb",
    sha256 = "f58d646045855277c87f532ea5c18df319e91d9892437880c9a0169b834f1bd8",
  )
