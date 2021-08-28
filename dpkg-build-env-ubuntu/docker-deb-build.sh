#!/bin/bash -x

if [ "$0" = "/source/docker-deb-build.sh" ]
then  
  echo "== STAGE 02 (installing build tools) ==" && \
  sudo apt-get update && \
  sudo apt-get -y upgrade && \
  sudo /usr/lib/pbuilder/pbuilder-satisfydepends-aptitude --control /source/qtwebkit-opensource-src-5.212.0~alpha2/debian/control && \
  echo "== STAGE 04 (extract sources) ==" && \
  cd /source && \
  dpkg-source -b qtwebkit-opensource-src-5.212.0~alpha2
  dpkg-source -x qtwebkit-opensource-src_5.212.0~alpha2-8ubuntu1.dsc /build/deb-build && \
  echo "== STAGE 04 (building package) ==" && \
  cd /build/deb-build && \
  sudo dpkg-buildpackage && \
  cd /build && \
  echo "+++ lintian output +++" && \
  find /build -name "*.changes" -exec lintian --pedantic --display-info {} \; && \
  echo "+++ end of lintian output +++"
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
--name deb-build \
--rm \
-e "SSH_AUTH_SOCK=$SSH_AUTH_SOCK" \
-i -t \
-v $DOCKER_HOME:/home/developer \
-v $SRC_DIR:/source \
-v $BUILD_DIR:/build \
-v /tmp:/tmp \
ubuntu-build-dpkg:latest \
/bin/bash /source/docker-deb-build.sh 2>&1 | tee $BUILD_DIR/docker-build.log

#--dns=8.8.8.8 \
