#!/bin/bash
# written by Shotaro Fujimoto (https://github.com/ssh0)
# first edited: 2015-06-03

volfifo="$HOME/.vol"

case "$1" in
  "+")
    amixer -D pulse set Master 1%+ && paplay /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga ;;
  "-")
    amixer -D pulse set Master 1%- && paplay /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga ;;
  "m")
    amixer -D pulse set Master toggle ;;
esac

amixer -D pulse get Master | awk -F'[]%[]' '/%/ {if ($7 == "off") { print "MM" } else { print $2 }}' | head -n 1 > "$volfifo"
