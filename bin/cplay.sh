#!/bin/sh
#
TERMINAL=/usr/bin/urxvt
SHELL=/usr/bin/zsh

if ! ps aux | grep -w "cmus$" | grep -v grep > /dev/null ; then
    $TERMINAL -e $SHELL -c cmus & > /dev/null
else
    cmus-remote -u
fi
