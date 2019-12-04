##
## author: Piotr Stawarski <piotr.stawarski@zerodowntime.pl>
##

ARG CENTOS_VERSION=latest

FROM zerodowntime/centos:$CENTOS_VERSION

ARG JAVA_VERSION=1.8.0

RUN yum -y install \
      java-$JAVA_VERSION-openjdk-headless \
    && yum clean all \
    && rm -rf /var/cache/yum /var/tmp/* /tmp/*
