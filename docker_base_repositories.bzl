def docker_base_repositories():
  # Debian base image for docker containers. 2017-01-16 debootstraps
  native.http_file(
      name = "com_github_tianon_docker_brew_debian",
      urls = [
          "https://raw.githubusercontent.com/tianon/docker-brew-debian/b39d31635ca26c8b1f3d982090ba8d54167c4d85/jessie/rootfs.tar.xz",
          "https://storage.googleapis.com/sh-external-artifacts/raw.githubusercontent.com/tianon/docker-brew-debian/b39d31635ca26c8b1f3d982090ba8d54167c4d85/jessie/rootfs.tar.xz"
      ],
      sha256 = "467328e24c316fd058f086eb8eb77706f3f448ad8886d202e7c9687d30692eca",
  )

  # Java runtime layer for docker containers.
  native.http_file(
      name = "openjdk_8_jre_headless",
      urls = [
          "http://ftp.tw.debian.org/debian/pool/main/o/openjdk-8/openjdk-8-jre-headless_8u121-b13-1~bpo8+1_amd64.deb",
          "https://storage.googleapis.com/sh-external-artifacts/ftp.tw.debian.org/debian/pool/main/o/openjdk-8/openjdk-8-jre-headless_8u121-b13-1~bpo8+1_amd64.deb"
      ],
      sha256 = "16c3846091ab2ba9ff5938a8ace017ef2b8aafa1585f2eed120da26d30d658a5",
  )

  # Required by jvm runtime.
  native.http_file(
    name = "glib2",
    urls = [
        "http://ftp.debian.org/debian/pool/main/g/glib2.0/libglib2.0-0_2.42.1-1+b1_amd64.deb",
        "https://storage.googleapis.com/sh-external-artifacts/ftp.debian.org/debian/pool/main/g/glib2.0/libglib2.0-0_2.42.1-1+b1_amd64.deb"
    ],
    sha256 = "a4b30c84c0c050f23a986fbc576daa04b246ab816ec0fcb0b471d19aa2689a97",
  )

  # Required by jvm runtime.
  native.http_file(
    name = "ffi",
    urls = [
        "http://ftp.debian.org/debian/pool/main/libf/libffi/libffi6_3.1-2+b2_amd64.deb",
        "https://storage.googleapis.com/sh-external-artifacts/ftp.debian.org/debian/pool/main/libf/libffi/libffi6_3.1-2%2Bb2_amd64.deb",
    ],
    sha256 = "481af9931f3352a51a579511a20ff3d57068681d6c760513590200a71fe49a50",
  )

  # This is needed by grpc. We could use the boringssl that we've got in
  # third_party, but I have no idea how to cross-compile for the linux docker
  # container.
  native.http_file(
    name = "libssl_linux_deb",
    urls = [
        "http://security.debian.org/debian-security/pool/updates/main/o/openssl/libssl1.0.0_1.0.1t-1+deb8u6_amd64.deb",
        "https://storage.googleapis.com/sh-external-artifacts/security.debian.org/debian-security/pool/updates/main/o/openssl/libssl1.0.0_1.0.1t-1+deb8u6_amd64.deb"
    ],
    sha256 = "0fc777d9242fd93851eb49c4aafd22505048b7797c0178f20c909ff918320619",
  )

  native.http_file(
    name = "libapr1_linux_deb",
    urls = [
        "http://ftp.debian.org/debian/pool/main/a/apr/libapr1_1.5.1-3_amd64.deb",
        "https://storage.googleapis.com/sh-external-artifacts/ftp.debian.org/debian/pool/main/a/apr/libapr1_1.5.1-3_amd64.deb"
    ],
    sha256 = "92c3e71e6d33cb64e808c601ded60c8289bb990f2ab7d5e2c0b2c242e766363f",
  )

  native.http_file(
    name = "ca_certificates",
    urls = [
        "http://ftp.tw.debian.org/debian/pool/main/c/ca-certificates/ca-certificates_20141019+deb8u2_all.deb",
        "https://storage.googleapis.com/sh-external-artifacts/ftp.tw.debian.org/debian/pool/main/c/ca-certificates/ca-certificates_20141019+deb8u2_all.deb"
    ],
    sha256 = "bc6340541700618d4cb0441ee9ad159a9c8fd2063200280ff6cdf96b1595beb2",
  )
