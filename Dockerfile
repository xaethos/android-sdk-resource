FROM concourse/buildroot:curl-jq

ADD assets/ /opt/resource/
RUN chmod +x /opt/resource/*
