#!/bin/bash -x

groupmod -g $1 developer
usermod -u $1 -g $2 developer

su developer -c "SSH_AUTH_SOCK=$SSH_AUTH_SOCK bash"

# Following the instruction from https://www.8devices.com/wiki/carambola2:build

su developer -c "SSH_AUTH_SOCK=$SSH_AUTH_SOCK \
cd /source/source \
./scripts/feeds update -a \
./scripts/feeds install -a \
cp config_minimal .config \
make defconfig \
make menuconfig \
reset \
make -j$3"

su developer -c "SSH_AUTH_SOCK=$SSH_AUTH_SOCK bash"
