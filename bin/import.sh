#!/bin/sh

folder=$(pwd)
sleeptime=3
i=1

while :
do
    echo -n "continue? (Y/n): "
    read line
    case $line in
        'y' ) name=$(printf screen_%02d.jpg $i);
              sleep $sleeptime
              import -window root ${folder}/${name}
              i=`expr ${i} + 1` ;;
        'n' ) echo "exit ... "
              exit 0 ;;
        *)    echo "you should type 'y' or 'n' or nothing(='y')" ;;
    esac
done
exit 0
