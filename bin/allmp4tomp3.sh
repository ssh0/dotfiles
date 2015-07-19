#!/bin/sh
# written by Shotaro Fujimoto (https://github.com/ssh0)
# first edited: 2015-07-20

find . -type f -name "*.mp4" -print0 | perl -pe s/.mp40/0/g | xargs -0 -I% ffmpeg -i %.mp4 -acodec libmp3lame -ab 256k %.mp3
