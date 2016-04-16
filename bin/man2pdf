#!/bin/bash
# written by Shotaro Fujimoto (https://github.com/ssh0)
# first edited: 2016-03-29
#=#=#=
# Convert man page to pdf file using ps2pdf
#
# You can change `${output_dir}`
# (Dropbox is useful; you can read the pdf documents from anywhere)
#
# Example:
#
# ```
# man2pdf awk
# ```
#=#=

if [ "$1" = '-h' ]; then
  usage_all "$0"
  exit 0
fi

output_dir="$HOME/Dropbox/document/man"

if ret="$(command -p man -t "$1")"; then
  echo "${ret}" | ps2pdf -sPAPERSIZE=a4 -sOutputFile="${output_dir}/$1".pdf - &&
    (echo "[man2pdf] Succefully done" >&2 ;
     echo "[man2pdf] outfile file is '${output_dir}/$1.pdf'" >&2)
fi

