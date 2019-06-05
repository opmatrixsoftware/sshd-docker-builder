FROM centos:latest

COPY entrypoint.sh /
RUN chmod 711 /entrypoint.sh

ENV WORKDIR /root
WORKDIR $WORKDIR
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
RUN chmod 711 $WORKDIR/kubectl
RUN mv $WORKDIR/kubectl /usr/local/bin
RUN curl -LO https://storage.googleapis.com/kubernetes-helm/helm-v2.14.0-linux-amd64.tar.gz
RUN tar -xvzf $WORKDIR/helm-v2.14.0-linux-amd64.tar.gz linux-amd64/helm --strip 1
RUN rm -f $WORKDIR/helm-v2.14.0-linux-amd64.tar.gz
RUN chmod 711 $WORKDIR/helm
RUN mv $WORKDIR/helm /usr/local/bin

RUN groupadd docker
RUN yum -y update
RUN yum -y install git
RUN yum -y install svn
RUN yum -y install make
RUN yum -y install openssh
RUN yum -y install openssh-clients
RUN yum -y install openssh-server
RUN yum -y install epel-release
RUN yum -y install iptables
RUN yum -y install bridge-utils
RUN yum -y install docker
RUN yum -y install python-pip
RUN yum clean all
RUN pip install --upgrade pip
RUN pip install docker-compose
RUN ln -s /usr/libexec/docker/docker-runc-current /usr/bin/docker-runc
RUN ln -s /usr/libexec/docker/docker-init-current /usr/bin/docker-init

EXPOSE 22

CMD ["/entrypoint.sh"]
