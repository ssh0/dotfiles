#!/bin/bash

folder=$(pwd)
num=54
xte 'keydown Super_L' 'key 4' 'keyup Super_L'
for t in `seq 1 ${num}`
do
    name=$(printf screen_%02d.jpg $t);
    sleep 0.5
    import -window root -quality 0 ${folder}/${name}
    xte 'key Next'
done
xte 'keydown Super_L' 'key 3' 'keyup Super_L'
exit 0
