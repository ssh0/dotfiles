#!/bin/bash
# written by Shotaro Fujimoto (https://github.com/ssh0)
#=#=#=
# ```
# NAME
#       header.sh - Print the 'header part' of the file.
#
# USAGE
#       header.sh [-h] <file>
#
# REMARK
#       'header part' starts with "#=#=#=" and ends with "#=#="
#       Needs space after each '#'
# ```
#=#=

if [ "$1" = "-h" ]; then
  # print usage
  $0 $0 | grep -v "\`\`\`"
  exit 0
fi

sed -n '/^#=#=#=/,/^#=#=/p' "$1" | sed -e '1d;$d' | cut -b3-

