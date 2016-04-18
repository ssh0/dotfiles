#!/bin/bash
# written by Shotaro Fujimoto (https://github.com/ssh0)
# first edited: 2015-06-26
#=#=#=
# ```
# NAME
#       pandoc_latexwrapper - pandoc wrapper for converting to latex
#
# USAGE
#       pandoc_latexwrapper [-h] [pandoc's options] INPUTFILE(or stdin)
#
# OPTION
#       -h: Show this help message.
# ```
#=#=

f="$0"
usage (){
  sed -n '/^#=#=#=/,/^#=#=/p' $f | sed -e '1d;$d' | cut -b3- | grep -v "\`\`\`"
}

if [ "$1" = "-h" ]; then
  usage
  exit 0
elif [ "$1" = "-H" ]; then
  usage_all "$f"
  exit 0
fi

pandoc -t latex --template=mytemplate "$@"
