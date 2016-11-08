#!/bin/bash
# written by Shotaro Fujimoto (https://github.com/ssh0)
# first edited: 2016-02-26

icon='/usr/share/icons/gnome/scalable/actions/media-playback-start-symbolic.svg'

line="$(mpc current)"

notify-send -a mpd -t 5000 -i "${icon}" 'Now playing' "${line}"

