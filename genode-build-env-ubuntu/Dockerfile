FROM ubuntu:rolling

#FROM ubuntu:16.04
LABEL maintainer="Joerg-Christian Boehme <joerg@chaosdorf.de>"

USER root:root

# Install all build deps
RUN \
   apt-get update && \
   DEBIAN_FRONTEND="noninteractive" \
   apt-get -y upgrade --no-install-recommends && \
   DEBIAN_FRONTEND="noninteractive" \
    apt-get -y install --no-install-recommends \
    sudo \
    ca-certificates \
    gpgv2 \
    gpg \
    build-essential \
    make \
    libncurses-dev \
    libexpat1-dev \
    autogen \
    autoconf \
    autoconf2.64 \
    gnat \
    g++ \
    gperf \
    gcc \
    git \
    file \
    gdisk \
    expect \
    subversion \
    pkg-config \
    texinfo \
    wget \
    libxml2-utils \
    byacc \
    tcl \
    tclsh \
    xorriso \
    bison \
    flex \
    gawk \
    gprbuild \
    xsltproc \
    unzip \
    qemu-system \
    ccache \
    e2tools \
    qemu \
    # Needed for the host system -> qemu-system-x86 !!!
    # python 
    # python3 
    # python-future 
    # python-tempita 
    # python-ply 
    # python-six 
    # python3-pyparsing 
    && \
    apt-get -q autoremove && apt-get -q clean && rm -rf /var/lib/apt/lists/* &&  rm -f /var/cache/apt/*.bin && \
    # Add user and group
    groupadd -g 1000 developer && \
    useradd -m -c "Build user" -G sudo,video,plugdev -s /bin/bash -u 1000 -g 1000 developer && \
    echo "developer:developer" | chpasswd && \
    echo "%developer     ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers

USER 1000:1000
