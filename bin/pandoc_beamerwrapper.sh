#!/bin/bash
# written by Shotaro Fujimoto (https://github.com/ssh0)
# first edited: 2015-07-19

show_usage (){
  echo "pandoc_beamerwrapper: pandoc wrapper for converting to beamer"
  echo "Usage: pandoc_beamerwrapper [-h] [pandoc's options] INPUTFILE(or stdin)"
  echo ""
  echo "Option:"
  echo "  -h: Show this help message."
  echo ""
}

if [ "$1" = "-h" ]; then
  show_usage
  exit 0
fi

pandoc -t beamer --template=mytemplate "$@"
