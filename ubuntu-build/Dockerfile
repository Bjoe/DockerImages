FROM ubuntu:rolling
LABEL maintainer="Joerg-Christian Boehme <joerg@chaosdorf.de>"

RUN \
  apt-get update && \
  DEBIAN_FRONTEND="noninteractive" \
  apt-get -y install ubuntu-dbgsym-keyring gnupg2 wget sudo && \
  wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key|apt-key add -

COPY llvm.list /etc/apt/sources.list.d/llvm.list
COPY ddebs.list /etc/apt/sources.list.d/ddebs.list

# Install all build deps
RUN \
   apt-get update && \
   DEBIAN_FRONTEND="noninteractive" \
    apt-get -y install --no-install-recommends \ 
    #-y install -o Dpkg::Options::="--force-confnew" --no-install-recommends 
      openssh-server python python3 \
      pkg-config make automake autoconf libtool bear \
      cmake git ninja-build   \
      gcc g++ \
      gcc-7 g++-7 \
      gcc-8 g++-8 \
      gcc-9 g++-9 \
      g++-arm-linux-gnueabi g++-arm-linux-gnueabihf \
      gdb gdbserver libcc1-0 cgdb \
      libstdc++-7-dev libstdc++-8-dev libstdc++-9-dev \
      clang clang-tools libclang-common-8-dev libclang-8-dev libclang1 clang-format python-clang lldb lld libc++-dev libc++abi-dev \
      # Clang and co
      # clang-7 clang-tools-7 clang-7-doc libclang-common-7-dev libclang-7-dev libclang1-7 clang-format-7 python-clang-7
      # lldb
      # lldb-7
      # lld (linker)
      # lld-7
      # libc++
      # libc++-7-dev libc++abi-7-dev
      # To start QtCreator inside the docker
      libglvnd-dev libfreetype6 libfontconfig1 libxi6 libxkbcommon-x11-0 libxrender1 libdbus-1-dev \
      # Need some GL driver .... from mesa or something else ...
      libnvidia-gl-390:amd64 \
      # Some tools
      tmux less vim lnav curl p7zip-full \
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
