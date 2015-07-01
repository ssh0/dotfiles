#!/bin/sh
# written by Shotaro Fujimoto (https://github.com/ssh0)
# first edited: 2015-05-29

style='junsrt'
bibtex_command='pbibtex'
css="$HOME/Workspace/blog/styles/bootstrap-md.css"
# If the choosed file is in $sourcedir, default outputdir is setted to one
# level upper directory.
sourcedir='source'

dir="$(cd "$(dirname $1)"; pwd)"
namewithext=$(basename "$1")
name=${namewithext%.*}

currentdir="$(basename $dir)"
dir_up="$(dirname $dir)"

if [ ${currentdir} = $sourcedir ]; then
  dir="${dir_up}"
fi

if [ -d "${dir}/html" ]; then
  output="${dir}/html/${name}"
else
  output="${dir}/${name}"
fi

bibtex2html -s "${style}" -c "${bibtex_command}" -css "${css}" -o "${output}" "$1"
