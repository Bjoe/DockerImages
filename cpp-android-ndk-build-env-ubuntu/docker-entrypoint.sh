#!/bin/bash

echo "Android SDK found in ${ANDROID_HOME}"
echo "Android NDK found in ${ANDROID_NDK_HOME}"
echo -n "CMake found in "
which cmake
cmake --version
echo -n "Ninja found in "
which ninja
echo -n "Ninja version "
ninja --version
echo "Android NDK version:"
cat ${ANDROID_NDK_HOME}/source.properties
echo "Supported Android platforms:"
ls ${ANDROID_HOME}/platforms/

cd $HOME

#set -e # exit on failure
#set -x # trace for debug
/bin/bash -e