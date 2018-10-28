# This dockerfile builds the zap stable release
FROM centos:centos7
LABEL maintainer="Deven Phillips <deven.phillips@redhat.com>"

USER root

RUN yum install -y epel-release && \
    yum clean all
RUN yum install -y redhat-rpm-config \
    make automake autoconf gcc gcc-c++ \
    libstdc++ libstdc++-devel which \
    java-1.8.0-openjdk wget curl \
    xmlstarlet git x11vnc gettext tar \
    xorg-x11-server-Xvfb openbox xterm \
    net-tools python-pip unzip xauth \
    firefox nss_wrapper java-1.8.0-openjdk-headless \
    java-1.8.0-openjdk-devel nss_wrapper git && \
    yum clean all

RUN pip install --upgrade pip
RUN pip install zapcli
# Install latest dev version of the python API
RUN pip install python-owasp-zap-v2.4

COPY zap /zap
RUN mkdir -p /zap/wrk

RUN mkdir -p /home/zap/.vnc

ENV JAVA_HOME /usr/lib/jvm/java-1.8.0-openjdk/
ENV PATH $JAVA_HOME/bin:/zap/:$PATH
ENV ZAP_PATH /zap/zap.sh
ENV HOME /home/zap
ENV ZAPROXY_HOME /zap

# Default port for use with zapcli
ENV ZAP_PORT 8080

COPY policies /home/zap/.ZAP/policies/
COPY .xinitrc /home/zap

WORKDIR /zap
# Download and expand the latest stable release 
RUN curl -s https://raw.githubusercontent.com/zaproxy/zap-admin/master/ZapVersions.xml | xmlstarlet sel -t -v //url |grep -i weekly | wget -q --content-disposition -i - && \
	unzip -q *.zip && \
	rm *.zip && \
	cp -R ZAP*/* . &&  \
	rm -R ZAP* && \
	curl -s -L https://bitbucket.org/meszarv/webswing/downloads/webswing-2.5.5-distribution.zip > webswing.zip && \
	unzip -q webswing.zip && \
	rm webswing.zip && \
	mv webswing-* webswing && \
	rm -R webswing/demo/ && \
	rm -f webswing/webswing.config && \
	touch AcceptedLicense
COPY uid_entrypoint.sh /zap/uid_entrypoint.sh
ADD webswing.config /zap/webswing/webswing.config

RUN chown root:root /zap -R && \
	chown root:root /home/zap/.xinitrc && \
	chmod a+x /home/zap/.xinitrc && \
  chown root:root /etc/passwd && \
  chmod 660 /etc/passwd

EXPOSE 8080 8090

USER 1001
