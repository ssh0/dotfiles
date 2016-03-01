# vim: set ft=zsh
#=#=#=
# Colorize some applications outputs
#
# * mplayer
# * twitter command
# * diff aliased to colordiff
# * tree -C
# * grep
#=#=

autoload -U colors && colors

## Alias

# mplayer alias
alias mplayer='mplayer -msgcolor'

# twitter color
alias twitter='twitter -f ansi'

# colordiff
if hash colordiff 2>/dev/null; then
  alias diff='colordiff -u'
else
  alias diff='diff -u'
fi

alias tree='tree -C'

alias grep="grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}"

if ls --color -d . &>/dev/null 2>&1; then
  alias ls='ls --color=tty'
else
  alias ls='ls -G'
fi

