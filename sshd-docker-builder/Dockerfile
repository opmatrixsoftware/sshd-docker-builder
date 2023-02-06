# WARNING make sure you are the approprate line endings for your system.  i.e. /n for linux and /r/n for windows
FROM rockylinux:9
ENV WORKDIR /root
WORKDIR $WORKDIR
COPY --chown=root:root entrypoint.sh /
COPY --chown=root:root .bashrc $WORKDIR/
RUN chmod 711 /entrypoint.sh && \
    groupadd docker && \
    dnf -y update && \
    curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
    chmod 711 kubectl && \
    mv kubectl /usr/local/bin && \
    curl -LO https://get.helm.sh/helm-v3.4.1-linux-amd64.tar.gz && \
    tar -xvzf helm-v3.4.1-linux-amd64.tar.gz linux-amd64/helm --strip 1 && \
    rm -f helm-v3.4.1-linux-amd64.tar.gz && \
    chown root:root helm && \
    chmod 711 helm && \
    mv helm /usr/local/bin && \
    dnf -y install git svn make openssh-server python3 python3-pip fuse-overlayfs procps-ng iptables epel-release 'dnf-command(config-manager)' && \
    dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo && \
    dnf -y install docker-ce docker-ce-cli containerd.io --nobest && \
    dnf clean all && \
    pip3 install --upgrade pip docker-compose && \
    rm -rf /run/nologin
EXPOSE 22
CMD ["/entrypoint.sh"]