#!/bin/bash

f=$1
mv $f "$f"_
git clone http://github.com/ssh0/$f
cp -r "$f"_/* $f
rm -r "$f"_
cd $f
for p in `ls | grep .py`
    do
        autopep8 $p > tmp && mv tmp $p
    done
git add .
git commit -a
git push
cd ..

