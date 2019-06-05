FROM bojoe/cpp-build-env-ubuntu:latest
LABEL maintainer="Joerg-Christian Boehme <joerg@chaosdorf.de>"

ENV TERM=xterm-256color

USER root:root

# Install all build deps
RUN \
   apt-get update && \
   DEBIAN_FRONTEND="noninteractive" \
   apt-get -y upgrade --no-install-recommends && \
   DEBIAN_FRONTEND="noninteractive" \
    apt-get -y install --no-install-recommends \
    qtbase5-dev \
    qttools5-dev \
    qttools5-dev-tools \
    libqt5svg5-dev \
    libgcrypt20-dev \
    libargon2-0-dev \
    libqrencode-dev \
    zlib1g-dev \
    # optional dependencies
    libxi-dev \
    libxtst-dev \
    libqt5x11extras5-dev \
    libyubikey-dev \
    libykpers-1-dev \
    libsodium-dev \
    libcurl4-openssl-dev \
    && \
    apt-get -q autoremove && apt-get -q clean && rm -rf /var/lib/apt/lists/* &&  rm -f /var/cache/apt/*.bin

USER 1000:1000
