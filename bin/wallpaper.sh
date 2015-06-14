#!/bin/bash
# written by Shotaro Fujimoto (https://github.com/ssh0)
# first edited: 2015-06-14

WALLPAPERS_PATH=$HOME/.mywallpapers
if [ ! -e "${WALLPAPERS_PATH}" ]; then
  echo "${WALLPAPERS_PATH} doesn't exist."
  exit 1
fi

feh --bg-fill "$(tail -n 1 "${WALLPAPERS_PATH}")"
exit 0
