FROM ubuntu:16.04
LABEL maintainer="Joerg-Christian Boehme <joerg@chaosdorf.de>"

USER root:root

# Install all build deps
RUN \
   apt-get update && \
   DEBIAN_FRONTEND="noninteractive" \
    apt-get -y install --no-install-recommends \
    #-y install -o Dpkg::Options::="--force-confnew" --no-install-recommends
    sudo ca-certificates make libncurses-dev libexpat1-dev autogen autoconf2.64 \
    gnat-5 g++ gcc git file expect subversion pkg-config texinfo wget libxml2-utils tcl \
    xorriso bison flex gawk \
    # Needed for the host system -> qemu-system-x86 !!!
    # libsdl2-dev byacc gperf xsltproc 
    # To start QtCreator inside the docker
    libgl1-mesa-glx \
    #libglvnd-dev on 18.04
    libfreetype6 libfontconfig1 libxi6 libxkbcommon-x11-0 libxrender1 libdbus-1-dev \
    # Some tools
    tmux less vim lnav \
    && \
    apt-get -q autoremove && apt-get -q clean && rm -rf /var/lib/apt/lists/* &&  rm -f /var/cache/apt/*.bin && \
    # Add user and group
    groupadd -g 1000 developer && \
    useradd -m -c "Build user" -G sudo,video,plugdev -s /bin/bash -u 1000 -g 1000 developer && \
    echo "developer:developer" | chpasswd && \
    echo "%developer     ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers

USER 1000:1000
