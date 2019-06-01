CentOS 7 Docker in Docker (DinD) Image with SSHD
===============================

# Description
The purpose of this image is to give users or automated build agents the ability to have secure root access via SSH and build other docker images 

## Docker image

Centos:7 with docker, docker-compose, and openssh installed.

## Kubernetes files

Example yaml scripts to deploy in Kubernetes with the ability to access the container via SSH and build docker images.

# How to deploy using Docker
You must run this image with as privileged.

Example:
```
$ docker run --privileged --name some-docker -d docker:dind
```

# How to deploy in Kubernetes

TBD

## Generate your ssh key

generate the id_rsa key or copy your own key to sshkeys folder

TBD

## create service and replication controller


## find the endpoint and ssh to the server

```
kubectl describe service sshd-jumpserver-svc

Name:           sshd-jumpserver-svc
Namespace:      default
Labels:         name=sshd-jumpserver-svc
Selector:       app=sshd-jumpserver
Type:           LoadBalancer
IP:         10.0.43.1
LoadBalancer Ingress:   ac646353e0e3e11e6bd02065967720c2-558922547.us-west-1.elb.amazonaws.com
Port:           ssh 22/TCP
NodePort:       ssh 30583/TCP
Endpoints:      10.244.4.10:22
Session Affinity:   None
No events.
```

then you can ssh to the server with the private key

```
ssh -i sshkeys/id_rsa root@ac646353e0e3e11e6bd02065967720c2-558922547.us-west-1.elb.amazonaws.com

Warning: Permanently added the ECDSA host key for IP address '54.219.157.181' to the list of known hosts.
[root@sshd-jumpserver-rc-oj6bv ~]#
```