# vim: set ft=zsh
#=#=#=
# man (available for buitlin commands)
#
# **Features:**
#
# * for zsh builtin commands
# * for reserved word
# * for alias
# * for zsh function
# * for (natural) command
# * if the same name exists, choose one by fzf
# * with color
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
# * "pygmentize" or "highlight" for highlighting scripts
# * LESS="R" option for ansi color in "less" command
#=#=

function man() {
  # Stock current LANG
  _LANG=${LANG}

  # set language (but if MANLANG is already set, use that)
  export LANG=${MANLANG:-${_LANG}}

  function restore_lang() {
    # restore LANG and clean up name space
    export LANG=${_LANG}
    unset _LANG
    unset -f $0
  }

  trap restore_lang 1 2 3 EXIT

  if [ ! -n "$1" ]; then
    echo "What manual page do you want?"
    return 1
  fi

  # get man type (using fzf but you can replace it with peco or percol or zaw)
  word="$(whence -wa -- $1 | uniq | fzf -1 | sed 's/: / /' | cut -d' ' -f2)"

  # if escaped, do nothing
  if [ ! -n "${word}" ]; then
    return 0
  fi

  # switch operation by word
  case ${word} in
    builtin) # built-in command
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
    *) # try using man
      /usr/bin/man "$@"
      ;;
  esac
}

