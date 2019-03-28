FROM alpine:3.9.2

LABEL maintainer=<nic.cheneweth@thoughtworks.com>

# packages required for use as a circleci remote-docker primary container
RUN apk update && apk upgrade && \
    apk add --no-cache \
    git \
    openssh \
    tar \
    gzip \
    ca-certificates

HEALTHCHECK NONE
