#!/bin/bash -x

QTCREATOR_VERSION=4.9/4.9.0

if [ "$0" = "/source/docker-build.sh" ]
then
    export PATH="/home/jboehme/opt/Qt/5.12.3/gcc_64/bin:$PATH"
    cd /source/source
    if [ ! -d "qt-src" ]; then
        curl -fsSL "http://download.qt.io/official_releases/qtcreator/$QTCREATOR_VERSION/installer_source/linux_gcc_64_rhel72/qtcreator_dev.7z" -o qt-dev.7z
        7z x -y qt-dev.7z -o"qt-src"
        rm qt-dev.7z
    fi
    if [ -x "$(command -v qmake-qt5)" ]; then
        export QMAKE=qmake-qt5
    elif [ -x "$(command -v qmake)" ]; then
        export QMAKE=qmake
    else
        echo "Neither qmake nor qmake-qt5 found"
        /bin/bash
        exit 0;
    fi
    $QMAKE qtc-sourcetrail.pro -r "QTC_SOURCE=qt-src" "QTC_BUILD=/home/jboehme/opt/Qt/Tools/QtCreator/lib/qtcreator" "LIBS+=-L/home/jboehme/opt/Qt/Tools/QtCreator/lib/qtcreator" "OUTPUT_PATH=/home/jboehme/opt/Qt/Tools/QtCreator/lib/qtcreator/plugins/"
    make clean && make
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

if [[ ! -d $DOCKER_HOME ]]; then
  mkdir $DOCKER_HOME
fi

cp -R ~/.ssh $DOCKER_HOME

docker run \
--name qtc-sourcetrail-build \
--rm \
-e "SSH_AUTH_SOCK=$SSH_AUTH_SOCK" \
-i -t \
-v $DOCKER_HOME:/home/developer \
-v /home/data:/home/data \
-v $SRC_DIR:/source \
-v $BUILD_DIR:/build \
-v /tmp:/tmp \
ubuntu-build:latest \
/bin/bash /source/docker-build.sh 2>&1 | tee $BUILD_DIR/docker-build.log

#--dns=8.8.8.8 \
