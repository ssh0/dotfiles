#!/bin/sh
# written by Shotaro Fujimoto (https://github.com/ssh0)
# read link configuration from ./setup_config_link

dotdir=`cd $(dirname $0); pwd`
home=$HOME

red=31
green=32
yellow=33
blue=34
cyan=36

cecho() {
    color=$1
    shift
    echo "\033[${color}m$@\033[m"
}

for l in $(grep -Ev '^#' setup_config_link | grep -Ev '^$'); do
    dotfile="${dotdir}/$(echo "$l" | awk 'BEGIN {FS=","; }  { print $1; }')"
    orig="${home}/$(echo "$l" | awk 'BEGIN {FS=","; }  { print $2; }')"

    # verbose confirmation
    echo ""
    echo "${dotfile} -> ${orig}"

    # if dir is not exist: mkdir
    origdir=`dirname "${orig}"`
    if [ ! -e "${origdir}" ] || [ -f "${origdir}" ]; then
        flag=false
        cecho $red "'${origdir}' doesn't exist."
        while true; do
            echo "Do you want to mkdir '${origdir}'? (y/n):"
            read yn
            case $yn in
                [Yy] ) mkdir -p "${origdir}"; break;;
                [Nn] ) flag=true; break;;
                   * ) echo "Please answer y or n.";;
            esac
        done
        if $flag; then
            continue
        fi
    fi

    # if file already exists: open interaction menu
    if [ -e "${orig}" ]; then
        if [ -L "${orig}" ]; then
            cecho $cyan "symbolic link already exists."
            continue
        else
            cecho $yellow "file or directory already exists."
        fi
        flag=true
        while $flag; do
            echo "(d):show diff, (f):overwrite, (b):make backup, (s):skip"
            read line
            case $line in
                [Dd] ) diff -u "${dotfile}" "${orig}"
                        echo "" ;;
                [Ff] ) if [ -d "${orig}" ]; then
                            rm -r "${orig}"
                        else
                            rm "${orig}"
                        fi
                        ln -sv "${dotfile}" "${orig}"
                        flag=false
                        break;;
                [Bb] ) ln -sbv --suffix '.orig' "${dotfile}" "${orig}"
                        flag=false
                        break;;
                [Ss] ) flag=false; break;;
                * ) echo "Please answer with d, f or b.";;
            esac
        done
    else
    # otherwise make symbolic file normally
        ln -siv "${dotfile}" "${orig}"
    fi
done
