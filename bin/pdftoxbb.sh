#!/bin/sh
for file in `ls figure_*.pdf`
do
    extractbb "${file}"
done

