FROM bojoe/cpp-build-env-ubuntu:latest
LABEL maintainer="Joerg-Christian Boehme <joerg@chaosdorf.de>"

USER root:root

COPY requirements.txt /tmp/requirements.txt

# Install all build deps
RUN \
   apt-get update && \
   DEBIAN_FRONTEND="noninteractive" \
    apt-get -y install --no-install-recommends \
    unzip \
    python-setuptools \
    python-enchant \
    python-pip \
    python3-pip && \
    pip3 install --user requests && \
    pip3 install --user gitpython && \
    pip install -r /tmp/requirements.txt && \
    apt-get -q autoremove && apt-get -q clean && rm -rf /var/lib/apt/lists/* &&  rm -f /var/cache/apt/*.bin && rm /tmp/requirements.txt

USER 1000:1000
