#!/usr/bin/env bash
_() { echo 'cleanup'; docker rm -f di-circleci-remote-docker-alpine-edge; docker rmi -f twdps/di-circleci-remote-docker:alpine-edge; docker rm -f di-circleci-remote-docker-slim-edge; docker rmi -f twdps/di-circleci-remote-docker:slim-edge ; }
trap _ EXIT

type=${1:-'pinned'}
alpine_dockerfile='Dockerfile.alpine'
slim_dockerfile='Dockerfile.slim'

# pass unpinned as a parameter to this script to test the unpinned
# package definitions for early detection of upcoming breaking changes
if [[ $type == "unpinned" ]]; then
  alpine_dockerfile='Dockerfile.alpine.unpinned'
  slim_dockerfile='Dockerfile.slim.unpinned'
fi

echo "build twdps/di-circleci-remote-docker:alpine"
docker build -t twdps/di-circleci-remote-docker:alpine-edge -f $alpine_dockerfile .
echo "build twdps/di-circleci-remote-docker:slim"
docker build -t twdps/di-circleci-remote-docker:slim-edge -f $slim_dockerfile .

echo "run image configuration tests"
docker run -it -d --name di-circleci-remote-docker-alpine-edge --entrypoint "/bin/ash" twdps/di-circleci-remote-docker:alpine-edge
docker run -it -d --name di-circleci-remote-docker-slim-edge --entrypoint "/bin/bash" twdps/di-circleci-remote-docker:slim-edge
bats test
