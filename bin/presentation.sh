#!/bin/sh
if [ $# -ne 1 ]; then
  echo "need 1 argument to start the presentation." 1>&2
  exit 0
fi
impressive --supersample --cache persistent --cachefile ."${1%%.pdf}".impressive_cache --transition None --transtime 500 $1
