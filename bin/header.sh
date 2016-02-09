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

nl --number-width=3 --number-separator='' --number-format='ln' \
   --section-delimiter='#=' --header-numbering='a' --body-numbering='n' \
   --footer-numbering='n' "$1" \
  | grep -ve '^\s\+' \
  | cut -b6-

