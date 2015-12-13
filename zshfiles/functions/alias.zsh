# vim: set ft=zsh

# Alias
#------------------------------------------------------------------------------

# apt update
if hash apt-fast; then
  alias apt-upd='apt-fast update'
  alias apt-upg='apt-fast upgrade'
  alias apt-ins='apt-fast install'
else
  alias apt-upd='sudo apt update'
  alias apt-upg='sudo apt upgrade'
  alias apt-ins='sudo apt install'
fi

# git alias to "g"
alias g='git'
compdef g=git

alias v='vim'
compdef v=vim

# I often type ":q" to exit terminal
alias :q='exit'

# thefuck (https://github.com/nvbn/thefuck)
alias fuck='eval "$(thefuck $(fc -ln -1 | tail -n 1)); fc -R"'

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

function _speedometer() {
  speedometer -b -rx "$1" -tx "$1"
}
alias spdmeter='_speedometer'
