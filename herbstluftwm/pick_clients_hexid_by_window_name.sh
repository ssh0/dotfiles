#!/bin/bash
# written by Shotaro Fujimoto (https://github.com/ssh0)
# first edited: 2017-02-15

herbstclient object_tree clients \
  | grep -v 'focus' | sed -e '1d' | cut -b7- |
  while read line; do
    tag="[$(herbstclient get_attr .clients.${line}.tag)]"
    title="$(herbstclient get_attr .clients.${line}.title)"
    printf "%-3s %-120s:${line}\n" "${tag}" "${title}"
  done | dmenu -b -f -i -l 10 -fn "Migu 1M:size=20" | rev | cut -d: -f1 | rev
