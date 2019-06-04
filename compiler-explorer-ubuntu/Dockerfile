FROM ubuntu-build:latest
LABEL maintainer="Joerg-Christian Boehme <joerg@chaosdorf.de>"

# See https://github.com/jtsylve/compiler-explorer-docker
# and https://github.com/madduci/docker-compiler-explorer

USER root:root

COPY run-ce.sh /

RUN \
   apt-get update && \
   DEBIAN_FRONTEND="noninteractive" \
    apt-get -y install --no-install-recommends \
    nodejs \
    npm \
    xz-utils \
  && \
    apt-get -q autoremove && apt-get -q clean && rm -rf /var/lib/apt/lists/* &&  rm -f /var/cache/apt/*.bin && \
    mkdir -p /opt/compilers && cd /opt/compilers && \
    wget -O - https://s3.amazonaws.com/compiler-explorer/opt/gcc-7.3.0.tar.xz | tar Jxf - && \
    wget -O - https://s3.amazonaws.com/compiler-explorer/opt/gcc-8.1.0.tar.xz | tar Jxf - && \
    wget -O - https://s3.amazonaws.com/compiler-explorer/opt/clang-6.0.0.tar.xz | tar Jxf - && \
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
    sed -i '/compilers=/c\compilers=\/usr\/bin\/g++-4.9:\/usr\/bin\/g++-5:\/usr\/bin\/g++-6:\/usr\/bin\/g++-7:\/usr\/bin\/g++-8:\/usr\/bin\/clang++-3.8:\/usr\/bin\/clang++-3.9:\/usr\/bin\/clang++-4.0:\/usr\/bin\/clang++-5.0:\/usr\/bin\/clang++-6.0' etc/config/c++.defaults.properties && \
    sed -i '/defaultCompiler=/c\defaultCompiler=\/usr\/bin\/clang++-6.0' etc/config/c++.defaults.properties
    
COPY *.properties /opt/compiler-explorer/etc/config/

EXPOSE 10240
ENTRYPOINT /run-ce.sh
