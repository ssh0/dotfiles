#!/bin/sh
# written by Shotaro Fujimoto (https://github.com/ssh0)
# read link configuration from ./setup_config_link

dotdir=$(cd "$(dirname "$0")"; pwd)
configfile="./setup_config_link"
home=$HOME

usage() {
  echo "setup.sh"
  echo "This script set symbolic link which is configured in '$configfile'" 
  echo "If the file is already exist, you can choose the operation interactively:"
  echo "show diff, vimdiff, overwrite, make-backup or do-nothing."
  echo ""
  echo "Usage:"
  echo "  ./setup.sh [OPTIONS]"
  echo ""
  echo "Options:"
  echo "  -i: no interaction mode(dismiss all conflicts)"
  echo "  -v: print verbose messages"
  echo "  -h: show this help message"
  exit 1
}

interactive=true
verbose=false

# option handling
while getopts ivh OPT
do
  case $OPT in
    "i" ) interactive=false ;;
    "v" ) verbose=true ;;
    "h" ) usage ;;
  esac
done

red=31
yellow=33
blue=34

cecho() {
  color=$1
  shift
  echo "\033[${color}m$@\033[m"
}

info() {
  if $verbose; then
    # verbose confirmation
    echo ""
    echo "${1} -> ${2}"
  fi
}

if $verbose; then
  mklink="ln -sv"
else
  mklink="ln -s"
fi

for l in $(grep -Ev '^#' "$configfile" | grep -Ev '^$'); do
  dotfile="${dotdir}/$(echo "$l" | awk 'BEGIN {FS=","; }  { print $1; }')"
  orig="${home}/$(echo "$l" | awk 'BEGIN {FS=","; }  { print $2; }')"
  if [ ! -e "${dotfile}" ]; then
    echo ""
    cecho $red "dotfile '${dotfile}' doesn't exist."
    continue
  fi

  # if directory doesn't exist: mkdir or not
  origdir=$(dirname "${orig}")
  if [ ! -d "${origdir}" ]; then
    info "${orig}" "${dotfile}"
    cecho $red "'${origdir}' doesn't exist."
    if $interactive; then
      echo "[message] mkdir '${origdir}'? (y/n):"
      while echo -n ">>> "; read yn; do
        case $yn in
          [Yy] ) mkdir -p "${origdir}"; break ;;
          [Nn] ) break ;;
          * ) echo "Please answer with y or n:" ;;
        esac
      done
    fi
    continue
  fi

  # if file already exists: open interaction menu
  if [ -e "${orig}" ]; then
    # if file is link
    if [ -L "${orig}" ]; then
      linkto="$(readlink ${orig})"
      info "${orig}" "${dotfile}"
      # link already exists
      if [ "${linkto}" = "${dotfile}" ]; then
        $verbose && cecho $blue "link '${orig}' already exists."
        continue
      # different link
      else
        cecho $red "link '${orig}' is NOT the link of '${dotfile}'."
        cecho $red "'${orig}' is link of '${linkto}'."
        if $interactive; then
          echo "[message] unlink and re-link for '${orig}'? (y/n):"
          while echo -n ">>> "; read yn; do
            case $yn in
              [Yy] ) unlink "${orig}"
                     $mklink "${dotfile}" "${orig}"
                     break ;;
              [Nn] ) break ;;
              * ) echo "Please answer with y or n:" ;;
            esac
          done
        fi
        continue
      fi
    else
      info "${orig}" "${dotfile}"
      cecho $yellow "'${orig}' already exists."
      if $interactive; then
        while true; do
          echo "(d):show diff, (e):vimdiff, (f):overwrite, (b):make backup, (n):do nothing"
          echo -n ">>> "
          read line
          case $line in
            [Dd] ) echo "diff -u '${dotfile}' '${orig}'"
                   diff -u "${dotfile}" "${orig}"
                   echo ""
                   ;;
            [Ee] ) echo "vimdiff '${dotfile}' '${orig}'"
                   vimdiff "${dotfile}" "${orig}"
                   ;;
            [Ff] ) if [ -d "${orig}" ]; then
                     rm -r "${orig}"
                   else
                     rm "${orig}"
                   fi
                   $mklink "${dotfile}" "${orig}"
                   break
                   ;;
            [Bb] ) $mklink -b --suffix '.bak' "${dotfile}" "${orig}"
                   break
                   ;;
            [Nn] ) break
                   ;;
            # ? ) echo "Please answer with d, f, b or n." ;;
          esac
        done
      fi
    fi
  else
    # otherwise make symbolic file normally
    ln -sv "${dotfile}" "${orig}"
  fi
done
