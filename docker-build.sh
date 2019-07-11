#!/bin/bash -x

DOCKER_IMAGE=bojoe/cpp-build-env-ubuntu:latest

if [ "$1" = "inside" ]
###############################################################################################################################################################################
# Execute inside the docker
###############################################################################################################################################################################
then
  sudo groupmod -g $3 developer
  sudo usermod -u $2 -g $3 developer
  cmake -H/source -B/build -GNinja -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/home/developer/opt && cmake --build /build --target install
  /bin/bash
  exit 0;
fi
###############################################################################################################################################################################
###############################################################################################################################################################################
###############################################################################################################################################################################

BASE_DIR="$( cd "$(dirname "${BASH_SOURCE[0]}" )" && pwd )"
USERID="$(id -u)"
GROUPID="$(id -g)"

SRC_DIR=${BASE_DIR}
BUILD_DIR=$SRC_DIR/docker-base/build
DOCKER_HOME=$SRC_DIR/docker-base/home

if [ ! `which docker` ]; then
  echo "docker is not installed. Please install docker via: sudo apt-get install docker.io"
  exit 1;
fi

x=`id -nG  | grep -c docker`
if [ $x -eq 0 ]; then
  echo "$USER does not belong to docker group. Execute: \nsudo usermod -a -G docker $USER\n and login again"
  exit 1;
fi

if [ -z "`docker images -q $DOCKER_IMAGE`" ]
then
  echo "Docker image $DOCKER_IMAGE is missing. Try to pull ..."
  docker pull $DOCKER_IMAGE
fi

if [ "$1" = "-clean" ]; then
  rm -fr $BUILD_DIR
fi
mkdir -p $BUILD_DIR

if [[ ! -d $DOCKER_HOME ]]; then
  mkdir $DOCKER_HOME
fi

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
$DOCKER_IMAGE \
/bin/bash /source/$0 inside $USERID $GROUPID 2>&1 | tee $BUILD_DIR/docker-build.log

#--dns=8.8.8.8 \
