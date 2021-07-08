## 07-02-2021 package versions in di-circleci-remote-docker 2021.07.1

^change

no changes in alpine-2021.07.1

FROM debian:bullseye-20210621-slim

| package         | version           |
|-----------------|-------------------|
| git             | 1:2.30.2-1^       |
| openssh-server  | 1:8.4p1-5^        |
| tar             | 1.34+dfsg-1^      |
| gzip            | 1.10-4^           |
| ca-certificates | 20210119^         |


## 07-02-2021 package versions in di-circleci-remote-docker 2021.07

*changes

FROM alpine:3.14.0

| package         | version     |
|-----------------|-------------|
| git             | 2.32.0-r0   |
| openssh         | 8.6_p1-r2   |
| tar             | 1.34-r0     |
| gzip            | 1.10-r1     |
| ca-certificates | 20191127-r5 |

FROM debian:buster-20210621-slim

| package         | version           |
|-----------------|-------------------|
| git             | 2.20.1-2+deb10u3* |
| openssh-server  | 7.9p1-10+deb10u2* |
| tar             | 1.30+dfsg-6*      |
| gzip            | 1.9-3*            |
| ca-certificates | 20200601~deb10u2* |
