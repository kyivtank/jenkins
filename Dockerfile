FROM jenkins/jenkins:alpine

# Skip initial setup
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false

#Pre-install plugins
COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/plugins.txt

# setup docker, docker-compose, terraform, ansible, jq
USER root
RUN apk add \
  docker \
  jq \
  ansible \
  python-dev \
  libffi-dev \
  openssl-dev \
  gcc \
  libc-dev \
  make \
  py-pip &&\
 pip install \
  docker-compose \
  awscli &&\
 wget https://releases.hashicorp.com/terraform/0.12.24/terraform_0.12.24_linux_amd64.zip &&\
 unzip terraform_0.12.24_linux_amd64.zip &&\
 mv terraform /usr/local/bin
 
USER jenkins
