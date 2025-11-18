FROM --platform=linux/amd64 jenkins/jenkins:latest

LABEL maintainer="cyganek.maxim@gmail.com"

ARG DEBIAN_FRONTEND=noninteractive
ENV JENKINS_UC_DOWNLOAD="https://mirror.yandex.ru/mirrors/jenkins"

# Установка плагинов
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

# Обновление и установка пакетов с улучшенной обработкой ошибок
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg2 \
        wget \
        software-properties-common && \
    mkdir -p /etc/ssh/ssh_config.d/ && \
    echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config && \
    echo "UserKnownHostsFile /dev/null" >> /etc/ssh/ssh_config && \
    apt-get clean && \
    rm -rf \
        /var/lib/apt/lists/* \
        /tmp/* \
        /var/tmp/* \
        /usr/share/man/* \
        /usr/share/doc/*

USER jenkins
