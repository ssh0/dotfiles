#!/bin/bash
# written by Shotaro Fujimoto (https://github.com/ssh0)
# first edited: 2016-02-26

# icon='/usr/share/icons/gnome/scalable/actions/media-playback-start-symbolic.svg'

line="$(mpc current)"

/usr/bin/osascript -e "display notification \"${line}\" with title \"Now playing\""
