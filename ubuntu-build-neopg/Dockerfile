FROM ubuntu-build:latest
LABEL maintainer="Joerg-Christian Boehme <joerg@chaosdorf.de>"

USER root:root

# Install all build deps
RUN \
   apt-get update && \
   DEBIAN_FRONTEND="noninteractive" \
    apt-get -y install --no-install-recommends \
    #-y install -o Dpkg::Options::="--force-confnew" --no-install-recommends
    build-essential \
    libsqlite3-dev \
    libbotan-2-dev \
    libz-dev \
    bzip2 \
    gcovr \
    cppcheck \
    doxygen \
    lcov \
    libboost-date-time1.65-dev \
    libboost-locale-dev \
    libusb-1.0-0-dev \
    libbz2-dev \
    libgnutls28-dev \
    libcurl4-gnutls-dev \
    gettext \
    && \
    apt-get -q autoremove && apt-get -q clean && rm -rf /var/lib/apt/lists/* &&  rm -f /var/cache/apt/*.bin

USER 1000:1000
