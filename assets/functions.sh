ASSETS_DIR=$(dirname "${BASH_SOURCE[0]}")
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

  ANDROID_HOME="$ANDROID_HOME" "$ASSETS_DIR/android-sdk-install" $2
}
