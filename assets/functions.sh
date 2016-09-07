ASSETS_DIR="$(dirname "${BASH_SOURCE[0]}")"
SDK_ARCHIVE="$ASSETS_DIR/android-sdk-linux.tgz"

function fail {
  echo "$*"
  exit 1
}

function is_directory {
  [ -d "$1" ]
}

function is_not_empty {
  [ -n "$1" ]
}

function extract_sdk {
  is_directory "$1" || fail "expected sdk destination: $1"
  tar --no-same-owner --strip-components 1 -C "$1" -xzf $SDK_ARCHIVE
}

function sdk_install {
  is_directory "$1" || fail "expected sdk directory: $1"
  is_not_empty "$2" || fail "Usage: $FUNCNAME path/to/sdk componentspec"
  ANDROID_HOME="$1" "$ASSETS_DIR/android-sdk-install" $2
}
