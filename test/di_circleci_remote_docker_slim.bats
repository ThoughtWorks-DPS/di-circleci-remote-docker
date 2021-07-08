#!/usr/bin/env bats

@test "git version" {
  run bash -c "docker exec di-circleci-remote-docker-slim-edge git --version"
  [[ "${output}" =~ "2.30.2" ]]
}

@test "openssh version" {
  run bash -c "docker exec di-circleci-remote-docker-slim-edge ssh -V"
  [[ "${output}" =~ "8.4p1" ]]
}

@test "tar version" {
  run bash -c "docker exec di-circleci-remote-docker-slim-edge tar --version"
  [[ "${output}" =~ "1.34" ]]
}

@test "gzip version" {
  run bash -c "docker exec di-circleci-remote-docker-slim-edge gzip --version"
  [[ "${output}" =~ "1.10" ]]
}

@test "ca-certificates installed" {
  run bash -c "docker exec di-circleci-remote-docker-slim-edge ls /etc/ssl/certs/"
  [[ "${output}" =~ "DigiCert_Assured_ID_Root_CA.pem" ]]
}
