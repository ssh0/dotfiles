#!/bin/bash
#
# folked from https://gist.github.com/markusfisch/873364#file-say-sh
# written by markusfisch

# for japanese people
LNG=${LANGUAGE:-ja}
# for English poeople
# LNG=${LNG:-en}

# set default saving directory
STOCK="${HOME}/Downloads/TTS"

# set default player
playcmd="mpv --really-quiet"

usage() {
    echo "Text to speech CLI interface using Google translate_TTS API"
    echo "Usage: $0 [OPTION] TERM"
    echo ""
    echo "Set options for language, saving directory:"
    echo "  -l,    Set language (default: $LNG)"
    echo "  -d,    Set saving directory (default: $STOCK/$LNG)"
    echo "  -p,    Set the output player command (default: $playcmd)"
    echo ""
    echo "  -h,    Show this message and quit quietly"
    exit 0
}

# FUTURE #
#
# Option "-i" import the text and divide by some special character (like "---")
# and extract all sound files to the same directory named like "01_TERM.mp3"
#

while getopts l:d:p:h OPT
do
    case $OPT in
        "l" ) LNG="$OPTARG" ;;
        "d" ) STOCK="$OPTARG" ;;
        "p" ) playcmd="$OPTARG" ;;
        "h" ) usage ;;
        "?" ) usage ;;
    esac
done

# Google translate_TTS API's url
readonly URL="http://translate.google.com/translate_tts?ie=UTF-8&total=1&idx=0&client=t&tl=${LNG}&q="


STOCK="${STOCK}/${LNG}"

[ -d "${STOCK}" ] || {
    mkdir -p "${STOCK}" || {
        echo "error: cannot create speech stock \"$STOCK\""
        exit 1
    }
}

shift $((OPTIND-1))
TEXT="`echo $*`"
FILE="`date +"%Y%m%d%H%M%S"`"
# if [ `expr length "${TEXT}"` -gt 10 ]; then
#     FILE="`echo "$TEXT" | cut -c -10`".mp3
# else
#     FILE=${TEXT}.mp3
# fi

FILE="${STOCK}/${FILE}"
TERM="`echo ${TEXT} | nkf -wWMQ | tr = %`"
# TERM="${TEXT}"
# [ -f "${FILE}" ] ||
    echo ${URL}${TERM}
    wget -U Mozilla --restrict-file-names=nocontrol -O "${FILE}" ${URL}${TERM}
    # firefox --new-tab "${URL}${TERM}"

[ -n "${playcmd}" ] &&
    ${playcmd} "${FILE}" &>/dev/null
    exit 0
