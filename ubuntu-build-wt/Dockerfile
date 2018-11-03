FROM ubuntu-build:2.0
LABEL maintainer="Joerg-Christian Boehme <joerg@chaosdorf.de>"

USER root:root

# Install all build deps
RUN \
   apt-get update && \
   DEBIAN_FRONTEND="noninteractive" \
    apt-get -y install --no-install-recommends \
    #-y install -o Dpkg::Options::="--force-confnew" --no-install-recommends
     doxygen \
     graphviz \
     libsqlite3-dev \
     qt4-dev-tools \
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
     && \
    apt-get -q autoremove && apt-get -q clean && rm -rf /var/lib/apt/lists/* &&  rm -f /var/cache/apt/*.bin

USER 1000:1000
