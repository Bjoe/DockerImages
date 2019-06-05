FROM bojoe/cpp-build-env-ubuntu:latest
LABEL maintainer="Joerg-Christian Boehme <joerg@chaosdorf.de>"

USER root:root

# Install all build deps
RUN \
   apt-get update && \
   DEBIAN_FRONTEND="noninteractive" \
   apt-get -y upgrade --no-install-recommends && \
   DEBIAN_FRONTEND="noninteractive" \
    apt-get -y install --no-install-recommends \
    #-y install -o Dpkg::Options::="--force-confnew" --no-install-recommends
    doxygen graphviz qttools5-dev-tools \
    libsqlite3-dev \
    libz-dev \
    libbz2-dev \
    liblzma-dev \
    libboost-dev \
    libboost-exception-dev \
    libboost-filesystem-dev \
    libssl-dev \
    && \
    apt-get -q autoremove && apt-get -q clean && rm -rf /var/lib/apt/lists/* &&  rm -f /var/cache/apt/*.bin

USER 1000:1000
