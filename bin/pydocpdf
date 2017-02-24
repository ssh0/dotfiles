#!/bin/bash
# written by Shotaro Fujimoto (https://github.com/ssh0)
#
#=#=#=
# ```
# NAME
#       pydocpdf - Create python module documentation with pdf format
#
# SYNOPSYS
#       pydocpdf ./proto.py
#
# OPTION
#       -h: Show this help.
#
# DEPENDENCY
#       * pydoc
#       * wkhtmltopdf (installable by apt)
#
# ```
#=#=

if [ "$1" = '-h' ]; then
  usage_all "$0"
  exit 0
fi

if [ ! -f "$1" ]; then
  echo "Argument must be file." >&2
  exit 1
fi

# If the directory named below exists,
# save the output file to that directory.
savedir='doc'

dir="$(cd "$(dirname "$1")"; pwd)"
name="$(basename "$1")"

if [ -d "${dir}/${savedir}" ]; then
  outdir="${dir}/${savedir}"
else
  outdir="${dir}"
fi
path="${outdir}/${name}"

pydoc -w "$1" &&
  wkhtmltopdf -B 0 -L 0 -R 0 -T 0 "${1%\.py}".html "${path%\.py}".pdf &&
  rm "${1%\.py}".html

