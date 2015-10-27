#!/bin/bash
# written by Shotaro Fujimoto (https://github.com/ssh0)
# first edited: 2015-06-03

case "$1" in
  "+")
    amixer -D pulse set Master 1%+ && paplay /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga &;;
  "-")
    amixer -D pulse set Master 1%- && paplay /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga &;;
  "m")
    amixer -D pulse set Master toggle ;;
esac
