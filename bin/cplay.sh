#!/bin/bash
# written by Shotaro Fujimoto (https://github.com/ssh0)
#
# cplay.sh - send pause command to cmus or if it has not launched, run cmus.

# teminal emulator to launch cmus
terminal=/usr/bin/urxvt

if ! ps aux | grep -w "cmus$" | grep -v grep > /dev/null ; then
    $terminal -e ${SHELL:-"/usr/bin/zsh"} -c cmus & > /dev/null
else
    cmus-remote -u
fi

