#!/bin/bash -x

if [ "$0" = "/source/docker-build.sh" ]
then
  cmake -H/source -B/build -GNinja -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/home/developer/opt && cmake --build /build --target install
  /bin/bash
  exit 0;
fi

BASE_DIR="$( cd "$(dirname "${BASH_SOURCE[0]}" )" && pwd )"

SRC_DIR=${BASE_DIR}
BUILD_DIR=$SRC_DIR/docker-base/build
DOCKER_HOME=$SRC_DIR/docker-base/home

if [ "$1" = "-clean" ]; then
  rm -fr $BUILD_DIR
fi
mkdir -p $BUILD_DIR
mkdir $DOCKER_HOME

cp -R ~/.ssh $DOCKER_HOME

docker run \
--name source-build \
--rm \
-e "SSH_AUTH_SOCK=$SSH_AUTH_SOCK" \
-i -t \
-v $DOCKER_HOME:/home/developer \
-v $SRC_DIR:/source \
-v $BUILD_DIR:/build \
-v /tmp:/tmp \
ubuntu-build-xxxx:latest \
/bin/bash /source/docker-build.sh 2>&1 | tee $BUILD_DIR/docker-build.log

#--dns=8.8.8.8 \
