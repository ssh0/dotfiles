#!/bin/bash
xrandr --output HDMI1 --mode 1024x768
xrandr --output eDP1 --off
xte 'keydown Super_L' 'key 4' 'keyup Super_L'
pkill compton
