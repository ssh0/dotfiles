#!/bin/bash
#
# toggle enabling the touchpad.
# 
# I often use this srcipt in my laptop. (also shortcut to it)
# 
# From: [How to disable the touchpad? - Ask Ubuntu](http://askubuntu.com/questions/65951/how-to-disable-the-touchpad)
#==============================================================================

declare -i ID
ID=`xinput list | grep -Eo 'TouchPad\s*id\=[0-9]{1,2}' | grep -Eo '[0-9]{1,2}'`
declare -i STATE
STATE=`xinput list-props $ID | grep 'Device Enabled' | awk '{print $4}'`
if [ $STATE -eq 1 ]; then
    xinput disable $ID
    notify-send "Touchpad disabled." \
        -t 1000 \
        -i /usr/share/icons/gnome/scalable/status/touchpad-disabled-symbolic.svg
else
    xinput enable $ID
    notify-send "Touchpad enabled." \
        -t 1000 \
        -i /usr/share/icons/gnome/scalable/devices/input-touchpad-symbolic.svg
fi
