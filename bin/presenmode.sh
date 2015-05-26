#!/bin/sh
#
default_output="eDP1"
default_mode="1920x1080"
projector="VGA1"
projector_mode="1024x768"

show_usage() {
    echo "Usage: $0 COMMAND [-d output] [-m mode] [-h]"
    echo "  COMMAND:"
    echo "    start: Start Presentation mode"
    echo "    stop : Stop Presentaion mode"
    echo "  OPTION:"
    echo "    -d: Output device connecting (default: $projector)"
    echo "    -m: Manually select the display resolution (default: $projector_mode)"
    echo "    -h: Show this message and quit"
    exit 1
}

# Manage options
while getopts d:m:h OPT
do
    case $OPT in
      "d" ) projector="$OPTARG" ;;
      "m" ) projector_mode="$OPTARG" ;;
      "h" ) show_usage ;;
        * ) show_usage ;;
    esac
done

# Change X Window setting by xrandr
if [ $1 = 'start' ]; then
    xrandr --output $default_output --mode $projector_mode
    xrandr --output $projector --mode $projector_mode --same-as $default_output
elif [ $1 = 'stop']; then
    xrandr --output $projector --off
    xrandr --output $default_output --mode $default_mode
else
    usage
fi
