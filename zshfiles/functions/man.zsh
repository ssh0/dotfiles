# vim: set ft=zsh
#
# man (available for buitlin)
#----------------------------
#
# Can I get individual man pages for the bash builtin commands? - Unix & Linux Stack Exchange
#   http://unix.stackexchange.com/questions/18087/can-i-get-individual-man-pages-for-the-bash-builtin-commands
# manpage - How to make `man` work for shell builtin commands and keywords? - Ask Ubuntu
#   http://askubuntu.com/questions/439410/how-to-make-man-work-for-shell-builtin-commands-and-keywords

function man() {
  case "$(bash -c "type -t -- $1"):$1" in
    builtin:*|keyword:*) # built-in
      bash -c ". $HOME/.zsh/functions/less.zsh; help -m $1 | less"
      ;;
    *[[?*]*) # pattern
      bash -c ". $HOME/.zsh/functions/less.zsh; help -m $1 | less"
      ;;
    *) command -p man "$@";;  # something else, presumed to be an external command
                              # or options for the man command or a section number
  esac
}

