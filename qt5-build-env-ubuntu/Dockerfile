FROM ubuntu-build:latest
LABEL maintainer="Joerg-Christian Boehme <joerg@chaosdorf.de>"

USER root:root

# Install all build deps
RUN \
   apt-get update && \
   DEBIAN_FRONTEND="noninteractive" \
    apt-get -y install --no-install-recommends \
    #-y install -o Dpkg::Options::="--force-confnew" --no-install-recommends
    # Trojia
    qt5-default \
    qmlscene \
    qttools5-dev-tools \
    libqt5svg5-dev \
    #libqt5webkit5-dev 
    qtdeclarative5-dev \
    libqt5serialport5-dev \
    qtscript5-dev \
    qt5keychain-dev \
    libmimetic-dev \
    ragel \
    libkf5sonnet-dev \
    libgpgmepp-dev \
    libgpg-error-dev \
    libgpgme-dev \
    zlib1g-dev \
    # CuteMarkEd
    #libqt5webkit5-dev 
    qttools5-dev-tools qt5-default \
    discount libmarkdown2-dev libhunspell-dev \
    && \
    apt-get -q autoremove && apt-get -q clean && rm -rf /var/lib/apt/lists/* &&  rm -f /var/cache/apt/*.bin

USER 1000:1000
