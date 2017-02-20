#!/usr/bin/env bash

tag="${1:-floating}"
monitor=floating_monitor
hc() { "${herbstclient_command[@]:-herbstclient}" "$@" ;}

float_on() {
  mrect=( $(hc monitor_rect) )
  termwidth=${mrect[2]}
  termheight=${mrect[3]}
  rect=(
      $termwidth
      $termheight
      ${mrect[0]}
      ${mrect[1]}
  )

  hc add "$tag"
  hc floating "$tag" on

  hc add_monitor $(printf "%dx%d%+d%+d" "${rect[@]}") \
                      "$tag" $monitor 2> /dev/null
  # remember which monitor was focused previously
  hc new_attr string monitors.by-name."$monitor".my_prev_focus
  local orig_monitor="$(hc get_attr monitors.focus.index)"
  hc set_attr monitors.by-name."$monitor".my_prev_focus "${orig_monitor}"
  hc lock
  hc shift_to_monitor "$monitor"
  hc raise_monitor "$monitor"
  hc focus_monitor "$monitor"
  hc unlock
  hc lock_tag "$monitor"
}

float_off() {
    # if q3terminal still is focused, then focus the previously focused monitor
    # (that mon which was focused when starting q3terminal)
    hc lock
    hc remove_monitor "$monitor"
    hc raise_monitor "${1}"
    hc focus_monitor "${1}"
    hc merge_tag "$tag"
    hc unlock
}

if orig="$(hc get_attr monitors.by-name."$monitor".my_prev_focus 2> /dev/null)"; then
  float_off "${orig}"
else
  float_on
fi
