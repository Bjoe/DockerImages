FROM ubuntu:20.04
#FROM ubuntu:rolling <- llvm.sh/clang has not yet the latest ubuntu
LABEL maintainer="Joerg-Christian Boehme <joerg@chaosdorf.de>"

ENV DEVUSER developer

RUN \
  apt-get update && \
  DEBIAN_FRONTEND="noninteractive" apt-get -y upgrade && \
  DEBIAN_FRONTEND="noninteractive" \
  apt-get -y install ubuntu-dbgsym-keyring gnupg2 wget software-properties-common lsb-release sudo && \
  cd /tmp && wget https://apt.llvm.org/llvm.sh && chmod +x /tmp/llvm.sh && \
  /tmp/llvm.sh
# /tmp/llvm.sh <version number>
#  wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key|apt-key add -

#COPY llvm.list /etc/apt/sources.list.d/llvm.list
COPY ddebs.list /etc/apt/sources.list.d/ddebs.list
COPY configure-alternatives-compilers.sh /tmp

# Install all build deps
RUN \
   apt-get update && \
   DEBIAN_FRONTEND="noninteractive" \
    apt-get -y install --no-install-recommends \ 
      openssh-server python python3 curl p7zip-full \
      pkg-config make automake autoconf libtool bear \
      ccache distcc distcc-pump cmake git ninja-build \
      gcc g++ \
      gcc-9 g++-9 \
      gcc-10 g++-10 \
      g++-arm-linux-gnueabi g++-arm-linux-gnueabihf \
      gcc-avr binutils-avr avr-libc avrdude \
      gdb gdbserver libcc1-0 cgdb gdb-avr lsb-release \
      libstdc++-9-dev \
      libstdc++-10-dev \
      # Clang and co
      clang-11 clang-tools-11 libclang-common-11-dev libclang-11-dev libclang1-11 clang-format-11 clangd-11 \
    && \
    /tmp/configure-alternatives-compilers.sh && \
    rm /tmp/configure-alternatives-compilers.sh /tmp/llvm.sh && \
    apt-get -y -q autoremove && apt-get -y -q clean && rm -rf /var/lib/apt/lists/* &&  rm -f /var/cache/apt/*.bin && \
    # Add user and group
    groupadd -g 1000 ${DEVUSER} && \
    useradd -m -c "Build user" -G sudo,video,audio,plugdev -s /bin/bash -u 1000 -g 1000 ${DEVUSER} && \
    echo "${DEVUSER}:${DEVUSER}" | chpasswd && \
    echo "%${DEVUSER}     ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers
    
#EXPOSE 22
#
#CMD ["/usr/sbin/sshd", "-D"]
#
USER 1000:1000
