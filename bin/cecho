#!/bin/bash
#=#=#=
# cecho - colorized echo
#
# **Usage**
#
# ```
# cecho blue "Hello world!"
# ```
#=#=

if [ "$1" = '-h' ]; then
  usage_all "$0"
  exit 0
fi

case $1 in
  red) color=31 ;;
  green) color=32 ;;
  yellow) color=33 ;;
  blue) color=34 ;;
  magenta) color=35 ;;
  cyan) color=36 ;;
  *) return 1 ;;
esac
shift
echo -e "\033[${color}m$@\033[m"

