#!/bin/bash
# written by Shotaro Fujimoto (https://github.com/ssh0)
# first edited: 2015-06-26

show_usage (){
  echo "pandoc_latexwrapper: pandoc wrapper for converting to latex"
  echo "Usage: pandoc_latexwrapper [-h] [pandoc's options] INPUTFILE(or stdin)"
  echo ""
  echo "Option:"
  echo "  -h: Show this help message."
  echo ""
}

if [ "$1" = "-h" ]; then
  show_usage
  exit 0
fi

pandoc -t latex --template=mytemplate "$@"
