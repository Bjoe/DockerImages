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
      openssh-server \
      pkg-config cmake git ninja-build \
      clang-6.0 \
      libssl-dev \
      unixodbc-dev \
      apache2-dev \
      libapr1-dev \
      zlib1g-dev \
      libpcre3-dev \
      libexpat1-dev \
      libsqlite3-dev \
      mongodb-server \
      redis-server \
      libmysqlclient-dev \
      mysql-server \
      postgresql-server-dev-9.6 \
      && \
      #/usr/bin/redis-server &
      #/usr/bin/mongod --config /etc/mongodb.conf &
      apt-get -q autoremove && apt-get -q clean && rm -rf /var/lib/apt/lists/* &&  rm -f /var/cache/apt/*.bin && \
      # Add user and group
      groupadd -g 1000 builduser && \
    useradd -m -c "Build user" -G sudo -s /bin/bash -u 1000 -g 1000 builduser && \
    echo "builduser:builduser" | chpasswd
    
#EXPOSE 22
#
#CMD ["/usr/sbin/sshd", "-D"]
#
USER 1000:1000
