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

@test "'vil -e%sort' and 'sort' are equal" {
  local src=$'bbb\nccc\naaa'
  local with_vil="$(echo "$src"  | "$vil" -e '%sort')"
  local with_sort="$(echo "$src" | sort)"
  [[ $with_vil == $with_sort ]]
}

@test "'vil -e%sort' and 'vil %sort' are equal" {
  local src=$'bbb\nccc\naaa'
  local with_e="$(echo "$src"    | "$vil" -e '%sort')"
  local without_e="$(echo "$src" | "$vil" '%sort')"
  [[ $with_e == $without_e ]]
}

@test "-e and --expression are equal" {
  local src=$'bbb\nccc\naaa'
  local with_e="$(echo "$src"          | "$vil" -e '%sort')"
  local with_expression="$(echo "$src" | "$vil" --expression '%sort')"
  [[ $with_e == $with_expression ]]
}

@test "-e can specify multiple" {
  local src=$'bbb\nccc\naaa'
  local with_e="$(echo "$src"          | "$vil" -e '%sort|2,$d')"
  local with_e_multiple="$(echo "$src" | "$vil" -e '%sort' -e '2,$d')"
  [[ $with_e == $with_e_multiple ]]
}
