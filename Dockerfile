FROM java:8-jdk

RUN apt-get update && \
    apt-get install -y --no-install-recommends jq && \
    rm -rf /var/lib/apt/lists/*

COPY assets/*.tgz /opt/
COPY assets/resource/ /opt/resource/
RUN chmod +x /opt/resource/*
