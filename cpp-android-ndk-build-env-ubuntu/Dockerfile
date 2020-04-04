FROM bojoe/cpp-build-env-ubuntu:latest
LABEL maintainer="Joerg-Christian Boehme <joerg@chaosdorf.de>"

USER root:root

ENV ANDROID_HOME /opt/androidSdk

# Install all build deps
RUN \
   apt-get update && \
   DEBIAN_FRONTEND="noninteractive" \
   apt-get -y upgrade --no-install-recommends && \
   DEBIAN_FRONTEND="noninteractive" \
    apt-get -y install --no-install-recommends \ 
    curl unzip openjdk-8-jdk \
    && \
    apt-get -q autoremove && apt-get -q clean && rm -rf /var/lib/apt/lists/* &&  rm -f /var/cache/apt/*.bin && \
    mkdir -p ${ANDROID_HOME} && \
  curl -L https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip > android-sdk.zip && \
  unzip -qq android-sdk.zip -d ${ANDROID_HOME} && rm -f android-sdk.zip && \
  mkdir -p /root/.android/ && touch /root/.android/repositories.cfg &&\
  mkdir -p ${ANDROID_HOME}/licenses
  
COPY android-sdk-license ${ANDROID_HOME}/licenses/
COPY android-sdk-preview-license ${ANDROID_HOME}/licenses/
COPY android-sdk-packages ${ANDROID_HOME}

RUN \
  chown -R root.root ${ANDROID_HOME} && \
  ${ANDROID_HOME}/tools/bin/sdkmanager --update && \
  while read -r package; do PACKAGES="${PACKAGES}${package} "; done < ${ANDROID_HOME}/android-sdk-packages && \
  echo -n "Installing SDK packages ....: ${PACKAGES}" && \
  ${ANDROID_HOME}/tools/bin/sdkmanager ${PACKAGES} && \
  yes | ${ANDROID_HOME}/tools/bin/sdkmanager --licenses && \
  ${ANDROID_HOME}/tools/bin/sdkmanager --list && \
  chmod 755 $ANDROID_HOME/tools/bin/avdmanager && \
  chown -R 1000.1000 /opt/androidSdk

  #  ${ANDROID_HOME}/tools/bin/sdkmanager --package_file=${ANDROID_HOME}/android-sdk-packages && Not working anymore!!!

USER 1000:1000
  
RUN \
  (echo no | $ANDROID_HOME/tools/bin/avdmanager create avd -n android-24-test -k "system-images;android-24;default;armeabi-v7a") && \
  (echo no | $ANDROID_HOME/tools/bin/avdmanager create avd -n android-arm64-24-test -k "system-images;android-24;default;arm64-v8a")

#EXPOSE 22
#
#CMD ["/usr/sbin/sshd", "-D"]
#
