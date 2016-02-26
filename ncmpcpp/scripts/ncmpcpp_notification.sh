#!/bin/bash
# written by Shotaro Fujimoto (https://github.com/ssh0)
# first edited: 2016-02-26

icon='/usr/share/icons/gnome/scalable/actions/media-playback-start-symbolic.svg'

ncmpcpp --now-playing '{%a - %t}|{%f}' | \
  while read line; do
    notify-send -a ncmpcpp -t 1000 -i "${icon}" 'Now playing' "${line}"
  done

