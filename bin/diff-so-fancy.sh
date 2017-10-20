#!/bin/bash
# written by Shotaro Fujimoto (https://github.com/ssh0)
# first edited: 2016-09-27
#=#=#=
# diff-so-fancy.sh - wrapper script for [diff-so-fancy](https://github.com/so-fancy/diff-so-fancy).
#
# You can always use this script as default diff command:
#
#     alias diff=diff-so-fancy.sh
#
#=#=

colordiff -u "$@" | /usr/local/bin/diff-so-fancy
