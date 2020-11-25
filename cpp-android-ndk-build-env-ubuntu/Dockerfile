FROM ubuntu:rolling
LABEL maintainer="Joerg-Christian Boehme <joerg@chaosdorf.de>"

USER root:root

ENV ANDROID_HOME /opt/androidSdk
ENV ANDROID_NDK_HOME /opt/androidSdk/ndk/android-ndk-r22-beta1
ENV PATH="/opt/androidSdk/cmake/3.10.2.4988404/bin:${PATH}"

# Install all build deps
RUN \
   apt-get update && \
   DEBIAN_FRONTEND="noninteractive" \
   apt-get -y upgrade --no-install-recommends && \
   DEBIAN_FRONTEND="noninteractive" \
    apt-get -y install --no-install-recommends \ 
    curl unzip openjdk-8-jdk \
    && \
    apt-get -y -q autoremove && apt-get -y -q clean && rm -rf /var/lib/apt/lists/* &&  rm -f /var/cache/apt/*.bin && \
    mkdir -p ${ANDROID_HOME}/ndk
RUN \
  curl -L https://dl.google.com/android/repository/commandlinetools-linux-6858069_latest.zip > android-sdk.zip && \
  curl -L https://dl.google.com/android/repository/android-ndk-r22-beta1-linux-x86_64.zip > android-ndk-beta.zip && \
  unzip -qq android-sdk.zip -d ${ANDROID_HOME} && rm -f android-sdk.zip && \
  unzip -qq android-ndk-beta.zip -d ${ANDROID_HOME} && rm -f android-ndk-beta.zip && \
  mkdir -p /root/.android/ && touch /root/.android/repositories.cfg &&\
  mkdir -p ${ANDROID_HOME}/licenses
  
COPY android-sdk-license ${ANDROID_HOME}/licenses/
COPY android-sdk-preview-license ${ANDROID_HOME}/licenses/
COPY android-sdk-packages ${ANDROID_HOME}

RUN \
  chown -R root.root ${ANDROID_HOME} && \
  ${ANDROID_HOME}/cmdline-tools/bin/sdkmanager --sdk_root=${ANDROID_HOME} --update && \
  while read -r package; do PACKAGES="${PACKAGES}${package} "; done < ${ANDROID_HOME}/android-sdk-packages && \
  echo -n "Installing SDK packages ....: ${PACKAGES}" && \
  ${ANDROID_HOME}/cmdline-tools/bin/sdkmanager --sdk_root=${ANDROID_HOME} ${PACKAGES} && \
  yes | ${ANDROID_HOME}/cmdline-tools/bin/sdkmanager --sdk_root=${ANDROID_HOME} --licenses && \
  ${ANDROID_HOME}/cmdline-tools/bin/sdkmanager --sdk_root=${ANDROID_HOME} --list && \
  chmod 755 $ANDROID_HOME/tools/bin/avdmanager && \
  chown -R 1000.1000 /opt/androidSdk

  #  ${ANDROID_HOME}/tools/bin/sdkmanager --package_file=${ANDROID_HOME}/android-sdk-packages && Not working anymore!!!

    # Add user and group
RUN \
    groupadd -g 1000 developer && \
    useradd -m -c "Build user" -G sudo,video,audio,plugdev -s /bin/bash -u 1000 -g 1000 developer && \
    echo "developer:developer" | chpasswd && \
    echo "%developer     ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers

USER 1000:1000

COPY docker-entrypoint.sh /home/developer

RUN \
  chmod +x /home/developer/docker-entrypoint.sh && \
  (echo no | $ANDROID_HOME/tools/bin/avdmanager create avd -n android-26-test -k "system-images;android-26;default;x86_64")
  # && \
  # (echo no | $ANDROID_HOME/tools/bin/avdmanager create avd -n android-29-test -k "system-images;android-29;default;x86_64")


#EXPOSE 22
#
#CMD ["/usr/sbin/sshd", "-D"]
#
ENTRYPOINT ["/home/developer/docker-entrypoint.sh"] 