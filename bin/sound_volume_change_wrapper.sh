#!/bin/bash
# written by Shotaro Fujimoto (https://github.com/ssh0)
#=#=#=
# You should set a shortcut to the multimediakey(volume up/down/mute) to call this script.
#
# You can also execute this command on terminal.
#=#=

case "$1" in
  "+")
    amixer -D pulse set Master 1%+ && paplay /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga &;;
  "-")
    amixer -D pulse set Master 1%- && paplay /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga &;;
  "m")
    amixer -D pulse set Master toggle ;;
esac
