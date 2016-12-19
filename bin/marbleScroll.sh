#!/bin/bash
# written by Shotaro Fujimoto (https://github.com/ssh0)
# first edited: 2016-12-17
#=#=#=
# Since i update the Ubuntu version from 14.04 to 16.04, my Fogitech Trackman Marble mouse doesn't work properly especially emulating wheel button.
#
# >[[UbuntuGnome] Problem with configuring Logitech Trackman Marble mouse in 16.04](https://ubuntuforums.org/showthread.php?t=2328654) / Same problem is reported here.
#
# Then, the solution is to use xinput to enable emulating wheel button.
#
# >[Logitech_Marblemouse_USB - Community Help Wiki](https://help.ubuntu.com/community/Logitech_Marblemouse_USB#Alternative:_apply_settings_via_xinput)
#
# Run this scipt after the boot.
#=#=

# horizontal & vertical scrolling with small left key
# & browser back button with small right key
xinput set-button-map "Logitech USB Trackball" 1 9 3 4 5 6 7 2 8
xinput set-int-prop "Logitech USB Trackball" "Evdev Wheel Emulation Button" 8 8
xinput set-int-prop "Logitech USB Trackball" "Evdev Wheel Emulation" 8 1
xinput set-int-prop "Logitech USB Trackball" "Evdev Wheel Emulation Axes" 8 6 7 4 5
xinput set-int-prop "Logitech USB Trackball" "Evdev Wheel Emulation X Axis" 8 6
