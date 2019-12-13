FROM bojoe/cpp-build-env-ubuntu:latest
LABEL maintainer="Joerg-Christian Boehme <joerg@chaosdorf.de>"

USER root:root

# Install all build deps
RUN \
   apt-get update && \
   DEBIAN_FRONTEND="noninteractive" \
   apt-get -y upgrade --no-install-recommends && \
   DEBIAN_FRONTEND="noninteractive" \
    apt-get -y install --no-install-recommends \
     doxygen graphviz qt4-dev-tools \
     qt4-default \
     libsqlite3-dev \
     libboost-dev \
     libboost-thread-dev \
     libboost-filesystem-dev \
     libboost-program-options-dev \
     libgraphicsmagick++1-dev \
     libfcgi-dev \
     firebird-dev \
     unixodbc-dev \
     libunwind-dev \
     libhpdf-dev \
     libpango1.0-dev \
     libmysqlclient-dev \
     libpq-dev \
     libssl-dev \
     zlib1g-dev \
     libglvnd-core-dev \
     libglew-dev \
     mesa-common-dev \
     libx11-dev \
     && \
    apt-get -q autoremove && apt-get -q clean && rm -rf /var/lib/apt/lists/* &&  rm -f /var/cache/apt/*.bin

USER 1000:1000
