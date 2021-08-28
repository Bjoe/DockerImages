#!/bin/bash

if [ ! `which docker-compose` ]; then
  echo "docker-compose is not installed. Please install docker-compose via: sudo apt-get install docker-compose"
  exit 1;
fi

unset DISTCLEAN CLEAN CMAKE_BUILD_TYPE DOCKER_BUILD EXECUTE_SCRIPT

export BASE_DIR="$( cd "$(dirname "${BASH_SOURCE[0]}" )" && pwd )"
export USER_ID="$(id -u)"
export GROUP_ID="$(id -g)"

#if [ ! -f "$BASE_DIR/../cleanup-build.sh" ]; then
#    cp "$BASE_DIR/cleanup-build.sh" "$BASE_DIR/../cleanup-build.sh"
#fi

helpFunction()
{
   echo ""
   echo "Usage: $0 -b <build-type> [-d] [-c]" #  [-o <output-dir>] [-x <docker-home-dir>]"
   echo -e "\t-d Distclean: Cleans output and docker home directory"
   echo -e "\t-c Clean: Cleans output directory"
   echo -e "\t-b Build type: Set build type Release, Debug, RelWithDebInfo (see CMAKE_BUILD_TYPE)"
   echo -e "\t-t docker build type"
   echo -e "\t-r run script in docker"
   #echo -e "\t-o Output dir: Set build output directory (Default: $BUILD_DIR)"
   exit 1 # Exit script after printing help
}

while getopts "dcb:o:x:t:r:" opt
do
   case "$opt" in
      d ) DISTCLEAN=1 ;;
      c ) CLEAN=1 ;;
      b ) export CMAKE_BUILD_TYPE="$OPTARG" ;;
      t ) export DOCKER_BUILD="$OPTARG" ;;
      r ) export EXECUTE_SCRIPT="$OPTARG" ;;
      #o ) export BUILD_DIR="$OPTARG" ;;
      ? ) helpFunction ;; # Print helpFunction in case parameter is non-existent
   esac
done

# Print helpFunction in case parameters are empty
if [ "$DOCKER_BUILD" != "do-android-build" -a -z "$CMAKE_BUILD_TYPE" ]
then
   echo "No build type are set. Set build type via -b to Release, Debug or RelWithDebInfo (see CMAKE_BUILD_TYPE)";
   exit 1;
fi

if [ -p "$DOCKER_BUILD" ]; then
  echo "No docker build type set. Set docker build type via -t. See docker-compose.yml"
  exit 1;
fi

if [ -n "$DISTCLEAN" ]
then
  echo "Delete $BUILD_DIR directory, are you sure? (Y)"
  read -n 1 INPUT
  if [ "$INPUT" = "Y" ]
  then
    rm -rf "$BUILD_DIR"
  fi
fi

if [ -n "$CLEAN" ]
then
  echo "Delete $BUILD_DIR directory, are you sure? (Y)"
  read -n 1 INPUT
  if [ "$INPUT" = "Y" ]
  then
    rm -rf "$BUILD_DIR"
  fi
fi

if [ ! -d "$BUILD_DIR" ]; then
    mkdir -p "$BUILD_DIR"
fi

echo "Build environment                       - $DOCKER_BUILD -"
echo "Build project as (CMAKE_BUILD_TYPE)     - $CMAKE_BUILD_TYPE -"
echo "Build output you can found in           - $BUILD_DIR -"
echo "Source directory                        - $SOURCE_DIR -"
echo "Execute script inside the docker        - $EXECUTE_SCRIPT -"

export USER_ID=$(id -u ${USER})
export GROUP_ID=$(id -g ${USER})
export CMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
docker-compose -f "$BASE_DIR/docker-compose.yml" run --rm "$DOCKER_BUILD" "/home/${PROJECT_NAME}-src/build-env/setup-build-env.sh" "/home/${PROJECT_NAME}-src/$EXECUTE_SCRIPT" 2>&1 | tee "$BUILD_DIR/$DOCKER_BUILD-$CMAKE_BUILD_TYPE-build.log"
