#!/bin/bash -x

docker run \
--name dev-ui \
--rm \
-i -t \
-e "SSH_AUTH_SOCK=$SSH_AUTH_SOCK" \
-e "DISPLAY=$DISPLAY" \
-v $HOME:/home/developer \
-v $HOME:/home/$USER \
-v /tmp:/tmp \
ubuntu-build-XXXXX:2.0 \
/bin/bash

#--dns=8.8.8.8 \
