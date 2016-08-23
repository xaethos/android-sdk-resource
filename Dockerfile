FROM java:8-jdk

RUN apt-get update && \
    apt-get install -y --no-install-recommends jq && \
    rm -rf /var/lib/apt/lists/*

COPY archives/android-sdk-linux.tgz /opt/

COPY var/ /var/opt/resource/
COPY assets/ /opt/resource/
RUN chmod +x /opt/resource/*
