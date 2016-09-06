#!/bin/bash
set -euo pipefail
source $(dirname $0)/common.sh

CHECK=${1:-}
[ -x "$CHECK" ] || fail "Usage: $0 path/to/check"

assert_in_path jq

test_empty() {
  local output=$(jq -n '{}' | "$CHECK" | jq -c .)
  assert_equal '[{"components":"platform-tools"}]' "$output"
}

test_components() {
  local output=$(jq -n '{source: {components: ["z","a"]}}' | "$CHECK" | jq -c .)
  assert_equal '[{"components":"a,platform-tools,z"}]' "$output"
}

test_unique() {
  local output=$(jq -n '{source: {components: ["foo","platform-tools","foo"]}}' | "$CHECK" | jq -c .)
  assert_equal '[{"components":"foo,platform-tools"}]' "$output"
}

test_empty
test_components
test_unique

echo $(mk_temp_dir)
