FROM ubuntu:rolling
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
      gcc-10 g++-10 \
      g++-arm-linux-gnueabi g++-arm-linux-gnueabihf \
      gcc-avr binutils-avr avr-libc avrdude \
      gdb gdbserver cgdb gdb-avr \
      libstdc++-10-dev \
      # Clang and co
      clang-format-12 clang-tidy-12 clang-tools-12 libc++-12-dev libc++1-12 libc++abi-12-dev libc++abi1-12 libclang-12-dev libclang1-12 liblldb-12-dev libclang-common-12-dev \
      # static analyzer
      cppcheck iwyu \
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
