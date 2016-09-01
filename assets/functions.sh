SDK_SOURCE=/opt/android-sdk-linux.tgz

function fail {
  echo "error: $*"
  exit 1
}

function extractSdk {
  tar --no-same-owner --strip-components 1 -C "$1" -xzf $SDK_SOURCE
}

function sdkInstall {
  local ANDROID_HOME="$1"
  [ -d $ANDROID_HOME ] || fail "expected sdk directory: $ANDROID_HOME"

  local ANDROID="$ANDROID_HOME/tools/android"
  [ -x $ANDROID ] || fail "not executable: $ANDROID"

  echo y | "$ANDROID" update sdk --no-ui --all --force --filter $2
}
