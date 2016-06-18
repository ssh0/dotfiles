#!/bin/bash
# written by Shotaro Fujimoto (https://github.com/ssh0)
# first edited: 2016-04-11
#=#=#=
# ```
# Name
#       autopep8_diff.sh - Show the difference between the original python file
#                          and the file created with autopep8 command.
#
# Usage
#       # Show diff
#       autopep8_diff.sh sample.py
#
#       # To see this help
#       autopep8_diff.sh -h
#
# Require
#       * autopep8 (can be installed with pip)
#       * (optionally) vimdiff
#       * (optionally) colordiff
# ```
#=#=

if [ $1 = '-h' ]; then
  sed -n '/^#=#=#=/,/^#=#=/p' $0 | sed -e '1d;$d' | cut -b3- | grep -v "\`\`\`"
  exit 0
fi

if [ "$1" = '-H' ]; then
  usage_all "$0"; exit 0
fi


if [ ! -f "$1" ]; then
  echo "[autopep8_diff.sh] '$1' is not a file or doesn't exist." >&2
  exit 1
fi

# You can choose prefer diff command
diffcmd="nvim -d"
# diffcmd="vimdiff"
# diffcmd="colordiff -u"
# diffcmd="diff -u"

$diffcmd "$1" <(autopep8 "$1")
