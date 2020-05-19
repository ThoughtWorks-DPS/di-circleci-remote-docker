docker run -it \
           -v /var/run/docker.sock:/var/run/docker.sock \
           -e "SNYK_TOKEN=$SNYK_TOKEN" \
           -v "${PWD}:/project" \
           snyk/snyk-cli:docker test \
           --org=twdps \
           --severity-threshold=low \
           --docker twdps/di-circleci-remote-docker:2020.05 \
           --file=Dockerfile
           
