# vim: set ft=zsh
#
# man (available for buitlin and so on)
#--------------------------------------
#
# Can I get individual man pages for the bash builtin commands? - Unix & Linux Stack Exchange
#   http://unix.stackexchange.com/questions/18087/can-i-get-individual-man-pages-for-the-bash-builtin-commands
# manpage - How to make `man` work for shell builtin commands and keywords? - Ask Ubuntu
#   http://askubuntu.com/questions/439410/how-to-make-man-work-for-shell-builtin-commands-and-keywords
#
# But I want to know about zsh builtins, so I wrote this.
#
# Install zsh manuals to enable `man zshbuiltins`:
#     $ mkdir -p ~/Downloads/zsh-doc; cd $_
#     $ wget http://downloads.sourceforge.net/project/zsh/zsh/5.0.2/zsh-5.0.2.tar.bz2
#     $ tar -xvf zsh-5.0.2.tar.bz2
#     $ sudo cp Doc/*.1 /usr/local/share/man/man1
#
# Require:
#     * fzf
#
# Optional:
#     * "highlight" for highlighting scripts
#     * LESS="R" option for ansi color in "less" command
# 

function man() {
  case "$(whence -wa -- $1 | uniq | fzf -1 | sed 's/: / /' | cut -d' ' -f2)" in
    builtin) # built-in
      /usr/bin/man --pager="less -p'^       \\$1 '" zshbuiltins
      # TODO: how many spaces before the commands?
      ;;
    reserved) # reserved words
      /usr/bin/man --pager="less -p'^COMPLEX COMMANDS$'" zshall
      ;;
    alias) # alias
      whence -c $1
      ;;
    function) # function
      if hash highlight 2>/dev/null; then
        whence -f "$(whence $1)" \
          | highlight --out-format=ansi --src-lang=Bash \
          | ${MANPAGER:-${PAGER:-less}}
      else
        whence -f "$(whence $1)" | ${MANPAGER:-${PAGER:-less}}
      fi
      ;;
    *) /usr/bin/man "$@"
      ;;
  esac
}

