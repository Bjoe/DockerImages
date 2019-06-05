FROM ubuntu-build:latest
LABEL maintainer="Joerg-Christian Boehme <joerg@chaosdorf.de>"

USER root:root

# Install all build deps
RUN \
   apt-get update && \
   DEBIAN_FRONTEND="noninteractive" \
    apt-get -y install --no-install-recommends \
    #-y install -o Dpkg::Options::="--force-confnew" --no-install-recommends
     doxygen graphviz qt4-dev-tools \
     qt4-default \
     libsqlite3-dev \
     libboost1.65-dev \
     libboost-thread1.65-dev \
     libboost-filesystem1.65-dev \
     libboost-program-options1.65-dev \
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