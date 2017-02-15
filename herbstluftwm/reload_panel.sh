#!/bin/bash
# written by Shotaro Fujimoto (https://github.com/ssh0)
# first edited: 2017-02-15

# first, clear panel
herbstclient emit_hook quit_panel

# find the panel
panel=~/.config/herbstluftwm/panel.sh
[ -x "$panel" ] || panel=/etc/xdg/herbstluftwm/panel.sh
for monitor in $(herbstclient list_monitors | cut -d: -f1) ; do
    # start it on each monitor
    "$panel" $monitor &
done
