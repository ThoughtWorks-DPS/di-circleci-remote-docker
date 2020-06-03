#!/usr/bin/env bats

@test "evaluate installed package versions" {
  run bash -c "docker exec di-circleci-remote-docker-edge apk -v info"
  [[ "${output}" =~ "git-2.24.3-r0" ]]
  [[ "${output}" =~ "openssh-8.1_p1-r0" ]]
  [[ "${output}" =~ "tar-1.32-r1" ]]
  [[ "${output}" =~ "gzip-1.10-r0" ]]
  [[ "${output}" =~ "ca-certificates-20191127-r1" ]]
  [[ "${output}" =~ "sudo-1.8.31p1-r1" ]]
  [[ "${output}" =~ "libintl-0.20.1-r2" ]]
}

@test "git version" {
  run bash -c "docker exec di-circleci-remote-docker-edge git --version"
  [[ "${output}" =~ "2.24" ]]
}

@test "openssh version" {
  run bash -c "docker exec di-circleci-remote-docker-edge ssh -V"
  [[ "${output}" =~ "8.2" ]]
}

@test "tar version" {
  run bash -c "docker exec di-circleci-remote-docker-edge tar --version"
  [[ "${output}" =~ "1.32" ]]
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
  [[ "${output}" =~ "1.8" ]]
}

@test "confirm localization" {
  run bash -c "docker exec di-circleci-remote-docker-edge locale -a"
  [[ "${output}" =~ "C.UTF-8" ]]
  [[ "${output}" =~ "fr_FR.UTF-8" ]]
  [[ "${output}" =~ "de_CH.UTF-8" ]]
}

@test "current localization" {
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

@test "describe /home/circleci" {
  run bash -c "docker exec di-circleci-remote-docker-edge ls -ld /home/circleci/project"
  [[ "${output}" =~ "circleci circleci" ]]
}
