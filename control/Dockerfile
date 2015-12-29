FROM ubuntu:14.04
MAINTAINER siddontang@gmail.com

ENV LEIN_ROOT true

#
# Jepsen dependencies
#
RUN apt-get -y -q update && \
    apt-get -y -q install software-properties-common && \
    add-apt-repository ppa:openjdk-r/ppa && \
    apt-get -y -q update && \
    apt-get install -qqy \
        openjdk-8-jdk \
        libjna-java \
        git \
        gnuplot \
        wget && \
    apt-get clean autoclean && \
    rm -rf /var/lib/apt/lists/*


RUN cd / && wget https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein && mv /lein /usr/bin 
RUN chmod +x /usr/bin/lein

# Install jepsen 0.0.7
RUN cd / && \
    wget https://github.com/aphyr/jepsen/archive/0.0.7.tar.gz && \
    tar xzf 0.0.7.tar.gz && \
    mv jepsen-0.0.7 jepsen && \
    cd jepsen/jepsen && \ 
    lein install

RUN mkdir -p /root/.ssh && \
    chmod 700 /root/.ssh 

COPY id_rsa /root/.ssh/id_rsa
COPY id_rsa.pub /root/.ssh/id_rsa.pub

RUN chmod 700 /root/.ssh && \
    chmod 600 /root/.ssh/id_rsa && \
    chmod 600 /root/.ssh/id_rsa.pub

RUN mkdir /jepsen_dev
# Create the VOLUMN so that we can run our local jepsen test.
VOLUME /jepsen_dev

ADD ./bashrc /root/.bashrc