#!/bin/bash
set -euo pipefail
source $(dirname $0)/common.sh

OUT=${1:-}
[ -x "$OUT" ] || fail "Usage: $0 path/to/out"

test_fails() {
  set +eo pipefail
  $(jq -n '{source: {components: ["z","a"]}}' | "$OUT" 2>/dev/null)
  [ $? -ne 0 ] || fail "Expected script failure"
  set -eo pipefail
}

test_fails
