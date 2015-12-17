# vim: set ft=zsh

# Colorize 
#------------------------------------------------------------------------------

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

