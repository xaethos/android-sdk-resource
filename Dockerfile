FROM xaethos/android-sdk-resource:buildroot-24.4.1

COPY assets/ /opt/resource/
RUN chmod +x /opt/resource/*
