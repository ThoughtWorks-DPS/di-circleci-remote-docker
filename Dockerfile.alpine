FROM alpine:3.14.0

LABEL maintainer=<nic.cheneweth@thoughtworks.com>

ENV USER=circleci

# packages required for use as a circleci remote-docker primary container
RUN apk add --no-cache \
        git==2.32.0-r0 \
        openssh==8.6_p1-r2 \
        tar==1.34-r0 \
        gzip==1.10-r1 \
        ca-certificates==20191127-r5 \
        sudo==1.9.7_p1-r1 && \
    addgroup --gid 3434 -S $USER && \
    adduser --uid 3434 --ingroup $USER --disabled-password $USER && \
    echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER && \
    chmod 0440 /etc/sudoers.d/$USER && \
    mkdir -p /home/circleci/project && \
    chown -R $USER:$USER /home/circleci/project

USER circleci

WORKDIR /home/circleci/project

HEALTHCHECK NONE
