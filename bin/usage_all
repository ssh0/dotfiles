#!/bin/bash
#=#=#=
# ```
# NAME
#       usage_all - Show all usage written in 'header' part of a script
#
# SYNOPSYS
#       usage_all <script_file_path>
#
# DEPENDENCE
#       * pandoc
#       * w3m
# ```
#=#=

# __browser="w3m"
# __browser="lynx"
# __browser="firefox -new-tab"
# __browser="${BROWSER:-x-www-browser}"
__browser="${BROWSERCLI:-www-browser}"

if [ $# != 1 ]; then
  echo "[usage_all] One argument (file path) is needed (given $#)." >&2
  exit 1
fi

f="$1"
scriptname="$(basename $f)"

if ! hash pandoc 2> /dev/null; then
  echo "[usage_all] pandoc is not installed in this computer." >&2
  exit 1
fi

sed -n '/^#=#=#=/,/^#=#=/p' $f | sed -e '1d;$d' | cut -b3- \
  | pandoc -f markdown -t html - -o "/tmp/${scriptname}_help.html"
${__browser} "/tmp/${scriptname}_help.html"
rm "/tmp/${scriptname}_help.html"

