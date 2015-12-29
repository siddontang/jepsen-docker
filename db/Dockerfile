FROM tutum/debian:jessie
MAINTAINER siddontang@gmail.com

RUN rm /etc/apt/apt.conf.d/docker-clean && \
    apt-get update && \
    apt-get install -q -y --no-install-recommends \
                    sudo \
                    net-tools \
                    wget \
                    sysvinit-core \
                    sysvinit \
                    sysvinit-utils \
                    curl \
                    vim \
                    man \
                    faketime \
                    unzip \
                    iptables \
                    iputils-ping \
                    logrotate \
                    rsyslog && \
    apt-get remove -y --purge --auto-remove systemd 

RUN mkdir -p /root/.ssh && \
    chmod 700 /root/.ssh && \
    touch /root/.ssh/authorized_keys && \
    chmod 600 /root/.ssh/authorized_keys

COPY id_rsa.pub /root/id_rsa.pub
RUN cat /root/id_rsa.pub >> /root/.ssh/authorized_keys
