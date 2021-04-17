#!/usr/bin/env bats

@test "evaluate installed package versions" {
  run bash -c "docker exec di-circleci-remote-docker-edge apk -v info"
  # [[ "${output}" =~ "libcrypto1.1-1.1.1i-r0" ]]
  # [[ "${output}" =~ "libssl1.1-1.1.1i-r0" ]]
  [[ "${output}" =~ "git-2.30.2-r0" ]]
  [[ "${output}" =~ "openssh-8.4_p1-r3" ]]
  [[ "${output}" =~ "tar-1.34-r0" ]]
  [[ "${output}" =~ "gzip-1.10-r1" ]]
  [[ "${output}" =~ "ca-certificates-20191127-r5" ]]
  [[ "${output}" =~ "sudo-1.9.5p2-r0" ]]
  [[ "${output}" =~ "libintl-0.20.2-r2" ]]
}

@test "git version" {
  run bash -c "docker exec di-circleci-remote-docker-edge git --version"
  [[ "${output}" =~ "2.30" ]]
}

@test "openssh version" {
  run bash -c "docker exec di-circleci-remote-docker-edge ssh -V"
  [[ "${output}" =~ "8.4" ]]
}

@test "tar version" {
  run bash -c "docker exec di-circleci-remote-docker-edge tar --version"
  [[ "${output}" =~ "1.34" ]]
}

@test "gzip version" {
  run bash -c "docker exec di-circleci-remote-docker-edge gzip --version"
  [[ "${output}" =~ "1.10" ]]
}

@test "ca-certificates installed" {
  run bash -c "docker exec di-circleci-remote-docker-edge ls /etc/ssl/certs/"
  [[ "${output}" =~ "ca-cert-DigiCert_Assured_ID_Root_CA.pem" ]]
}

@test "sudo version" {
  run bash -c "docker exec di-circleci-remote-docker-edge sudo --version"
  [[ "${output}" =~ "1.9" ]]
}

@test "confirm localization one" {
  run bash -c "docker exec di-circleci-remote-docker-edge locale -a"
  [[ "${output}" =~ "C.UTF-8" ]]
  [[ "${output}" =~ "fr_FR.UTF-8" ]]
  [[ "${output}" =~ "de_CH.UTF-8" ]]
}

@test "current localization two" {
  run bash -c "docker exec di-circleci-remote-docker-edge locale"
  [[ "${output}" =~ "LANG=C.UTF-8" ]]
  [[ "${output}" =~ "LC_ALL=en_US.UTF-8" ]]
}

@test "describe user circleci" {
  run bash -c "docker exec di-circleci-remote-docker-edge getent passwd | grep circleci"
  [[ "${output}" =~ "circleci:x:3434:3434" ]]
  [[ "${output}" =~ "/home/circleci" ]]
}

@test "describe user circleci group" {
  run bash -c "docker exec di-circleci-remote-docker-edge getent group | grep circleci"
  [[ "${output}" =~ "circleci:x:3434:circleci" ]]
}

@test "describe /home/circleci" {
  run bash -c "docker exec di-circleci-remote-docker-edge ls -ld /home/circleci"
  [[ "${output}" =~ "circleci circleci" ]]
}

@test "describe /home/circleci/project" {
  run bash -c "docker exec di-circleci-remote-docker-edge ls -ld /home/circleci/project"
  [[ "${output}" =~ "circleci circleci" ]]
}
