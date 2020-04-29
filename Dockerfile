FROM jenkins/jenkins:alpine

# Skip initial setup
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false

#Pre-install plugins
COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/plugins.txt

# setup docker, docker-compose
USER root
RUN apk add docker jq ansible terraform python-dev libffi-dev openssl-dev gcc libc-dev make py-pip && pip install docker-compose awscli

USER jenkins
