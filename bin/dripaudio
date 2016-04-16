#!/bin/bash
# written by Shotaro Fujimoto (https://github.com/ssh0)
# first edited: 2016-02-23
#=#=#=
# dripaudio - extract aac codec audio files from mp4 files in `$PWD`
#
# **Require:**
#
# * ffmpeg
#=#=

if [ "$1" = '-h' ]; then
  usage_all "$0"
  exit 0
fi

(
IFS=$'\n';
for file in $(ls *.mp4); do
  input_mp4="${file%.mp4}"
  output="${input_mp4}.m4a"
  if [ -e "${output}" ]; then
    echo "[dripaudio] File '${output}' already exists."
    break
  fi
  ffmpeg -i "${input_mp4}.mp4" -acodec copy "${input_mp4}.aac"
  mv "${input_mp4}.aac" "${input_mp4}.m4a"
done
)
