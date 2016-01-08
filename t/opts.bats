#!/usr/bin/env bats

readonly vil="$BATS_TEST_DIRNAME/../vil"

@test "exit 0 at --help" {
  run "$vil" --help
  [[ "$status" == 0 ]]
  [[ "$output" != '' ]]
}

@test "exit 0 at --version" {
  run "$vil" --version
  [[ "$status" == 0 ]]
  [[ "$output" != '' ]]
}
