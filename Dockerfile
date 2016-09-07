FROM java:8-jdk

RUN mkdir -p /opt/resource \
    && curl -L "https://dl.google.com/android/android-sdk_r24.4.1-linux.tgz" \
    > /opt/resource/android-sdk-linux.tgz

RUN apt-get update \
    && apt-get install -y --no-install-recommends jq expect \
    && rm -rf /var/lib/apt/lists/*
