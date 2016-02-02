#!/bin/bash
# 
# By Marko Haapala
#
# converts wma to mp3 recursively. does not delete any static files, so 
# cleanup and renaming is needed afterwards. 
#
# **requirements:**
#
# * [lame](http://lame.sourceforge.net/download.php)
# * mplayer
#     * `apt-get install mplayer` or http://www.mplayerhq.hu/design7/dload.html
#==============================================================================

current_directory=$(pwd)
wma_files=$(find "${current_directory}" -type f -iname "*.wma")
# Need to change IFS or files with filenames containing spaces will not
# be handled correctly by for loop
IFS=$'\n' 
for wma_file in ${wma_files}; do 
    mplayer -vo null -vc dummy -af resample=44100 \
    -ao pcm -ao pcm:waveheader "${wma_file}" && lame -m s \
    audiodump.wav -o "${wma_file%%.wma}".mp3
    rm audiodump.wav
done
#rm *.wma
