#!/bin/bash
# written by Shotaro Fujimoto (https://github.com/ssh0)
# first edited: 2016-03-10
#=#=#= doc {{{
# ```
# NAME
#       incfn - get a serialised filename incremented by 1
#
# USAGE
#       incfn [OPTOINS]
#       (At least one option from (-b -a -e -h) are necessary.)
#
# OPTIONS
#       -h    Show this help message.
#
#       -b filename_before
#             Set the string before the number. [default: ""]
#
#       -a filename_after
#             Set the string after the number. [default: ""]
#
#       -e filename_extension
#             Set the extension of the file. [default: ""]
#
#       -d root_dir
#             Specify the directory. [default: $PWD]
#
#       -n num_of_digits
#             Specify the number of digits. [default: 3]
##
# ```
#
# ### Examples
#
# In your shell script, sometimes you want save a file in '/path/to/save'
# with serial-numbered file name.
# Assume that the structure of '/path/to/save' is now
#
# ```
# path
# └── to
#     └── save
#         ├── 01_file
#         ├── 02_file
#         ├── 04_file
#         ├── file_001.txt
#         ├── file_002.txt
#         └── file_003.txt
# ```
#
# Then you can get the seriarised file name incremented by 1 like below:
#
# ```bash
# $ cd /path/to/save
#
# $ incfn -b file_ -e txt
# /path/to/save/file_004.txt
#
# $ incfn -n 2 -a _file
# /path/to/save/05_file
#
# $ incfn -d /path/to/other -b newfile_ -e md
# /path/to/other/newfile_001.md
# ```
#
# **Remark**
#
# This script prints a filename **whether the targeted directory exists or not**.
#=#= }}}

# this file's path
f="$0"

# default value
root_dir="$PWD"    # you can change by option -d
num_of_digits=3      # you can change by option -n

usage() {
  sed -n '/^# NAME$/,/^##$/p' "$f" | sed -e '$d' | cut -b3- >&2
}

checkint=0
while getopts d:n:b:a:e:hH OPT; do
  case ${OPT} in
    "d")
      root_dir="${OPTARG%/}"
      ;;
    "n")
      num_of_digits=${OPTARG}
      ;;
    "b")
      filename_before="${OPTARG}"
      checkint=$(($checkint+1))
      ;;
    "a")
      filename_after="${OPTARG}"
      checkint=$(($checkint+1))
      ;;
    "e")
      filename_extension="${OPTARG#\.}"
      checkint=$(($checkint+1))
      ;;
    "h")
      usage
      exit 0
      ;;
    "H")
      usage_all "$f"
      exit 0
      ;;
  esac
done

# check whether at least one necessary arguments are given
if [ $checkint = 0 ]; then
  usage
  echo "missing some necessary arguments" >&2
  exit 1
fi

# if filename_extension is not empty, add "." before the extension.
if [ -n "${filename_extension}" ]; then
  filename_extension="\.${filename_extension}"
fi

# make filename pattern
pattern='s/'"${filename_before}"'\([0-9]\{'"${num_of_digits}"'\}\)'
pattern="${pattern}${filename_after}${filename_extension}"'/\1/p'

if [ -d "${root_dir}" ]; then
  num="$(command -p ls "${root_dir}" | sed -n $pattern | tail -n 1)"
  i=$(expr "$num" + 1 2>/dev/null) || i=1
else
  i=1
fi

filename="${root_dir}/${filename_before}$(printf "%0${num_of_digits}d" $i)"
filename="$filename${filename_after}${filename_extension#\\}"

echo "${filename}"

exit 0
