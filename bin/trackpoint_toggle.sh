#!/bin/bash
# written by Shotaro Fujimoto (https://github.com/ssh0)
#=#=#=
# Toggle trackpoint enable/disable (useful when you in Lenovo Thinkpad).
#=#=

declare -i ID
ID=`xinput list | grep -Eo 'TrackPoint\s*id\=[0-9]{1,2}' | grep -Eo '[0-9]{1,2}'`
declare -i STATE
STATE=`xinput list-props $ID | grep 'Device Enabled' | awk '{print $4}'`
if [ $STATE -eq 1 ]; then
    xinput disable $ID
    notify-send "TrackPoint disabled." \
        -t 1000
else
    xinput enable $ID
    notify-send "TrackPoint enabled." \
        -t 1000
fi
