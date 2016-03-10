#!/bin/bash
#=#=#=
# I use composite mangager compton.
#
# This script toggle enabling the composite manager.
#=#=

if pgrep compton &> /dev/null; then
    echo "Turning compton OFF"
    pkill compton &
else
    echo "Turning compton ON"
    compton -b --config $HOME/.config/compton/compton.conf
fi

exit 0
