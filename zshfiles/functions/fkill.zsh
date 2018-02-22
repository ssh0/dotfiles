# vim: set ft=zsh
#=#=#=
# Kill process
#
# fuzzy process search -> kill the selected processes
#=#=
function fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}
