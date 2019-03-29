#!/bin/bash -x

if [ "$0" = "/source/docker-build.sh" ]
then
  cd source/source && \
  tool/tool_chain MAKE_JOBS=15 x86 && \
  tool/create_builddir x86_64 BUILD_DIR=/build/x86_64
  cd /build/x86_64
  make KERNEL=nova run/demo
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
--name genode-build \
--rm \
-i -t \
--privileged \
--cap-add=SYS_PTRACE --security-opt "seccomp=unconfined" \
-e "SSH_AUTH_SOCK=$SSH_AUTH_SOCK" \
-e "DISPLAY=$DISPLAY" \
--device=/dev/dri:/dev/dri \
-v /dev/bus/usb:/dev/bus/usb \
-v $DOCKER_HOME:/home/developer \
-v $HOME:$HOME \
-v $SRC_DIR:/source \
-v $BUILD_DIR:/build \
-v /tmp:/tmp \
ubuntu-build-genode:latest \
/bin/bash /source/docker-build.sh 2>&1 | tee $BUILD_DIR/docker-build.log

#--dns=8.8.8.8 \
