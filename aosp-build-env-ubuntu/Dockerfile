FROM ubuntu:18.04
LABEL maintainer="Joerg-Christian Boehme <joerg@chaosdorf.de>"

USER root:root

# Install all build deps
RUN \
   apt-get update && \
   DEBIAN_FRONTEND="noninteractive" \
   apt-get -y upgrade --no-install-recommends && \
   DEBIAN_FRONTEND="noninteractive" \
    apt-get -y install --no-install-recommends \
    sudo curl ccache \
    # For AOSP
    repo git-core gnupg flex bison build-essential zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 libncurses5 \
    lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z1-dev libgl1-mesa-dev libxml2-utils xsltproc unzip fontconfig \
    && \
    apt-get -q autoremove && apt-get -q clean && rm -rf /var/lib/apt/lists/* &&  rm -f /var/cache/apt/*.bin && \
    # Add user and group
    groupadd -g 1000 developer && \
    useradd -m -c "Build user" -G sudo,video,plugdev -s /bin/bash -u 1000 -g 1000 developer && \
    echo "developer:developer" | chpasswd && \
    echo "%developer     ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers

USER 1000:1000
