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

# colored less
export LESS_TERMCAP_mb=$(tput bold)                # begin blinking
export LESS_TERMCAP_md=$(tput bold; tput setaf 4)  # begin bold (white)
export LESS_TERMCAP_me=$(tput sgr0)                # end mode
export LESS_TERMCAP_se=$(tput sgr0)                # end standout-mode
export LESS_TERMCAP_so=$(tput bold; tput setaf 3)  # begin standout-mode (yellow)
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)     # end underline
export LESS_TERMCAP_us=$(tput smul; tput setaf 2)  # begin underline (green)

alias tree='tree -C'

alias grep="grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}"

