#!/bin/sh
#=#=#=
# ```
# NAME
#       mkdpreview - Simply render markdown by pandoc.
#
# SYNOPSYS
#       mkdpreview [OPTION] markdownfile
#
# OPTIONS
#       -s: Save html file in the source file dir.
#       -u: Update (the same name's) html file in the source file dir.
#       -o: Set the name of html file. \`mkdpreview -o bar.html foo.md\`
#       -p: Preview HTML file in firefox.
#       -h: Show this message.
##
# ```
#
# This script make it easy to use pandoc for converting markdown to html file.
# It is assumed that this script is called from vim-quickrun
# in order to edit markdown file with live-preview.
#
# You can change your style sheet file.
#
# ```sh
# template="$HOME/Workspace/blog/styles/stylesheet.css"
# ```
#
# Of cource you can load the CSS file from the web.
#
# ```sh
# template='http://szk-engineering.com/markdown.css'
# ```
#
# You may change these files in order to show a header bar or a footer bar.
#
# ```
# header="$HOME/Workspace/blog/html/header.html"
# footer="$HOME/Workspace/blog/html/footer.html"
# ```
#
# my header.html
#
# ```html
# <div id="main_content_wrap" class="outer">
# <section id="main_content" class="inner">
# ```
#
# my footer.html
#
# ```html
# </section>
# </div>
# ```
#
# If the executed file is in "source" directory,
# this script converts a html file to the upper directory.
# (And if "html" directory exists, the html file will be converted to there.)
#
# >[markdownの編集環境をいい感じに整えてみた[vim + quickrun + pandoc] - Qiita](http://qiita.com/ssh0/items/b68263a7866b4ce9eaf1)
#
#=#=

# You cah change your style sheet file.
template="$HOME/.config/mkdpreview/styles/github-markdown-css/github-markdown.css"
# Of cource you can load from the web.
# template='http://szk-engineering.com/markdown.css'

# You may change these files in order to show a header bar or a footer bar.
header="$HOME/.config/mkdpreview/header.html"
footer="$HOME/.config/mkdpreview/footer.html"

# If the file is in this directory,
# this script converts a html file to the upper directory.
sourcedir='source'

# If the directory named below exists,
# save the output file to that directory.
savedir='doc'

notification=false
notification_icon='/usr/share/icons/gnome/scalable/actions/document-send-symbolic.svg'

f="$0"
usage() {
  sed -n '/^# NAME$/,/^##$/p' "$f" | sed -e '$d' | cut -b3- >&2
  exit 1
}

# default settings
save=false
update=false
output=""
preview=false
previewprg="open"

# option handling
while getopts suo:phH OPT
do
  case $OPT in
    "s" ) save=true ;;
    "u" ) save=true; update=true ;;
    "o" ) save=true; output="${OPTARG}" ;;
    "p" ) preview=true ;;
    "h" ) usage ;;
    "H" ) usage_all "$f"; exit 0 ;;
  esac
done

# shift arg
shift $((OPTIND-1))

# if $1 is file, check its directory.
if [ -f "$1" ]; then
  dir="$(cd "$(dirname $1)"; pwd)"
  currentdir="$(basename $dir)"
  dir_up="$(dirname $dir)"
  if [ $currentdir = $sourcedir ]; then
    dir="${dir_up}"
  fi
  namewithext=$(basename "$1")
  name=${namewithext%.*}
# save the file in /tmp dir.
else
  dir=""
  name="/tmp/$(tr -cd 'a-f0-9' < /dev/urandom | head -c 32)"
fi

# set the saving direction
if [ "${output}" = "" ]; then
  if [ -d "${dir}/${savedir}" ]; then
    output="${dir}/${savedir}/${name}.html"
  else
    output="${dir}/${name}.html"
  fi
fi

# save to the file direction.
if $save; then
  # update option
  notificationcmd="notify-send '[mkdpreview] Build done!' '$output'
                   -i ${notification_icon}"

  $update && test ! -f "${output}" && exit 0

  pandoc -f markdown -smart -t html5 -c "${template}" -B "${header}" -A \
    "${footer}" -s --mathjax -o "${output}" "$@" && \
  $notification && eval $notificationcmd
fi

# preview in web browser.
if $preview; then
  $previewprg "file://${output}"
fi

