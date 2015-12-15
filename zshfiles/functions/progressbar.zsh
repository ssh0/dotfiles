#!/usr/bin/zsh
# written by Shotaro Fujimoto (https://github.com/ssh0)
# first edited: 2015-12-03
#
# make progress bar easily
#
# bash - How to add a progress bar to a shell script? - Stack Overflow
# http://stackoverflow.com/questions/238073/how-to-add-a-progress-bar-to-a-shell-script

progressbar() {
  # Usage:
  #   progressbar progress(int: 0 ~ 100) [ barchar_empty barchar_fill ]
  local barchar_empty barchar_fill columns _done _left _fill _empty

  barchar_empty="${2:--}"
  barchar_fill="${3:-#}"

  # TODO: バー以外の文字数をautodetect
  columns=$(( $(tput cols) - 18 ))
  if [[ ${columns} -gt 100 ]]; then
    columns=100
  fi

  # Process data
  _done=$(( ($1 * ${columns}) / 100 ))
  _left=$(( ${columns} - $done ))
  # Build progressbar string lengths
  _fill=$(printf "%${_done}s")
  _empty=$(printf "%${_left}s")

  # Generate progressbar
  printf "\rProgress : [${_fill// /"$barchar_fill"}${_empty// /"$barchar_empty"}] ${1}%%"
}

# EXAMPLE
#
# # Variables
# varstart=1
# 
# # This accounts as the "totalState" variable for the ProgressBar function
# varend=99
# 
# # Proof of concept
# for number in $(seq ${varstart} ${varend})
# do
#   sleep 0.01
#   # progress (int: 0 ~ 100)
#   progress=$(( (${number}*100/${varend}*100) / 100 ))
#   # barchar_fill="${3:-█}"
#   ProgressBar ${progress}
# done
# printf '\nFinished!\n'
# 

