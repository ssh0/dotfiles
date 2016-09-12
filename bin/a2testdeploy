#!/bin/bash
#=#=#=
# a2testdeploy - Copy current project files to /var/www/html/
#
# **Usage:**
#
# ```
# cd ~/project_tree
# a2testdeploy
# ```
#
# **TODO:**
#
# * Some option to specify a project directory.
#=#=

APACHE_DOCUMENT_ROOT='/var/www/html/'
localpath="$HOME/Workspace/online-skillup/bluebird/"
rsynccmd='rsync -av --progress --delete'

columns=$(tput cols)
line=$(printf '%*s\n' "$columns" '' | tr ' ' -)

sync() {
  echo ""
  echo "$ $rsynccmd -n $1 $2"
  echo "$line"
  $rsynccmd -n "$1" "$2"
  echo "$line"
  read -p "Continue? [y/N]" confirm
  if [ "$confirm" != "y" ]; then
    echo "Aborted."
    exit 1
  fi
  echo ""
  echo "$ sudo $rsynccmd $1 $2"
  echo "$line"
  sudo $rsynccmd "$1" "$2"
}

while getopts yh OPT
do
  case $OPT in
    "y") confirm=false
      ;;
    "h") usage_all "$0"; exit 0
      ;;
    *)
      echo "a2testdeploy: Unknown option."
      exit 1
      ;;
  esac
done

shift $((OPTIND-1))

sync "${localpath}" "${APACHE_DOCUMENT_ROOT}"
