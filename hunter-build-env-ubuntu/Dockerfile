FROM ubuntu-build:latest
LABEL maintainer="Joerg-Christian Boehme <joerg@chaosdorf.de>"

USER root:root

COPY requirements.txt /tmp/requirements.txt

# Install all build deps
RUN \
   apt-get update && \
   DEBIAN_FRONTEND="noninteractive" \
    apt-get -y install --no-install-recommends \
    python3-pip \
    && \
    pip install -r requirements.txt \
    && \
    apt-get -q autoremove && apt-get -q clean && rm -rf /var/lib/apt/lists/* &&  rm -f /var/cache/apt/*.bin && rm /tmp/requirements.txt

USER 1000:1000
