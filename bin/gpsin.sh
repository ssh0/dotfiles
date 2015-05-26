#!/bin/sh

# gpsin.sh
# x=0.2,x=0.4,x=0.6,x=0.8のグラフを表示

gnuplot << EOF
reset
set terminal png
set output "/home/shotaro/Workspace/gnuplot/xoutput.png"
plot for [i=2:8:2] sprintf("/home/shotaro/Workspace/gnuplot/x=0.%d.txt",i) u 1:3 title sprintf("x=0.%d",i)
EOF
