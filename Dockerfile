FROM beevelop/android

ENV NODEJS_VERSION=12.21.0 \
    PATH=$PATH:/opt/node/bin

WORKDIR "/opt/node"

RUN mkdir -p /root/.android && touch /root/.android/repositories.cfg && \
    yes | $ANDROID_SDK_ROOT/tools/bin/sdkmanager "platform-tools" "build-tools;${ANDROID_BUILD_TOOLS_VERSION}" && \
    yes | $ANDROID_SDK_ROOT/tools/bin/sdkmanager "platforms;android-25" "platforms;android-26" "platforms;android-27" "platforms;android-28" "platforms;android-29" "platforms;android-30"

#RUN yes | $ANDROID_SDK_ROOT/tools/bin/sdkmanager "extras;android;m2repository" "extras;google;google_play_services" "extras;google;instantapps" "extras;google;m2repository"
#RUN yes | $ANDROID_SDK_ROOT/tools/bin/sdkmanager "add-ons;addon-google_apis-google-22" "add-ons;addon-google_apis-google-23" "add-ons;addon-google_apis-google-24"


RUN apt-get update && apt-get install -y curl git ca-certificates --no-install-recommends && \
    curl -sL https://nodejs.org/dist/v${NODEJS_VERSION}/node-v${NODEJS_VERSION}-linux-x64.tar.gz | tar xz --strip-components=1 && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean
