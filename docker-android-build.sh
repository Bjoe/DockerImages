#!/bin/bash -x

if [ "$0" = "/source/docker-android-build.sh" ]
then
  #
  #/opt/androidSdk/cmake/3.6.4111459/bin/cmake -G'Android Gradle - Ninja'
  #/opt/androidSdk/cmake/3.10.2.4988404/bin/cmake -GNinja
  #
  # Toolchain are similar and looks like outdated:
  #/opt/androidSdk/cmake/3.6.4111459/android.toolchain.cmake
  #/opt/androidSdk/cmake/3.10.2.4988404/android.toolchain.cmake
  #
  # Use current NDK toolchain instead:
  #/opt/androidSdk/ndk/19.2.5345600/build/cmake/android.toolchain.cmake
  #
  cmake -H/source -B/build -GNinja \
  -DCMAKE_TOOLCHAIN_FILE=/opt/androidSdk/ndk/19.2.5345600/build/cmake/android.toolchain.cmake \
  -DANDROID_ABI=arm64-v8a \
  -DANDROID_NATIVE_API_LEVEL=24 \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=/home/developer/android && \
  cmake --build /build --target install
  /bin/bash
  exit 0;
fi

BASE_DIR="$( cd "$(dirname "${BASH_SOURCE[0]}" )" && pwd )"

SRC_DIR=${BASE_DIR}
BUILD_DIR=$SRC_DIR/docker-base/build-android
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
--name source-build \
--rm \
-e "SSH_AUTH_SOCK=$SSH_AUTH_SOCK" \
-i -t \
-v $DOCKER_HOME:/home/developer \
-v $SRC_DIR:/source \
-v $BUILD_DIR:/build \
-v /tmp:/tmp \
ubuntu-build-android:latest \
/bin/bash /source/docker-android-build.sh 2>&1 | tee $BUILD_DIR/docker-android-build.log

#--dns=8.8.8.8 \
