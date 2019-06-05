FROM ubuntu-build:rolling
LABEL maintainer="Joerg-Christian Boehme <joerg@chaosdorf.de>"

# See https://github.com/jtsylve/compiler-explorer-docker
# and https://github.com/madduci/docker-compiler-explorer

USER root:root

COPY run-ce.sh /

RUN \
  apt-get update && \
  DEBIAN_FRONTEND="noninteractive" apt-get -y upgrade && \
  DEBIAN_FRONTEND="noninteractive" \
  apt-get -y install ubuntu-dbgsym-keyring gnupg2 wget && \
  wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key|apt-key add -

COPY llvm.list /etc/apt/sources.list.d/llvm.list

RUN \
   DEBIAN_FRONTEND="noninteractive" \
    apt-get -y install --no-install-recommends \
    gcc g++ \
    gcc-7 g++-7 \
    gcc-8 g++-8 \
    gcc-9 g++-9 \
    g++-arm-linux-gnueabi \
    g++-arm-linux-gnueabihf \
    clang \
    nodejs \
    npm \
    xz-utils \
  && \
    apt-get -q autoremove && apt-get -q clean && rm -rf /var/lib/apt/lists/* &&  rm -f /var/cache/apt/*.bin && \
    mkdir -p /opt/compilers && cd /opt/compilers && \
    #wget -O - https://s3.amazonaws.com/compiler-explorer/opt/gcc-7.3.0.tar.xz | tar Jxf - &&
    #wget -O - https://s3.amazonaws.com/compiler-explorer/opt/gcc-8.1.0.tar.xz | tar Jxf - && 
    #wget -O - https://s3.amazonaws.com/compiler-explorer/opt/clang-6.0.0.tar.xz | tar Jxf - && 
    mkdir -p /opt/compiler-explorer && \
    chown 1000 /opt/compiler-explorer && \
    chmod +x /run-ce.sh

USER 1000:1000

RUN \
    cd /opt/compiler-explorer && \
    git clone \
    https://github.com/mattgodbolt/compiler-explorer.git . && \
    . ~/.profile && \
    make prereqs && \
    sed -i '/compilers=/c\compilers=\/usr\/bin\/g++:\/usr\/bin\/g++-9:\/usr\/bin\/g++-7:\/usr\/bin\/g++-8:\/usr\/bin\/clang++' etc/config/c++.defaults.properties && \
    sed -i '/defaultCompiler=/c\defaultCompiler=\/usr\/bin\/clang++' etc/config/c++.defaults.properties
    
COPY *.properties /opt/compiler-explorer/etc/config/

EXPOSE 10240
ENTRYPOINT /run-ce.sh
