FROM ubuntu:rolling
LABEL maintainer="Joerg-Christian Boehme <joerg@chaosdorf.de>"

RUN \
  apt-get update && \
  DEBIAN_FRONTEND="noninteractive" \
  apt-get -y upgrade --no-install-recommends && \
  DEBIAN_FRONTEND="noninteractive" \
  apt-get -y install wget sudo && \
  apt-get -y install --no-install-recommends \ 
  openssh-server sudo \
  pkg-config make automake autoconf libtool \
  mingw-w64 \
  cmake git ninja-build wine64 \
  && \
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
