#!/bin/bash

ssh-keygen -f /etc/ssh/ssh_host_ecdsa_key -N '' -t ecdsa
ssh-keygen -f /etc/ssh/ssh_host_ed25519_key -N '' -t ed25519

mkdir -p /root/.ssh
touch /root/.ssh/authorized_keys
printf "%s\n" "${SSH_PUB_KEY}" > /root/.ssh/authorized_keys
unset ${SSH_PUB_KEY}
chmod 600 /root/.ssh/authorized_keys

mkdir -p /root/.kube
touch /root/.kube
printf "%s\n" "${KUBE_CONFIG}" > /root/.kube/config
#unset ${KUBE_CONFIG}
chmod 600 /root/.kube/config

echo 1 > /proc/sys/net/ipv4/ip_forward
sysctl --system

/usr/sbin/sshd -D &
/usr/bin/dockerd --storage-driver fuse-overlayfs