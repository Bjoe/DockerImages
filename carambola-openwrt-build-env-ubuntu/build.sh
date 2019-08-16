#!/bin/bash

if [ ! `which docker-compose` ]; then
  echo "docker-compose is not installed. Please install docker-compose via: sudo apt-get install docker-compose"
  exit 1;
fi

unset DISTCLEAN CLEAN DOCKER_COMPOSE_TARGET DOCKER_HOME_DIR DOCKER_BUILD_DIR EXECUTE_SCRIPT BUILD_JOBS

export BASE_DIR="$( cd "$(dirname "${BASH_SOURCE[0]}" )" && pwd )"
export USER_ID="$(id -u)"
export GROUP_ID="$(id -g)"
export DOCKER_SOURCE_DIR=$BASE_DIR
export DOCKER_BUILD_DIR=$BASE_DIR/docker-build/build
export DOCKER_HOME_DIR=$BASE_DIR/docker-build/home

helpFunction()
{
   echo ""
   echo "Usage: $0 -b <build-type> [-d] [-c]" #  [-o <output-dir>] [-x <docker-home-dir>]"
   echo -e "\t-d Distclean: Cleans output and docker home directory"
   echo -e "\t-c Clean: Cleans output directory"
   echo -e "\t-r run script in docker"
   echo -e "\t-t docker build type"
   echo -e "\t-j build jobs"
   #echo -e "\t-o Output dir: Set build output directory (Default: $DOCKER_BUILD_DIR)"
   #echo -e "\t-x Docker home dir (Default: $DOCKER_HOME_DIR)"
   exit 1 # Exit script after printing help
}

while getopts "dcb:o:x:p:t:r:" opt
do
   case "$opt" in
      d ) DISTCLEAN=1 ;;
      c ) CLEAN=1 ;;
      r ) export EXECUTE_SCRIPT="$OPTARG" ;;
      t ) export DOCKER_COMPOSE_TARGET="$OPTARG" ;;
      j ) export BUILD_JOBS="$OPTARG" ;;
      #x ) export DOCKER_HOME_DIR="$OPTARG" ;;
      #o ) export DOCKER_BUILD_DIR="$OPTARG" ;;
      ? ) helpFunction ;; # Print helpFunction in case parameter is non-existent
   esac
done

if [ -p "$DOCKER_COMPOSE_TARGET" ]; then
  echo "No docker build type set. Set docker build type via -t. See docker-compose.yml"
  exit 1;
fi

if [ -n "$DISTCLEAN" ]
then
  echo "Delete $DOCKER_BUILD_DIR and $DOCKER_HOME_DIR directory, are you sure? (Y)"
  read -n 1 INPUT
  if [ "$INPUT" = "Y" ]
  then
    rm -rf $DOCKER_BUILD_DIR $DOCKER_HOME_DIR
  fi
fi

if [ -n "$CLEAN" ]
then
  echo "Delete $DOCKER_BUILD_DIR directory, are you sure? (Y)"
  read -n 1 INPUT
  if [ "$INPUT" = "Y" ]
  then
    rm -rf $DOCKER_BUILD_DIR 
  fi
fi

if [ ! -d $DOCKER_BUILD_DIR ]; then
    mkdir -p $DOCKER_BUILD_DIR
fi

if [ ! -d $DOCKER_HOME_DIR ]; then
    mkdir -p $DOCKER_HOME_DIR
fi

docker-compose -f $BASE_DIR/docker-compose.yml run $DOCKER_COMPOSE_TARGET /bin/bash /source/$EXECUTE_SCRIPT ${USER_ID} ${GROUP_ID} ${BUILD_JOBS} 2>&1 | tee $DOCKER_BUILD_DIR/$DOCKER_COMPOSE_TARGET-$BUILD_TYPE-build.log
#docker-compose -f $BASE_DIR/docker-compose.yml down