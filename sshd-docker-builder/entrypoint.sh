#!/bin/bash

ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa
ssh-keygen -f /etc/ssh/ssh_host_ecdsa_key -N '' -t ecdsa
ssh-keygen -f /etc/ssh/ssh_host_ed25519_key -N '' -t ed25519

mkdir -p /root/.ssh
touch /root/.ssh/authorized_keys
echo ${PUBLIC_KEY} > /root/.ssh/authorized_keys
unset ${PUBLIC_KEY}
chmod 600 /root/.ssh/authorized_keys

mkdir -p /root/.kube
touch /root/.kube/config
echo ${KUBE_CONFIG} > /root/.kube/config
unset ${KUBE_CONFIG}

echo 1 > /proc/sys/net/ipv4/ip_forward
modprobe br_netfilter
sysctl --system

/usr/bin/dockerd &
/usr/sbin/sshd -D
