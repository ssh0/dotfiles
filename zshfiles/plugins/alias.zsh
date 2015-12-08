# vim: set ft=zsh

# Alias
#------------------------------------------------------------------------------

# apt update
alias apt-upd='sudo apt update'

# apt upgrade
alias apt-upg='sudo apt upgrade'
#
# git alias to "g"
alias g='git'
compdef g=git

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

