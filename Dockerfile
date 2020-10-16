FROM alpine:3.12.0

LABEL maintainer=<nic.cheneweth@thoughtworks.com>

# packages required for use as a circleci remote-docker primary container
# hadolint ignore=DL3003
RUN apk add --no-cache \
        git==2.26.2-r0 \
        openssh==8.3_p1-r0 \
        tar==1.32-r1 \
        gzip==1.10-r0 \
        ca-certificates==20191127-r4 \
        sudo==1.9.0-r0 \
        libintl==0.20.2-r0 && \
        apk --no-cache add --virtual build-dependencies \
        cmake==3.17.2-r0 \
        make==4.3-r0 \
        musl-dev==1.1.24-r9 \
        gcc==9.3.0-r2 \
        gettext-dev==0.20.2-r0 && \
    wget https://gitlab.com/rilian-la-te/musl-locales/-/archive/master/musl-locales-master.zip && \
    unzip musl-locales-master.zip && cd musl-locales-master && \
    cmake -DLOCALE_PROFILE=OFF -D CMAKE_INSTALL_PREFIX:PATH=/usr . && \
    make && make install && \
    cd .. && rm -r musl-locales-master && \
    apk del build-dependencies

ENV PATH=/home/circleci/bin:/home/circleci/.local/bin:$PATH \
    MUSL_LOCPATH=/usr/share/i18n/locales/musl \
    LANG="C.UTF-8" \
    LANGUAGE="en_US.UTF-8" \
    LC_ALL="en_US.UTF-8"

ENV USER=circleci
RUN addgroup --gid 3434 -S $USER && \
    adduser --uid 3434 --ingroup $USER --disabled-password $USER && \
    echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER && \
    chmod 0440 /etc/sudoers.d/$USER && \
    mkdir -p /home/circleci/project && \
    chown -R $USER:$USER /home/circleci/project

USER circleci

WORKDIR /home/circleci/project

HEALTHCHECK NONE
