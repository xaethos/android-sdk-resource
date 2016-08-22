FROM concourse/buildroot:curl-tar

ADD assets/ /opt/resource/
RUN chmod +x /opt/resource/*
