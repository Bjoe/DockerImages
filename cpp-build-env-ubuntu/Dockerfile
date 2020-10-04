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
      ccache cmake git ninja-build \
      gcc g++ \
      gcc-9 g++-9 \
      gcc-10 g++-10 \
      g++-arm-linux-gnueabi g++-arm-linux-gnueabihf \
      gcc-avr binutils-avr avr-libc avrdude \
      gdb gdbserver libcc1-0 cgdb gdb-avr lsb-release \
      libstdc++-9-dev \
      libstdc++-10-dev \
      # default Clang
      clang-format clang-tidy clang-tools clang clangd libc++-dev libc++1 libc++abi-dev libc++abi1 libclang-dev libclang1 liblldb-dev libllvm-ocaml-dev libomp-dev libomp5 lld lldb llvm-dev llvm-runtime llvm python-clang \
      # Clang 11
      clang-11 lldb-11 lld-11 \
    && \
    /tmp/configure-alternatives-compilers.sh && \
    rm /tmp/configure-alternatives-compilers.sh /tmp/llvm.sh && \
    apt-get -q autoremove && apt-get -q clean && rm -rf /var/lib/apt/lists/* &&  rm -f /var/cache/apt/*.bin && \
    # Add user and group
    groupadd -g 1000 developer && \
    useradd -m -c "Build user" -G sudo,video,audio,plugdev -s /bin/bash -u 1000 -g 1000 developer && \
    echo "developer:developer" | chpasswd && \
    echo "%developer     ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers
    
#EXPOSE 22
#
#CMD ["/usr/sbin/sshd", "-D"]
#
USER 1000:1000
