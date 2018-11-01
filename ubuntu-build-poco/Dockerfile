FROM ubuntu-build:2.0
LABEL maintainer="Joerg-Christian Boehme <joerg@chaosdorf.de>"

USER root:root

# Install all build deps
RUN \
   apt-get update && \
   DEBIAN_FRONTEND="noninteractive" \
    apt-get -y install --no-install-recommends \ 
    #-y install -o Dpkg::Options::="--force-confnew" --no-install-recommends 
      libssl-dev \
      unixodbc-dev \
      apache2-dev \
      libapr1-dev \
      zlib1g-dev \
      libmysqlclient-dev \
      libpq-dev \
      && \
      #/usr/bin/redis-server &
      #/usr/bin/mongod --config /etc/mongodb.conf &
      apt-get -q autoremove && apt-get -q clean && rm -rf /var/lib/apt/lists/* &&  rm -f /var/cache/apt/*.bin
    
#EXPOSE 22
#
#CMD ["/usr/sbin/sshd", "-D"]
#
USER 1000:1000
