FROM registry.access.redhat.com/openshift3/jenkins-slave-base-rhel7:v3.10

LABEL com.redhat.component="jenkins-slave-nodejs-rhel7-docker" \
      name="openshift3/jenkins-slave-zap-rhel7" \
      version="3.10" \
      architecture="x86_64" \
      release="1" \
      io.k8s.display-name="Jenkins Slave ZAP" \
      io.k8s.description="The jenkins slave ZAP image has the OWASP Zed Attack Proxy on top of the jenkins slave base image." \
      io.openshift.tags="openshift,jenkins,slave,zap,owasp"

USER root

ENV JAVA_HOME /usr/lib/jvm/java-1.8.0-openjdk-1.8.0.191.b12-0.el7_5.x86_64/jre
ENV PATH /zap:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.191.b12-0.el7_5.x86_64/jre/bin
COPY policies /var/lib/jenkins/.ZAP/policies/
COPY run-jnlp-client /usr/local/bin/run-jnlp-client
RUN chmod 755 /usr/local/bin/run-jnlp-client
WORKDIR /zap
RUN curl -s https://raw.githubusercontent.com/zaproxy/zap-admin/master/ZapVersions-dev.xml | \
    grep "<url>" | grep ZAP | grep Linux | sed -e 's@^[^>]*>\([^<]*\).*$@\1@g' | xargs -n 1 curl -s -L -o zap.tar.gz && \
    tar --strip-components=1 -xzf zap.tar.gz && \
    rm -f zap.tar.gz

ENTRYPOINT [ "run-jnlp-client" ]

USER 1001