#!/bin/sh
#=#=#=
# play video with color ascii on xterm.
#=#=

xterm -fn 6x12 \
      -e "export TERM=xterm-16color; \
          export CACA_DRIVER=ncurses; \
          mplayer -framedrop -msglevel all=0 -quiet -vo caca \"$1\""
