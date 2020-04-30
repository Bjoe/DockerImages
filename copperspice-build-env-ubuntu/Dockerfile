FROM bojoe/cpp-build-env-ubuntu:latest
LABEL maintainer="Joerg-Christian Boehme <joerg@chaosdorf.de>"

USER root:root

# Install all build deps
RUN \
   apt-get update && \
   DEBIAN_FRONTEND="noninteractive" \
   apt-get -y upgrade --no-install-recommends && \
   DEBIAN_FRONTEND="noninteractive" \
    apt-get -y install --no-install-recommends \
                libfreetype6-dev libfontconfig1-dev libglib2.0-dev libgstreamer1.0-dev \
                libgstreamer-plugins-base1.0-dev libice-dev libaudio-dev libgl1-mesa-dev libc6-dev \
                libsm-dev libxcursor-dev libxext-dev libxfixes-dev libxi-dev libxinerama-dev \
                libxrandr-dev libxrender-dev libxkbcommon-dev libxkbcommon-x11-dev libx11-dev \
                libxcb1-dev libx11-xcb-dev libxcb-icccm4-dev libxcb-image0-dev libxcb-keysyms1-dev \
                libxcb-render0-dev libxcb-render-util0-dev libxcb-randr0-dev libxcb-shape0-dev \
                libxcb-shm0-dev libxcb-sync-dev libxcb-xfixes0-dev libxcb-xinerama0-dev libxcb-xkb-dev
     && \
    apt-get -q autoremove && apt-get -q clean && rm -rf /var/lib/apt/lists/* &&  rm -f /var/cache/apt/*.bin

USER 1000:1000
