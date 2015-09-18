FROM ubuntu:14.04

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y curl
#RUN curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
RUN curl -sL https://deb.nodesource.com/setup_0.10 | sudo -E bash -
RUN apt-get install -y nodejs

RUN mkdir /Applications
COPY downloads/* /Applications/

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y software-properties-common


RUN add-apt-repository ppa:webupd8team/java
RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN echo "oracle-java8-installer  shared/accepted-oracle-license-v1-1 boolean true" > /tmp/oracle-license-debconf
RUN /usr/bin/debconf-set-selections /tmp/oracle-license-debconf
RUN rm /tmp/oracle-license-debconf
# Install Oracle JDK 8
RUN DEBIAN_FRONTEND="noninteractive" apt-get -q -y install oracle-java8-installer oracle-java8-set-default
RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y libxrender-dev libxtst-dev git python build-essential 

# Replace 1000 with your user / group id
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/developer && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown ${uid}:${gid} -R /home/developer

RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y gnome-terminal
#COPY ws-license.tar.gz /home/developer/ws-license.tar.gz
COPY start.sh /start.sh
WORKDIR /home/developer
ENTRYPOINT ["/start.sh"]
WORKDIR /home/developer
USER developer
ENV HOME /home/developer

#ENTRYPOINT ["/WebStorm-141.1550/bin/webstorm.sh"]
