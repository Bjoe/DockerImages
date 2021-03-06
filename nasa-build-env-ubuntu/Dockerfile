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
    # For QML
    libglvnd-dev mesa-common-dev \
    # Some dev
    libssl-dev libpcsclite-dev libudev-dev \
    && \
    apt-get -y -q autoremove && apt-get -y -q clean && rm -rf /var/lib/apt/lists/* &&  rm -f /var/cache/apt/*.bin

USER 1000:1000
