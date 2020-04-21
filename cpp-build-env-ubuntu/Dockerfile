FROM ubuntu:rolling
LABEL maintainer="Joerg-Christian Boehme <joerg@chaosdorf.de>"

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
      ccache cmake git ninja-build   \
      gcc g++ \
      gcc-7 g++-7 \
      gcc-8 g++-8 \
      gcc-9 g++-9 \
      g++-arm-linux-gnueabi g++-arm-linux-gnueabihf \
      gcc-avr binutils-avr avr-libc avrdude \
      gdb gdbserver libcc1-0 cgdb gdb-avr lsb-release \
      libstdc++-8-dev \
      libstdc++-9-dev \
      clang-tools-10 clang-tidy-10 \
      libclang-common-10-dev libclang-10-dev \
      libclang1-10 \
      clang-format-10 \
      #python-clang-10
      libc++-10-dev libc++abi-10-dev \
    && \
    /tmp/configure-alternatives-compilers.sh && \
    rm /tmp/configure-alternatives-compilers.sh /tmp/llvm.sh && \
    apt-get -q autoremove && apt-get -q clean && rm -rf /var/lib/apt/lists/* &&  rm -f /var/cache/apt/*.bin && \
    # Add user and group
    groupadd -g 1000 developer && \
    useradd -m -c "Build user" -G sudo,video,plugdev -s /bin/bash -u 1000 -g 1000 developer && \
    echo "developer:developer" | chpasswd && \
    echo "%developer     ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers
    
#EXPOSE 22
#
#CMD ["/usr/sbin/sshd", "-D"]
#
USER 1000:1000
