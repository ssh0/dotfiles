#!/bin/bash
# written by Shotaro Fujimoto (https://github.com/ssh0)
# first edited: 2015-06-26

usage (){
  cat << EOF

NAME
      pandoc_latexwrapper - pandoc wrapper for converting to latex

USAGE
      pandoc_latexwrapper [-h] [pandoc's options] INPUTFILE(or stdin)

OPTION
      -h: Show this help message.

EOF
}

if [ "$1" = "-h" ]; then
  usage
  exit 0
fi

pandoc -t latex --template=mytemplate "$@"
