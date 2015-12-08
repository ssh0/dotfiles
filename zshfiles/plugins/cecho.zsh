# vim: set ft=zsh
#
# cecho (color echo)

cecho() {
  local color
  case $1 in
    red) color=31 ;;
    green) color=32 ;;
    yellow) color=33 ;;
    blue) color=34 ;;
    magenta) color=35 ;;
    cyan) color=36 ;;
    *) return 1 ;;
  esac
  shift
  echo "\033[${color}m$@\033[m"
}

