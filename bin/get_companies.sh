#!/bin/sh

PATTERN=$(cut -f $1 $2 \
  | awk 'NF' \
  | tr '\n' '|' \
  | sed 's/|$//' \
  | sed 's/(/\\(/g'\
  | sed 's/)/\\)/g'\
  | bin/upcase.sh
)

grep -E "^($PATTERN)" $3
