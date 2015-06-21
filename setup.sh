#!/bin/sh
# written by Shotaro Fujimoto (https://github.com/ssh0)
# read link configuration from ./setup_config_link

dotdir=$(cd "$(dirname "$0")"; pwd)
home=$HOME

red=31
# green=32
yellow=33
# blue=34
# cyan=36

cecho() {
  color=$1
  shift
  echo "\033[${color}m$@\033[m"
}

info() {
  # verbose confirmation
  echo ""
  echo "${1} -> ${2}"
}

for l in $(grep -Ev '^#' setup_config_link | grep -Ev '^$'); do
    dotfile="${dotdir}/$(echo "$l" | awk 'BEGIN {FS=","; }  { print $1; }')"
    orig="${home}/$(echo "$l" | awk 'BEGIN {FS=","; }  { print $2; }')"
  if [ ! -e "${dotfile}" ]; then
    echo ""
    cecho $red "dotfile '${dotfile}' doesn't exist."
    continue
  fi

  # if dir is not exist: mkdir
  origdir=$(dirname "${orig}")
  if [ ! -d "${origdir}" ]; then
    info "${orig}" "${dotfile}"
    flag=false
    cecho $red "'${origdir}' doesn't exist."
    echo "[message] mkdir '${origdir}'? (y/n):"
    while read yn; do
      case $yn in
        [Yy] ) mkdir -p "${origdir}"; break ;;
        [Nn] ) flag=true; break ;;
        * ) echo "Please answer with y or n." ;;
      esac
    done
    if $flag; then
      continue
    fi
  fi

  # if file already exists: open interaction menu
  if [ -e "${orig}" ]; then
    if [ -L "${orig}" ]; then
      continue
    else
      info "${orig}" "${dotfile}"
      cecho $yellow "file or directory already exists."
      while true; do
        echo "(d):show diff, (f):overwrite, (b):make backup, (n):do nothing"
        read line
        case $line in
          [Dd] ) echo "diff -u '${dotfile}' '${orig}'"
                  diff -u "${dotfile}" "${orig}"
                  echo "" ;;
          [Ff] ) if [ -d "${orig}" ]; then
                    rm -r "${orig}"
                  else
                    rm "${orig}"
                  fi
                  ln -sv "${dotfile}" "${orig}"
                  break ;;
          [Bb] ) ln -sbv --suffix '.bak' "${dotfile}" "${orig}"
                  break ;;
          [Nn] ) break ;;
          # ? ) echo "Please answer with d, f, b or n." ;;
        esac
      done
    fi
  else
    # otherwise make symbolic file normally
    ln -sv "${dotfile}" "${orig}"
  fi
done
