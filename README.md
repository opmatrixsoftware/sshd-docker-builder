Rocky Linux 9 Docker in Docker (DinD) Image with SSHD and Helm
===============================

# Description
The purpose of this image is to give users, or automated build agents, the ability to have secure root access via SSH to a full linux
environment in order to build other docker images and Helm Charts.  The image also has ``svn``, ``git``, and ``make`` to copy/pull
artifacts from version control systems directly in to the container and automate image building with ``make``. 

## Docker image

rockylinux:9 with helm, kubectl, docker, docker-compose, and openssh installed.

## Kubernetes files

Example yaml scripts to deploy in Kubernetes with the ability to access the container via SSH and build docker images.

# How to deploy using Docker
You must run this image "as privileged".  This container has only been testing on Rocky Linux 9 and Ubuntu 22, but it should 
work on most Linux hosts.

Example:
``
$ docker run -d --privileged --name <your container name> -p 2222:22 -e SSH_PUB_KEY="<your public key>" opmatrix/sshd-docker-builder:9
``

# How to deploy in Kubernetes

Run the Makefile or generate the ECDSA key-pair.
Import the sshd-docker-builder-yaml file into Kubernetes

With Make:
``
$ make all
``

Manually:
```
$ mkdir sshkeys
$ ssh-keygen -q -f sshkeys/id_ecdsa -N '' -t ecdsa
$ SSH_PUB_KEY=$(cat sshkeys/id_ecdsa.pub | base64 -w 0)
$ KUBE_CONFIG=$(cat .kube/config |base64 -w 0)
$ sed 's/my_key/'$SSH_PUB_KEY'/' secret.yaml > temp-secret.yaml
$ sed 's/my_config/'$KUBE_CONFIG'/' temp-secret.yaml > docker-builder-keys.yaml
$ unset SSH_PUB_KEY KUBE_CONFIG
$ rm -f temp-secret.yaml
$ kubectl create -f docker-builder-keys.yaml
$ kubectl create -f sshd-docker-builder.yaml
```

NOTE:  SSH servers will not work with keys in a Kubernetes mapped volume file.  Therefore, you must use an environment variable (in 
this case SSH_PUB_KEY) to hold the ssh public key.  The ``entrypoint.sh`` script will then create the ``/root/.ssh/authorized_keys`` file
 with the contents of this environment variable with the correct permissions.  After the file is created the environment variable is 
 removed.  The kubectl app does not have this issue, and .kube/config can be mapped using a Kubernetes "secret" volume file mount. 

## Find the endpoint of the SSH server
```
kubectl describe service sshd-docker-builder-01-nodeport
```
