#!/usr/bin/env bats

readonly vil="$BATS_TEST_DIRNAME/../vil"

@test "can execute" {
  run test -x "$vil"
  [[ $status == 0 ]]
}

@test "show usage if there is no arguments" {
  run "$vil"
  [[ $status != 0 ]]
  [[ $output != '' ]]
}
