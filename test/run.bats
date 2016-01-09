#!/usr/bin/env bats

readonly vil="$BATS_TEST_DIRNAME/../vil"

@test "can execute" {
  run test -x "$vil"
  [[ $status == 0 ]]
}
