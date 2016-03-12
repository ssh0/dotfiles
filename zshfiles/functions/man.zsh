# vim: set ft=zsh
#=#=#=
# man (available for buitlin commands)
#
# >* [Can I get individual man pages for the bash builtin commands? - Unix & Linux Stack Exchange](http://unix.stackexchange.com/questions/18087/can-i-get-individual-man-pages-for-the-bash-builtin-commands)
# >* [manpage - How to make `man` work for shell builtin commands and keywords? - Ask Ubuntu](http://askubuntu.com/questions/439410/how-to-make-man-work-for-shell-builtin-commands-and-keywords)
#
# But I want to know about zsh builtins, so I wrote this.
#
# Install zsh manuals to enable `man zshbuiltins`:
#
# ```
# $ mkdir -p ~/Downloads/zsh-doc; cd $_
# $ wget http://downloads.sourceforge.net/project/zsh/zsh/5.0.2/zsh-5.0.2.tar.bz2
# $ tar -xvf zsh-5.0.2.tar.bz2
# $ sudo cp zsh-5.0.2/Doc/*.1 /usr/local/share/man/man1
# ```
#
# **Require:**
#
# * fzf
#
# **Optional:**
#
# * "pygmentize" or "highlight" for highlighting scripts
# * LESS="R" option for ansi color in "less" command
#=#=

function man() {
  local _LANG=${LANG:-"en_US.UTF-8"}
  # set language
  export LANG=${MANLANG:-${_LANG}}

  case "$(whence -wa -- $1 | uniq | fzf -1 | sed 's/: / /' | cut -d' ' -f2)" in
    builtin) # built-in
      local man_indent _space
      # TODO: get how many spaces before the commands
      man_indent=7
      _space="$(printf '%*s' "$man_indent" '')"
      /usr/bin/man --pager="less -p'^${_space}\\$1 '" zshbuiltins
      ;;
    reserved) # reserved words
      /usr/bin/man --pager="less -p'^COMPLEX COMMANDS$'" zshall
      ;;
    alias) # alias
      whence -c $1
      ;;
    function) # function
      if hash pygmentize 2>/dev/null; then
        whence -f "$1" \
          | pygmentize -l sh \
          | ${MANPAGER:-${PAGER:-less}}
      elif hash highlight 2>/dev/null; then
        whence -f "$1" \
          | highlight --out-format=ansi --src-lang=Bash \
          | ${MANPAGER:-${PAGER:-less}}
      else
        whence -f "$1" | ${MANPAGER:-${PAGER:-less}}
      fi
      ;;
    *) /usr/bin/man "$@"
      ;;
  esac
  export LANG=${_LANG}
}

