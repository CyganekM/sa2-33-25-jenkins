FROM --platform=linux/amd64 jenkins/jenkins:latest

LABEL maintainer="cyganek.maxim@gmail.com"

ENV JENKINS_UC_DOWNLOAD="https://mirror.yandex.ru/mirrors/jenkins"

# Install plugins
RUN jenkins-plugin-cli --plugins \
    ssh-slaves \
    ansible \
    email-ext \
    mailer \
    greenballs \
    simple-theme-plugin \
    parameterized-trigger \
    rebuild \
    github \
    kubernetes \
    ansicolor \
    blueocean \
    stashNotifier \
    show-build-parameters \
    credentials \
    configuration-as-code \
    command-launcher \
    external-monitor-job \
    ssh-agent \
    pipeline-stage-view \
    slack

USER root

# Install packages with proper error handling
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg2 \
        wget \
        software-properties-common && \
    echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config && \
    echo "UserKnownHostsFile /dev/null" >> /etc/ssh/ssh_config && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

USER jenkins
