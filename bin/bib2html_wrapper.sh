#!/bin/sh
# written by Shotaro Fujimoto (https://github.com/ssh0)
# first edited: 2015-05-29

style='junsrt'
bibtex_command='pbibtex'
css="$HOME/Workspace/blog/styles/bootstrap-md.css"

dir=$(dirname "$1")
namewithext=$(basename "$1")
name=${namewithext%.*}

if [ -d "${dir}/html" ]; then
  output="${dir}/html/${name}"
else
  output="${dir}/${name}"
fi

bibtex2html -s "${style}" -c "${bibtex_command}" -css "${css}" -o "${output}" "$1"
