#!/bin/bash
# Need to add the Docker Hub account name before the image name to push to Docker Hub.
docker image tag d583c3ac45fd opmatrix/sshd-docker-builder:9.4
docker push opmatrix/sshd-docker-builder:9.4