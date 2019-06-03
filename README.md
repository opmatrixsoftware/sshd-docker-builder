CentOS 7 Docker in Docker (DinD) Image with SSHD
===============================

# Description
The purpose of this image is to give users, or automated build agents, the ability to have secure root access via SSH and build other docker images.  The image also has ``svn``, ``git``, and ``make`` 
to copy/pull artifacts from version control systems directly in to the container and automate image building with ``make``. 

## Docker image

Centos:7 with docker, docker-compose, and openssh installed.

## Kubernetes files

Example yaml scripts to deploy in Kubernetes with the ability to access the container via SSH and build docker images.

# How to deploy using Docker
You must run this image with as privileged.

Example:
``
$ docker run --privileged --name some-docker -d docker:dind
``

# How to deploy in Kubernetes

Run the Makefile or generate the a RSA key-pair.
Import the sshd-docker-builder-yaml file into Kubernetes

With Make:
``
$ make all
``

Manually:
```
$ mkdir sshkeys
$ ssh-keygen -q -f sshkeys/id_rsa -N '' -t rsa
$ KEY=$(cat sshkeys/id_rsa.pub | base64 -w 0)
$ sed 's/my_key/'$KEY'/' secret.yaml > ssh-key-secret.yaml
$ unset KEY
$ kubectl create -f ssh-key-secret.yaml
$ kubectl create -f sshd-docker-builder.yaml
```

## Find the endpoint of the SSH server
```
kubectl describe service sshd-docker-builder-01-nodeport
```