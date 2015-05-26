#!/bin/bash

picture_folder=/media/shotaro/STOCK/Pictures/wallpapers
sleeptime=1

for file in `ls $picture_folder`; do
    feh --bg-fill "${picture_folder}/${file}"
    echo ${picture_folder}/${file}
    sleep $sleeptime
done
exit 0
