#!/bin/bash
#=#=#=
# This script erase cache memory (need sudo).
# 
# Thanks to SONY5614.  
# and modified by Shotaro Fujimoto (https://github.com/ssh0)
#=#=

if [ "$1" = '-h' ]; then
  usage_all "$0"
  exit 0
fi

# set line width
columns=$(tput cols)
if [ $columns -gt 70 ]; then
  columns=70
fi
line=$(printf '%*s\n' "$columns" '' | tr ' ' -)

echo -e "\nThis script clear cache.\n"

# current memory usage
echo -e "Before:\n$line"
sudo free
echo "$line"
sudo sync

# set vm.drop_caches option number
echo -e "\nInput number."
echo "[0] default"
echo "[1] page cache"
echo "[2] dentry, inode"
echo "[3] page cache, dentry, inode"
echo -n ">>[0-3?]>>"
read number

# clear cache
case "$number" in
  "0"|"1"|"2"|"3" )
    echo ""
    echo "sudo sysctl -w vm.drop_caches=$number"
    sudo sysctl -w vm.drop_caches=$number
    ;;
  *)
    echo "Unexpected key. Aborted."
    exit 1
    ;;
esac

# After message
echo -e "\nAfter:\n$line" && sudo free
echo -e "$line\nDone.\n"
exit 0

