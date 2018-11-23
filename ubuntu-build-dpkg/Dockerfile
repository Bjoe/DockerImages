FROM ubuntu:18.04
LABEL maintainer="Joerg-Christian Boehme <joerg@chaosdorf.de>"

ENV DEBIAN_FRONTEND noninteractive

RUN \
  apt-get -y update && \
  apt-get -y upgrade && \
  apt-get -y --no-install-recommends install \
  devscripts pbuilder build-essential aptitude lintian \  
  # Some tools
  sudo tmux less vim lnav \
  && \
  apt-get -q autoremove && apt-get -q clean && rm -rf /var/lib/apt/lists/* &&  rm -f /var/cache/apt/*.bin && \
  # Add user and group
  groupadd -g 1000 developer && \
  useradd -m -c "Build user" -G sudo -s /bin/bash -u 1000 -g 1000 developer && \
  echo "developer:developer" | chpasswd && \
  echo "%developer     ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers

USER 1000:1000
