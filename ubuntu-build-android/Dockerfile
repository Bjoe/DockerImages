FROM ubuntu-build:1.0
LABEL maintainer="Joerg-Christian Boehme <joerg@chaosdorf.de>"

USER root:root

ENV ANDROID_HOME /opt/androidSdk

# Install all build deps
RUN \
   apt-get update && \
   DEBIAN_FRONTEND="noninteractive" \
    apt-get -y install --no-install-recommends \ 
    #-y install -o Dpkg::Options::="--force-confnew" --no-install-recommends 
      curl unzip openjdk-8-jdk \
      && \
      apt-get -q autoremove && apt-get -q clean && rm -rf /var/lib/apt/lists/* &&  rm -f /var/cache/apt/*.bin && \
    mkdir -p ${ANDROID_HOME} && \
  curl -L https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip > android-sdk.zip && \
  unzip -qq android-sdk.zip -d ${ANDROID_HOME} && rm -f android-sdk.zip && \
  mkdir -p /root/.android/ && touch /root/.android/repositories.cfg &&\
  mkdir -p ${ANDROID_HOME}/licenses
  
COPY android-sdk-license ${ANDROID_HOME}/licenses/
COPY android-sdk-preview-license ${ANDROID_HOME}/licenses/
COPY android-sdk-packages ${ANDROID_HOME}

RUN \
  chown -R root.root ${ANDROID_HOME} && \
  echo -n "Installing SDK packages ....: " && ${ANDROID_HOME}/tools/bin/sdkmanager --package_file=${ANDROID_HOME}/android-sdk-packages
  
#EXPOSE 22
#
#CMD ["/usr/sbin/sshd", "-D"]
#
USER 1000:1000
