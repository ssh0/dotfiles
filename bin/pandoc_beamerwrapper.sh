#!/bin/bash
# written by Shotaro Fujimoto (https://github.com/ssh0)
# first edited: 2015-07-19

usage (){
  cat << EOF

NAME
      pandoc_beamerwrapper - pandoc wrapper for converting to beamer

USAGE
      pandoc_beamerwrapper [-h] [pandoc's options] INPUTFILE(or stdin)

OPTION
      -h: Show this help message.

EOF
}

if [ "$1" = "-h" ]; then
  usage
  exit 0
fi

pandoc -t beamer --template=mytemplate "$@"
