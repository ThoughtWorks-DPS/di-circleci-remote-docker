#!/usr/bin/env bats

@test "evaluate installed package versions" {
  run bash -c "docker exec di-circleci-remote-docker-alpine-edge apk -v info"
  [[ "${output}" =~ "git-2.32.0-r0" ]]
  [[ "${output}" =~ "openssh-8.6_p1-r2" ]]
  [[ "${output}" =~ "tar-1.34-r0" ]]
  [[ "${output}" =~ "gzip-1.10-r1" ]]
  [[ "${output}" =~ "ca-certificates-20191127-r5" ]]
  [[ "${output}" =~ "sudo-1.9.7_p1-r1" ]]
}

@test "git version" {
  run bash -c "docker exec di-circleci-remote-docker-alpine-edge git --version"
  [[ "${output}" =~ "2.32" ]]
}

@test "openssh version" {
  run bash -c "docker exec di-circleci-remote-docker-alpine-edge ssh -V"
  [[ "${output}" =~ "8.6" ]]
}

@test "tar version" {
  run bash -c "docker exec di-circleci-remote-docker-alpine-edge tar --version"
  [[ "${output}" =~ "1.34" ]]
}

@test "gzip version" {
  run bash -c "docker exec di-circleci-remote-docker-alpine-edge gzip --version"
  [[ "${output}" =~ "1.10" ]]
}

@test "ca-certificates installed" {
  run bash -c "docker exec di-circleci-remote-docker-alpine-edge ls /etc/ssl/certs/"
  [[ "${output}" =~ "ca-cert-DigiCert_Assured_ID_Root_CA.pem" ]]
}

@test "sudo version" {
  run bash -c "docker exec di-circleci-remote-docker-alpine-edge sudo --version"
  [[ "${output}" =~ "1.9" ]]
}

@test "describe user circleci" {
  run bash -c "docker exec di-circleci-remote-docker-alpine-edge getent passwd | grep circleci"
  [[ "${output}" =~ "circleci:x:3434:3434" ]]
  [[ "${output}" =~ "/home/circleci" ]]
}

@test "describe user circleci group" {
  run bash -c "docker exec di-circleci-remote-docker-alpine-edge getent group | grep circleci"
  [[ "${output}" =~ "circleci:x:3434:circleci" ]]
}

@test "describe /home/circleci" {
  run bash -c "docker exec di-circleci-remote-docker-alpine-edge ls -ld /home/circleci"
  [[ "${output}" =~ "circleci circleci" ]]
}

@test "describe /home/circleci/project" {
  run bash -c "docker exec di-circleci-remote-docker-alpine-edge ls -ld /home/circleci/project"
  [[ "${output}" =~ "circleci circleci" ]]
}
