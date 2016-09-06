fail() {
  printf "$@" >&2
  exit 1
}

assert_equal() {
  local expected="$1"
  local actual="$2"
  [ "$expected" = "$actual" ] || fail "Expected: '%s'\nGot: '%s'" "$expected" "$actual"
}

assert_in_path() {
  [ -x $(which $1) ] || fail "$1 must be in PATH"
}

mk_temp_dir() {
  local dir=$(mktemp -d -t ${1:-test})
  if [ -d "$dir" ]
  then trap "rm -rf '$dir'" EXIT
  else fail "Couldn't create temp dir"
  fi
  echo "$dir"
}
