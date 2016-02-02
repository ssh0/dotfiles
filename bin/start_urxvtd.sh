#!/bin/bash
# written by Shotaro Fujimoto (https://github.com/ssh0)
#=#=#=
# If there is no process of urxvtd (urxvt daemon), start urxvtd.
#=#=

condition="$(ps -aux | grep urxvtd | grep -v grep | grep -v $0)" 
if [ "$condition" = "" ]; then
  urxvtd -q -f -o
  echo "urxvt damon is started."
else
  echo "urxvt damon has been already started."
fi

exit 0
