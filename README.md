<div align="center">
	<p>
		<img alt="CircleCI Logo" src="https://raw.githubusercontent.com/ThoughtWorks-DPS/di-circleci-remote-docker/master/img/circle-circleci.svg?sanitize=true" width="75" />
		<img alt="Docker Logo" src="https://raw.githubusercontent.com/ThoughtWorks-DPS/di-circleci-remote-docker/master/img/circle-docker.svg?sanitize=true" width="75" />
		<img alt="Ubuntu Logo" src="https://raw.githubusercontent.com/ThoughtWorks-DPS/di-circleci-remote-docker/master/img/alpine.png?sanitize=true" width="75" />
	</p>
  <h3>ThoughtWorks DPS Convenience Images</h3>
  <h1>twdps/di-circleci-remote-docker</h1>
  <h5>A Continous Integration focused Alpine Docker image built to run on CircleCI</h5>
</div>
<br />


`cimg/base` is an Ubuntu Docker image created by CircleCI with continuous integration builds in mind.
As its name suggests, this image is designed to serve as a base image for other CircleCI Convenience Images (images prefixed with `cimg/`).

This image is also very useful for CircleCI users to use as a base for their own custom Docker images.

This image contains the minimum tools required to operate a build on CircleCI (such as `git`) as well as extremely popular and useful tools in CircleCI (such as `docker`).


Based on Alpine Linux. Minimum configuration to use docker image as CircleCI [remote docker executor](https://circleci.com/docs/2.0/custom-images/#section=configuration).

| apk add         |
|-----------------|
| git             |
| openssh         |
| tar             |
| gzip            |
| ca-certificates |


okay
