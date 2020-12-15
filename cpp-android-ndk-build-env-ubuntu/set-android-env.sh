#!/bin/bash

echo "Android SDK ANDROID_HOME found in ${ANDROID_HOME}"
echo "Android NDK ANDROID_NDK_HOME found in ${ANDROID_NDK_HOME}"

export PATH="${ANDROID_HOME}/cmake/3.10.2.4988404/bin:${PATH}"

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
ls ${ANDROID_HOME}/platforms

if [ "$GITHUB_ACTIONS" = true -a "$CI" = true ]; then

    echo "Start on Github ... looping"
    tail -f /dev/null

else

    cd $HOME
    #set -e # exit on failure
    #set -x # trace for debug
    /bin/bash -e -c "$@"
fi
