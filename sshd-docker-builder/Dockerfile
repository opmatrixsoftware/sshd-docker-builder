FROM centos:latest
COPY entrypoint.sh /
ENV WORKDIR /root
WORKDIR $WORKDIR
COPY .bashrc $WORKDIR/
RUN chmod 711 /entrypoint.sh && \
    groupadd docker && \
    dnf -y update && \
    curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
    chmod 711 $WORKDIR/kubectl && \
    mv $WORKDIR/kubectl /usr/local/bin && \
    curl -LO https://get.helm.sh/helm-v3.4.1-linux-amd64.tar.gz && \
    tar -xvzf $WORKDIR/helm-v3.4.1-linux-amd64.tar.gz linux-amd64/helm --strip 1 && \
    rm -f $WORKDIR/helm-v3.4.1-linux-amd64.tar.gz && \
    chown root:root $WORKDIR/helm && \
    chmod 711 $WORKDIR/helm && \
    mv $WORKDIR/helm /usr/local/bin && \
    dnf -y install git svn make openssh-server python3 iptables epel-release 'dnf-command(config-manager)' && \
    dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo && \
    dnf -y install docker-ce --nobest && \
    dnf clean all && \
    pip3 install --upgrade pip docker-compose && \
    rm -rf /run/nologin
EXPOSE 22
CMD ["/entrypoint.sh"]