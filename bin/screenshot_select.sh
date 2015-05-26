#!/bin/sh
#

get_dir=false
get_name=false
rootdir=$HOME/Workspace/blog

# オプション管理#{{{
while getopts d:o: OPT
do
  case $OPT in
    "d" ) get_dir=true
          dir="$OPTARG" ;;
    "o" ) get_name=true
          name="$OPTARG" ;;
      * ) exit 1 ;;
  esac
done #}}}

# スクリーンショットを保存するディレクトリを設定#{{{
if ! $get_dir; then
    if [ ! -e $rootdir ]; then
        echo "There is no directory named: $rootdir"
        exit 1
    fi
    daydir=`date +%Y-%m-%d`
    dir=$rootdir/$daydir
fi #}}}

# ファイル名を設定#{{{
if ! $get_name; then
    if [ ! -e $dir ]; then
        mkdir $dir
        i=1
    else
        i=`expr $(ls $dir | sed -n 's/screen_\([0-9]\{3\}\).jpg/\1/p' | tail -n 1) + 1`
    fi
    name=$(printf screen_%03d.jpg $i)
fi #}}}

import -quality 0 $dir/$name
paplay /usr/share/sounds/freedesktop/stereo/camera-shutter.oga
notify-send "Screenshot has been made" "saved: $dir/$name" \
    -i /usr/share/icons/gnome/scalable/apps/applets-screenshooter-symbolic.svg

exit 0
