FROM ubuntu:17.10
LABEL maintainer="Joerg-Christian Boehme <joerg@chaosdorf.de>"

RUN \
  apt-get update && \
  DEBIAN_FRONTEND="noninteractive" \
  apt-get -y install wget sudo && \
  wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key|apt-key add -

COPY llvm.list /etc/apt/sources.list.d/llvm.list

# Install all build deps
RUN \
   apt-get update && \
   DEBIAN_FRONTEND="noninteractive" \
    apt-get -y install --no-install-recommends \ 
    #-y install -o Dpkg::Options::="--force-confnew" --no-install-recommends 
      openssh-server sudo \
      pkg-config make automake autoconf libtool \
      gcc-7 g++-7 gcc-5 g++-5 g++-arm-linux-gnueabi g++-arm-linux-gnueabihf libstdc++-7-dev libc++-dev \
      cmake git ninja-build clang-6.0 clang gcc g++ \
      && \
      #/usr/bin/redis-server &
      #/usr/bin/mongod --config /etc/mongodb.conf &
      apt-get -q autoremove && apt-get -q clean && rm -rf /var/lib/apt/lists/* &&  rm -f /var/cache/apt/*.bin && \
      # Add user and group
      groupadd -g 1000 developer && \
    useradd -m -c "Build user" -G sudo -s /bin/bash -u 1000 -g 1000 developer && \
    echo "developer:developer" | chpasswd && \
    echo "%developer     ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers
    
#EXPOSE 22
#
#CMD ["/usr/sbin/sshd", "-D"]
#
USER 1000:1000
