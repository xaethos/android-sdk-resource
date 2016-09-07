FROM xaethos/android-sdk-resource:buildroot

COPY assets/ /opt/resource/

ENTRYPOINT ["/bin/sh"]
