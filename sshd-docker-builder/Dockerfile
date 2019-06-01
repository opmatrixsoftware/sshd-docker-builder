FROM centos:7

RUN yum -y update
RUN yum -y install openssh
RUN yum -y install openssh-clients
RUN yum -y install openssh-server
RUN yum -y install wget
RUN yum -y install iptables
RUN yum -y install bridge-utils
RUN sed -i --follow-symlinks 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux
RUN echo 1 > /proc/sys/net/ipv4/ip_forward
RUN modprobe br_netfilter
RUN sysctl --system
RUN groupadd docker
RUN yum -y install docker
RUN yum -y install epel-release
RUN yum -y install python-pip
RUN pip install --upgrade pip
RUN pip install docker-compose
RUN ln -s /usr/libexec/docker/docker-runc-current /usr/bin/docker-runc
RUN ln -s /usr/libexec/docker/docker-init-current /usr/bin/docker-init

EXPOSE 22

COPY entrypoint.sh /
CMD ["/entrypoint.sh"]
