#!/bin/bash
# written by Shotaro Fujimoto (https://github.com/ssh0)
# first edited: 2017-02-15

herbstclient object_tree clients \
  | grep -v 'focus' | sed -e '1d' | cut -b7- |
  while read line; do
    echo -n "[$(herbstclient get_attr .clients.${line}.tag)] "
    echo -n "$(herbstclient get_attr .clients.${line}.title) "
    echo "(${line})"
  done | dmenu -b -f -i -l 10 -fn "Migu 1M:size=20" | rev | cut -b2-10 | rev
