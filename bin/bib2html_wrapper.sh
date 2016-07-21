#!/bin/bash
# written by Shotaro Fujimoto (https://github.com/ssh0)
#=#=#=
# bibtex2html wrapper script to convert bibtex file to
# readable and searchable html file.  
# (I often use with vim-quickrun to automatically execute this script.)
#
# Required: [bibtex2html](https://www.lri.fr/~filliatr/bibtex2html/)
#
# ```
# apt-get install bibtex2html
# ```
#
# See details here. (japanese article)
#
# >[bibtex2htmlを利用したクールな文献管理 - Qiita](http://qiita.com/ssh0/items/7af727f0513c3fbf09a4)
#
#=#=

if [ "$1" = '-H' ]; then
  usage_all "$0"
  exit 0
fi

# set bibliography style
style='junsrt'

# set bibtex command
bibtex_command='pbibtex'

# set css file to convert
css="$HOME/Workspace/blog/styles/bootstrap-md.css"

# If the choosed file is in $sourcedir, default outputdir is setted to one
# level upper directory.
sourcedir='source'

notification=true
notification_icon='/usr/share/icons/gnome/scalable/actions/document-send-symbolic.svg'

[[ -f "$1" ]] || (echo "There is no file '$1'.";  exit 1)

dir="$(cd "$(dirname "$1")"; pwd)"
namewithext="$(basename "$1")"
name="${namewithext%.*}.html"

currentdir="$(basename "$dir")"
dir_up="$(dirname "$dir")"

if [ "${currentdir}" = ${sourcedir} ]; then
  dir="${dir_up}"
fi

if [ -d "${dir}/doc" ]; then
  output="${dir}/doc/${name}"
else
  output="${dir}/${name}"
fi

notificationcmd="notify-send '[bibtex2html] Build done!' '$output'
                  -i ${notification_icon}"

bibtex2html -s "${style}" -c "${bibtex_command}" -css "${css}" -o "${output}" -noheader -nofooter -linebreak "$1" && \
  $notification && eval $notificationcmd
