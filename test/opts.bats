#!/usr/bin/env bats

readonly vil=$BATS_TEST_DIRNAME/../vil

@test 'exit 0 at --help' {
  run "$vil" --help
  [[ $status == 0 ]]
  [[ $output != "" ]]
}

@test 'exit 0 at --version' {
  run "$vil" --version
  [[ $status == 0 ]]
  [[ $output != "" ]]
}

@test 'exit non-zero if specified the undefined option' {
  run "$vil" --startuptime
  [[ $status != 0 ]]
  [[ $output != "" ]]
}

@test '-n suppress output' {
  local src=$'aaa\nbbb\nccc'
  run "$vil" -n -e "" <(printf "%s\n" "$src")
  [[ $status == 0 ]]
  [[ $output == "" ]]
}

@test '-n, --silent, and --quiet are equal' {
  local src=$'aaa\nbbb\nccc'
  local with_n=$(printf "%s\n" "$src"      | "$vil" -n -e "")
  local with_silent=$(printf "%s\n" "$src" | "$vil" --silent -e "")
  local with_quiet=$(printf "%s\n" "$src"  | "$vil" --quiet -e "")
  [[ $with_n == $with_silent && $with_n == $with_quiet ]]
}

@test '"vil -e%sort" and "sort" are equal' {
  local src=$'bbb\nccc\naaa'
  local with_vil=$(printf "%s\n" "$src"  | "$vil" -e '%sort')
  local with_sort=$(printf "%s\n" "$src" | sort)
  [[ $with_vil == $with_sort ]]
}

@test '"vil -e%sort" and "vil %sort" are equal' {
  local src=$'bbb\nccc\naaa'
  local with_e=$(printf "%s\n" "$src"    | "$vil" -e '%sort')
  local without_e=$(printf "%s\n" "$src" | "$vil" '%sort')
  [[ $with_e == $without_e ]]
}

@test '-e and --expression are equal' {
  local src=$'bbb\nccc\naaa'
  local with_e=$(printf "%s\n" "$src"          | "$vil" -e '%sort')
  local with_expression=$(printf "%s\n" "$src" | "$vil" --expression '%sort')
  [[ $with_e == $with_expression ]]
}

@test '-e can specify multiple' {
  local src=$'bbb\nccc\naaa'
  local with_e=$(printf "%s\n" "$src"          | "$vil" -e '%sort|2,$d')
  local with_e_multiple=$(printf "%s\n" "$src" | "$vil" -e '%sort' -e '2,$d')
  [[ $with_e == $with_e_multiple ]]
}

@test '"vil -f <(printf "%s\n" %sort)" and "vil %sort" are equal' {
  local src=$'bbb\nccc\naaa'
  local with_f=$(printf "%s\n" "$src" | "$vil" -f <(printf "%s\n" '%sort'))
  local with_e=$(printf "%s\n" "$src" | "$vil" '%sort')
  [[ $with_f == $with_e ]]
}

@test '"vil -f <(printf "%s\n" %sort)" and "vil -e%sort" are equal' {
  local src=$'bbb\nccc\naaa'
  local with_f=$(printf "%s\n" "$src" | "$vil" -f <(printf "%s\n" '%sort'))
  local with_e=$(printf "%s\n" "$src" | "$vil" -e '%sort')
  [[ $with_f == $with_e ]]
}

@test '-f and --file are equal' {
  local src=$'aaa\nbbb\nccc'
  local with_f=$(printf "%s\n" "$src" | "$vil" -f <(printf "%s\n" '2,$d'))
  local with_file=$(printf "%s\n" "$src" | "$vil" --file <(printf "%s\n" '2,$d'))
  [[ $with_f == $with_file ]]
}

@test 'script is executed in the order in which user specify' {
  local src=$'aaa\nbbb\nccc\nddd\neee'
  local dst=$'bbb\nddd'
  run "$vil" -e 1d -f <(printf "%s\n" 2d) -e 3d <(printf "%s\n" "$src")
  [[ $status == 0 ]]
  [[ $output == $dst ]]
}

# vim: ft=sh
