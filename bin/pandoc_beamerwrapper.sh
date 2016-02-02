#!/bin/bash
# written by Shotaro Fujimoto (https://github.com/ssh0)
#=#=#=
# ```
# NAME
#       pandoc_beamerwrapper - pandoc wrapper for converting to beamer
# 
# USAGE
#       pandoc_beamerwrapper [-h] [pandoc's options] INPUTFILE(or stdin)
# 
# OPTION
#       -h: Show this help message.
# ```
#=#=

f="$0"
usage (){
  header.sh "$f" | grep -v "\`\`\`"
}

if [ "$1" = "-h" ]; then
  usage
  exit 0
fi

pandoc -t beamer --template=mytemplate "$@"
