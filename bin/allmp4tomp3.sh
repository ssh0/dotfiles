#!/bin/bash
# written by Shotaro Fujimoto (https://github.com/ssh0)
#=#=#=
# allmp4tomp3.sh - Convert all mp4 file in the current dir to mp3 files.
#
# Required: ffmpeg
#=#=

find . -type f -name "*.mp4" -print0 | perl -pe s/.mp4//g | xargs -0 -I% ffmpeg -i %.mp4 -acodec libmp3lame -ab 256k %.mp3
