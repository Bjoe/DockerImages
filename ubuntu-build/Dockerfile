FROM ubuntu:18.04
LABEL maintainer="Joerg-Christian Boehme <joerg@chaosdorf.de>"

RUN \
  apt-get update && \
  DEBIAN_FRONTEND="noninteractive" \
  apt-get -y install gnupg2 wget sudo && \
  wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key|apt-key add -

COPY llvm.list /etc/apt/sources.list.d/llvm.list

# Install all build deps
RUN \
   apt-get update && \
   DEBIAN_FRONTEND="noninteractive" \
    apt-get -y install --no-install-recommends \ 
    #-y install -o Dpkg::Options::="--force-confnew" --no-install-recommends 
      openssh-server python python3 \
      pkg-config make automake autoconf libtool bear \
      cmake git ninja-build   \
      gcc g++ libstdc++-7-dev \
      gcc-7 g++-7 gcc-5 g++-5 g++-arm-linux-gnueabi g++-arm-linux-gnueabihf \
      gdb gdbserver libcc1-0 cgdb \
      clang libc++-dev libc++abi-dev \
      clang-6.0 clang-tools-6.0 clang-format-6.0 python-clang-6.0 lldb-6.0 lld-6.0 \
      #clang-7 clang-tools-7 clang-format-7 python-clang-7 lldb-7 lld-7 libc++-7-dev libc++abi-7-dev \
      #clang-8 clang-tools-8 clang-format-8 python-clang-8 lldb-8 lld-8 libc++-8-dev libc++abi-8-dev \      
      # To start QtCreator inside the docker
      libglvnd-dev libfreetype6 libfontconfig1 libxi6 libxkbcommon-x11-0 libxrender1 libdbus-1-dev \
      # Some tools
      tmux less vim lnav \
    && \
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
