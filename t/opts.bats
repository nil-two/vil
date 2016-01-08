#!/usr/bin/env bats

readonly vil="$BATS_TEST_DIRNAME/../vil"

@test "exit 0 at --help" {
  run "$vil" --help
  [[ $status == 0 ]]
  [[ $output != '' ]]
}

@test "exit 0 at --version" {
  run "$vil" --version
  [[ $status == 0 ]]
  [[ $output != '' ]]
}

@test "-n suppress output" {
  local src=$'aaa\nbbb\nccc'
  run "$vil" -n -e '' <(echo "$src")
  [[ $status == 0 ]]
  [[ $output == '' ]]
}

@test "-n, --silent, and --quiet are equal" {
  local src=$'aaa\nbbb\nccc'
  local with_n="$(echo "$src"      | "$vil" -n -e '')"
  local with_silent="$(echo "$src" | "$vil" --silent -e '')"
  local with_quiet="$(echo "$src"  | "$vil" --quiet -e '')"
  [[ $with_n == $with_silent && $with_n == $with_quiet ]]
}
