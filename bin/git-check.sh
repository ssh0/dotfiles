#!/bin/sh
#

checked_folder='$HOME/.git/git_checked_folder'

for d in `cat $checked_folder`
do
  echo
  echo "DIR: $d"
  echo "------------------------------------------"
  git status
  echo
done
