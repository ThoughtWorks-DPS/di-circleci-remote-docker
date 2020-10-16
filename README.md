<div align="center">
	<p>
		<img alt="CircleCI Logo" src="https://raw.githubusercontent.com/ThoughtWorks-DPS/di-circleci-remote-docker/master/img/circle-circleci.svg?sanitize=true" width="75" />
		<img alt="Docker Logo" src="https://raw.githubusercontent.com/ThoughtWorks-DPS/di-circleci-remote-docker/master/img/circle-docker.svg?sanitize=true" width="75" />
		<img alt="Ubuntu Logo" src="https://raw.githubusercontent.com/ThoughtWorks-DPS/di-circleci-remote-docker/master/img/alpine.png?sanitize=true" width="75" />
	</p>
  <h3>ThoughtWorks DPS Convenience Images</h3>
  <h1>twdps/di-circleci-remote-docker</h1>
  <a href="https://app.circleci.com/pipelines/github/ThoughtWorks-DPS/di-circleci-remote-docker"><img src="https://circleci.com/gh/ThoughtWorks-DPS/di-circleci-remote-docker.svg?style=shield"></a> <a href="https://hub.docker.com/repository/docker/twdps/di-circleci-remote-docker"><img src="https://img.shields.io/docker/v/twdps/di-circleci-remote-docker?sort=semver"></a> <a href="https://hub.docker.com/repository/docker/twdps/di-circleci-remote-docker"><img src="https://img.shields.io/docker/image-size/twdps/di-circleci-remote-docker/2020.05"></a> <a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/github/license/ThoughtWorks-DPS/di-circleci-remote-docker"></a>
  <h5>A Continous Integration focused Alpine Docker image built to run on CircleCI</h5>
</div>
<br />

With some inspiration from the CircleCI convenience images, `twdps/di-circleci-remote-docker` is an Alpin-based docker image created with continuous integration builds in mind. As the name suggests, this image is designed to serve as a starter image for building a use-tailored CircleCI [remote docker executor](https://circleci.com/docs/2.0/custom-images/#section=configuration).  

This image contains the minimum packages required to operate a build on CircleCI, along with a `USER circleci` definition and multi-language support.  

_difference with cimg libraries._ Enterprise settings often require specific security and configuration testing. The twdps series of convenience images is based on Alpine linux and includes common sdlc practices including benchmark testing.  

**Other images in this series**  

twdps/di-circleci-base-image  
twdps/di-circleci-infra-image  

## Table of Contents

- [Getting Started](#getting-started)
- [What is included in the image](#what-is-included-in-the-image)
- [Development](#development)
- [Contributing](#contributing)
- [Additional Resources](#additional-resources)

## Getting Started

This image intended to be used as the FROM image in a custom CircleCI remote docker executor.  

For example:

```Dockerfile
FROM twdps/di-circleci-remote-docker:2020.06   # alpine:3.12.0

ENV NODE_VERSION=12.16.3

RUN curl -L -o node.tar.xz "https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.xz" && \
	sudo tar -xJf node.tar.xz -C /usr/local --strip-components=1 && \
	rm node.tar.xz && \
	sudo ln -s /usr/local/bin/node /usr/local/bin/nodejs
```

The tag `2020.05` indicates that the version of the base image used will be the May 2020 release.  
See how tags work below for more information.  

## What is Included in the Image

This image is based on the Alpine Linux distribution and contains the minimum requirements needed to be used as a remote docker executor on CircleCI:  

- git
- openssh
- tar
- gzip
- ca-certificates
- sudo (to support adding and defining a Dockerfile USER)
- libintl (required by musl-locales)
- musl-locales (for alpine multi-language support)

### Tagging Scheme

This image has the following tagging scheme:

```
twdps/di-circleci-remote-docker:edge
twdps/di-circleci-remote-docker:stable
twdps/di-circleci-remote-docker:<YYYY.MM>
```

`edge` - points to the latest version of the Base image. Built from the `HEAD` of the `master` branch. Intended to be used as a testing version of the image with the most recent changes however not guaranteed to be all that stable and not recommended for production software.  

`stable` - points to the latest, production ready base image. For projects that want a decent level of stability while automatically recieving software updates. This is similar to using the `:latest` tag and is not a generally recommended practice. Pin the `FROM` reference to a specific release and adopt new releases as part of your ci process. Typically updated once a month.  

`<YYYY.MM>` - Release version of the image, referred to by the 4 digit year, dot, and a 2 digit month. For example `2020.05` would be the monthly tag from May 2020. This is the recommended version for use in an executor Dockerfile.  

## Development

Images can be built and run locally with this repository.  
This has the following requirements:

- local machine of Linux (Alpine tested) or macOS
- modern version of a shell (zsh/bash tested (v4+))
- modern version of Docker Engine (v19.03+)

### Building the Dockerfiles

To build and test the Docker image locally, run the `testlocal.sh` script:

```bash
./testlocal.sh
```

*requirements for testing*  
conftest  
bats  

### Publishing Official Images (for Maintainers only)

Git push will trigger the dev-build pipeline. In addition to the tests performed in testlocal.sh, a snyk scan is done to expose any known vulnerabilities.  

To create a release version, simply tag HEAD with the release version format `YYYY.MM`  

## Contributing

We encourage [issues](https://github.com/twdps/di-circleci-remote-docker/issues) and [pull requests](https://github.com/twdps/di-circleci-remote-docker/pulls) against this repository. In order to value your time, here are some things to consider:

1. Intended to be the minimum configuration necessary for an alpine-based image to be successfully launched by circleci as a remote docker executor and specifically does not include any other packages. As such, the way to use the image is in the `FROM twdps/di-circleci-remote-docker:tag` statement of your Dockerfile.
1. PRs are welcome. Given the role of this image as a building block in building CircleCI remote docker executors, it is expected that PRs or Issue will be releated to bugs or compatibility issues. PR's to include additional packages will only be considered where necessary to continue supporting Alpine linux as a remote docker base.  

## Additional Resources

- [CircleCI Docs](https://circleci.com/docs/)  
- [CircleCI Configuration Reference](https://circleci.com/docs/2.0/configuration-reference/#section=configuration)  

