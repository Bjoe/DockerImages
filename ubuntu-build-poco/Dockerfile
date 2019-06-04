FROM ubuntu-build:latest
LABEL maintainer="Joerg-Christian Boehme <joerg@chaosdorf.de>"

USER root:root

# Install all build deps
RUN \
   apt-get update && \
   DEBIAN_FRONTEND="noninteractive" \
   apt-get -y upgrade --no-install-recommends && \
   DEBIAN_FRONTEND="noninteractive" \
    apt-get -y install --no-install-recommends \ 
    #-y install -o Dpkg::Options::="--force-confnew" --no-install-recommends 
      libssl-dev \
#      libssl1.1-dbgsym 
#      openssl-dbgsym 
      unixodbc-dev \
      unixodbc-dbgsym \
      apache2-dev \
      apache2-bin-dbgsym \
      libapr1-dev \
      libapr1-dbg \
      libmysqlclient-dev \
      libmysqlclient20-dbgsym \
      libpq-dev \
      libpq5-dbgsym \
      # POCO_UNBUNDLED
      libpcre3-dev \
      libpcre3-dbg \
      zlib1g-dev \
      zlib1g-dbg \
      libsqlite3-dev \
      libsqlite3-0-dbgsym \
      && \
      #/usr/bin/redis-server &
      #/usr/bin/mongod --config /etc/mongodb.conf &
      apt-get -q autoremove && apt-get -q clean && rm -rf /var/lib/apt/lists/* &&  rm -f /var/cache/apt/*.bin
    
#EXPOSE 22
#
#CMD ["/usr/sbin/sshd", "-D"]
#
USER 1000:1000
