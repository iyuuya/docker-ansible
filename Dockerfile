FROM ubuntu:16.04
LABEL maintainer "Yuya Ito <i.yuuya@gmail.com>"

ENV PYENV_ROOT="/opt/pyenv" \
    PATH="/opt/pyenv/bin:/opt/pyenv/shims:$PATH"

RUN apt update && apt install -y --no-install-recommends \
    build-essential \
    ca-certificates \
    curl \
    git \
    libbz2-dev \
    libncurses5-dev \
    libncursesw5-dev \
    libreadline-dev \
    libsqlite3-dev \
    libssl-dev \
    llvm \
    make \
    netbase \
    pkg-config \
    wget \
    xz-utils \
    zlib1g-dev \
    openssh-client \
    locales \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
 && echo "ja_JP UTF-8" > /etc/locale.gen \
 && locale-gen
ENV LANG ja_JP.UTF-8

COPY ./bin/setup /tmp/setup
COPY ./.python-version /tmp/.python-version
COPY ./requirements.txt /tmp/requirements.txt

RUN git clone --single-branch --depth 1 https://github.com/pyenv/pyenv.git $PYENV_ROOT \
 && git clone --single-branch --depth 1 https://github.com/pyenv/pyenv-virtualenv.git $PYENV_ROOT/plugins/pyenv-virtualenv \
 && cd /tmp \
 && sh setup \
 && rm -rf /tmp/* \
 && echo 'PATH=/opt/pyenv/bin:/opt/pyenv/shims:$PATH' >> ~/.bashrc \
 && echo 'eval "$(pyenv init -)"' >> ~/.bashrc

CMD /bin/bash --login

# vim: ft=dockerfile
