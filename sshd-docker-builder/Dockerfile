FROM centos:latest

COPY entrypoint.sh /
RUN chmod 711 /entrypoint.sh

ENV WORKDIR /root
WORKDIR $WORKDIR
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
RUN chmod 711 $WORKDIR/kubectl
RUN mv $WORKDIR/kubectl /usr/local/bin
RUN curl -LO https://get.helm.sh/helm-v3.4.1-linux-amd64.tar.gz
RUN tar -xvzf $WORKDIR/helm-v3.4.1-linux-amd64.tar.gz linux-amd64/helm --strip 1
RUN rm -f $WORKDIR/helm-v3.4.1-linux-amd64.tar.gz
RUN chmod 711 $WORKDIR/helm
RUN mv $WORKDIR/helm /usr/local/bin

RUN groupadd docker
RUN dnf -y update
RUN dnf -y install git
RUN dnf -y install svn
RUN dnf -y install make
RUN dnf -y install openssh
RUN dnf -y install openssh-clients
RUN dnf -y install openssh-server
RUN dnf -y install epel-release
RUN dnf -y install iptables
RUN dnf -y install bridge-utils
RUN dnf -y install docker
RUN dnf -y install python-pip
RUN dnf clean all
RUN pip install --upgrade pip
RUN pip install docker-compose
RUN ln -s /usr/libexec/docker/docker-runc-current /usr/bin/docker-runc
RUN ln -s /usr/libexec/docker/docker-init-current /usr/bin/docker-init

EXPOSE 22

CMD ["/entrypoint.sh"]
