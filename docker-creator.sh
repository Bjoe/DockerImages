#!/bin/bash

DOCKER_IMAGE=bojoe/cpp-build-env-ubuntu:latest

if [ "$1" = "inside" ]
###############################################################################################################################################################################
# Execute inside the docker
###############################################################################################################################################################################
then
  sudo groupmod -g $3 developer
  sudo usermod -u $2 -g $3 developer
  sudo apt update
  # To start QtCreator inside the docker
  #libglvnd-dev libfreetype6 libfontconfig1 libxi6 libxkbcommon-x11-0 libxrender1 libdbus-1-dev
  sudo apt install libfreetype6 libfontconfig1 libxi6 libxkbcommon-x11-0 libxrender1 libdbus-1-dev libgl1-mesa-dri libgl1:amd64 #libglvnd-dev 
  # Need some GL driver .... from mesa or something else ...
  # libnvidia-gl-390:amd64
  # libgl1-mesa-dri
  # Some tools
  sudo apt install tmux less vim lnav
  /bin/bash
  exit 0;
fi
###############################################################################################################################################################################
###############################################################################################################################################################################
###############################################################################################################################################################################

USERID="$(id -u)"
GROUPID="$(id -g)"

DOCKER_SCRIPT="$(basename $0)"
CURRENT_DIR="$(pwd)"

docker run \
--name dev-creator \
--rm \
-i -t \
--net=host \
--privileged \
--cap-add=SYS_PTRACE --security-opt "seccomp=unconfined" \
-e "SSH_AUTH_SOCK=$SSH_AUTH_SOCK" \
-e "DISPLAY=$DISPLAY" \
--device=/dev/dri:/dev/dri \
-v /dev/bus/usb:/dev/bus/usb \
-v $HOME:/home/developer \
-v $HOME:/home/$USER \
-v /tmp:/tmp \
$DOCKER_IMAGE \
/bin/bash $CURRENT_DIR/$DOCKER_SCRIPT inside $USERID $GROUPID
