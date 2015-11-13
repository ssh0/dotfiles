#!/bin/sh
#

default_output="${OUTPUT_DEV:-eDP1}"
default_mode="${OUTPUT_RES:-1920x1080}"
projector="VGA1"
projector_mode="1024x768"

usage() {
  cat << EOF

NAME
      presenmode.sh - provide easy way to manage the monitors with xrandr.

USAGE
      presenmode.sh COMMAND [-d output] [-m mode] [-h]

COMMAND
      start: Start Presentation mode
      stop : Stop Presentaion mode

OPTION
      -d: Output device connecting (default: $projector)
      -m: Manually select the display resolution (default: $projector_mode)
      -h: Show this message and quit

EOF
  exit 1
}

# Manage options
while getopts d:m:h OPT
do
  case $OPT in
    "d" ) projector="$OPTARG" ;;
    "m" ) projector_mode="$OPTARG" ;;
    "h" ) usage ;;
      * ) usage ;;
  esac
done

# Change X Window setting by xrandr
if [ "$1" = "start" ]; then
  xrandr --output $default_output --mode $projector_mode
  xrandr --output $projector --mode $projector_mode --same-as $default_output
elif [ "$1" = "stop" ]; then
  xrandr --output $projector --off
  xrandr --output $default_output --mode $default_mode
else
  usage
fi
