#!/bin/bash
# written by Shotaro Fujimoto (https://github.com/ssh0)
# first edited: 2015-06-14

# use ~/.fehbg
WALLPAPERS_PATH=$HOME/.fehbg

if [ ! -e "${WALLPAPERS_PATH}" ]; then
  echo "${WALLPAPERS_PATH} doesn't exist."
  exit 1
fi

feh --bg-fill "$(tail -n 1 "${WALLPAPERS_PATH}" | awk '{print $3;}')"
exit 0
