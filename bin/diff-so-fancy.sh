#!/bin/bash
# written by Shotaro Fujimoto (https://github.com/ssh0)
# first edited: 2016-09-27

/usr/bin/colordiff -u "$@" | /usr/local/bin/diff-so-fancy
