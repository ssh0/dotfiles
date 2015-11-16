#!/bin/sh
# written by Shotaro Fujimoto (https://github.com/ssh0)
# first edited: 2015-06-28

# color-pallete.sh
# Show zenity color pallete.

COLOR=`zenity --color-selection --show-palette`

case $? in
  0) echo "You selected $COLOR." ;;
  1) echo "No color selected." ;;
  -1) exho "An unexpected error has occurred." ;;
esac
