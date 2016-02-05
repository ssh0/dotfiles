#!/bin/bash
# folked from https://gist.github.com/markusfisch/873364#file-say-sh, written by markusfisch
#
#=#=#=
# ```
# Text to speech CLI interface using Google translate_TTS API
# Usage: googleTTS.sh [OPTION] TERM
#
# Set options for language, saving directory:
#   -l,    Set language (default: $LNG)
#   -d,    Set saving directory (default: ${HOME}/Downloads/TTS/$LNG)
#   -p,    Set the output player command (default: $playcmd)
#
#   -h,    Show this message and quit quietly
# ```
#=#=

# some error occured, exit immediately
set -e


# Google translate_TTS API's url
readonly URL="http://translate.google.com/translate_tts?ie=UTF-8&total=1&idx=0&client=t&tl=${LNG}&q="

# for Japanese
LNG=${LANGUAGE:-ja}
# for English
# LNG=${LNG:-en}

# set the root directory to save file
root_dir="${HOME}/Downloads/TTS"

# set default player
playcmd="mpv --really-quiet"

f="$0"
usage() {
  cat "$f" | nl -w3 -s- -nln -d'#=' -ha -bn -fn \
    | grep -ve '^\s\+' | cut -b7- | grep -v "\`\`\`"
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
    "d" ) root_dir="$OPTARG" ;;
    "p" ) playcmd="$OPTARG" ;;
    "h" ) usage ;;
    * ) usage ;;
  esac
done

shift $((OPTIND-1))

save_dir="${root_dir}/${LNG}"
if [ ! -d "${save_dir}" ]; then
  mkdir -p "${save_dir}" || (echo "error: cannot create speech stock \"$save_dir\""; exit 1)
fi

text="`echo $*`"
file="`date +"%Y%m%d%H%M%S"`"
# if [ `expr length "${text}"` -gt 10 ]; then
#     file="`echo "$text" | cut -c -10`".mp3
# else
#     file=${text}.mp3
# fi

file="${save_dir}/${file}"
TERM="`echo ${text} | nkf -wWMQ | tr = %`"
# TERM="${text}"
# [ -f "${file}" ] ||
    echo ${URL}${TERM}
    wget -U Mozilla --restrict-file-names=nocontrol -O "${file}" ${URL}${TERM}
    # firefox --new-tab "${URL}${TERM}"

[ -n "${playcmd}" ] &&
    ${playcmd} "${file}" &>/dev/null
    exit 0
