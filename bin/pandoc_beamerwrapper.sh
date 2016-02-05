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
  cat "$f" | nl -w3 -s- -nln -d'#=' -ha -bn -fn \
    | grep -ve '^\s\+' | cut -b7- | grep -v "\`\`\`"
}

if [ "$1" = "-h" ]; then
  usage
  exit 0
fi

pandoc -t beamer --template=mytemplate "$@"
