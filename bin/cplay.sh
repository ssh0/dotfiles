#!/bin/bash
# written by Shotaro Fujimoto (https://github.com/ssh0)
#
#=#=#=
# cplay.sh - send pause command to cmus or if it has not launched, run cmus.
# 
# if there is no process of cmus, start cmus on urxvt terminal.  
# else play / pause remote command will be sent to cmus program.  
# It's useful if you set the shortcut-key with multimedia key.
#=#=

# teminal emulator to launch cmus
terminal=/usr/bin/urxvt

if ! ps aux | grep -w "cmus$" | grep -v grep > /dev/null ; then
    $terminal -e ${SHELL:-"/usr/bin/zsh"} -c cmus & > /dev/null
else
    cmus-remote -u
fi

