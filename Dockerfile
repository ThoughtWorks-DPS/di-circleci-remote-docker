FROM alpine:3.13.1

LABEL maintainer=<nic.cheneweth@thoughtworks.com>

# packages required for use as a circleci remote-docker primary container
# hadolint ignore=DL3003
RUN apk add --no-cache \
        git==2.30.0-r0 \
        openssh==8.4_p1-r2 \
        tar==1.33-r1 \
        gzip==1.10-r1 \
        ca-certificates==20191127-r5 \
        sudo==1.9.5p2-r0 \
        libintl==0.20.2-r2 && \
        apk --no-cache add --virtual build-dependencies \
        cmake==3.18.4-r1 \
        make==4.3-r0 \
        musl-dev==1.2.2-r0 \
        musl-utils==1.2.2-r0 \
        gcc==10.2.1_pre1-r3 \
        gettext-dev==0.20.2-r2 && \
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
