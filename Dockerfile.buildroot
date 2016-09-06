FROM java:8-jdk

RUN apt-get update && \
    apt-get install -y --no-install-recommends jq expect && \
    rm -rf /var/lib/apt/lists/*

RUN curl -L "https://dl.google.com/android/android-sdk_r24.4.1-linux.tgz" \
    > /opt/android-sdk-linux.tgz
