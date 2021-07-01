#!/usr/bin/env bats

@test "evaluate installed package versions" {
  run bash -c "docker exec di-circleci-remote-docker-slim-edge apt list"
  [[ "${output}" =~ "git/now 1:2.20.1-2+deb10u3" ]]
  [[ "${output}" =~ "openssh-server/now 1:7.9p1-10+deb10u2" ]]
  [[ "${output}" =~ "tar/now 1.30+dfsg-6" ]]
  [[ "${output}" =~ "gzip/now 1.9-3" ]]
  [[ "${output}" =~ "ca-certificates/now 20200601~deb10u2" ]]
  [[ "${output}" =~ "sudo/now 1.8.27-1+deb10u3" ]]
}

@test "git version" {
  run bash -c "docker exec di-circleci-remote-docker-slim-edge git --version"
  [[ "${output}" =~ "2.20.1" ]]
}

@test "openssh version" {
  run bash -c "docker exec di-circleci-remote-docker-slim-edge ssh -V"
  [[ "${output}" =~ "7.9p1" ]]
}

@test "tar version" {
  run bash -c "docker exec di-circleci-remote-docker-slim-edge tar --version"
  [[ "${output}" =~ "1.30" ]]
}

@test "gzip version" {
  run bash -c "docker exec di-circleci-remote-docker-slim-edge gzip --version"
  [[ "${output}" =~ "1.9" ]]
}

@test "ca-certificates installed" {
  run bash -c "docker exec di-circleci-remote-docker-slim-edge ls /etc/ssl/certs/"
  [[ "${output}" =~ "DigiCert_Assured_ID_Root_CA.pem" ]]
}

@test "sudo version" {
  run bash -c "docker exec di-circleci-remote-docker-slim-edge sudo --version"
  [[ "${output}" =~ "1.8.27" ]]
}

@test "describe user circleci" {
  run bash -c "docker exec di-circleci-remote-docker-slim-edge getent passwd | grep circleci"
  [[ "${output}" =~ "circleci:x:3434:3434" ]]
  [[ "${output}" =~ "/home/circleci" ]]
}

@test "describe user circleci group" {
  run bash -c "docker exec di-circleci-remote-docker-slim-edge getent group | grep circleci"
  [[ "${output}" =~ "circleci:x:3434:" ]]
}

@test "describe /home/circleci" {
  run bash -c "docker exec di-circleci-remote-docker-slim-edge ls -ld /home/circleci"
  [[ "${output}" =~ "circleci circleci" ]]
}

@test "describe /home/circleci/project" {
  run bash -c "docker exec di-circleci-remote-docker-slim-edge ls -ld /home/circleci/project"
  [[ "${output}" =~ "circleci circleci" ]]
}
