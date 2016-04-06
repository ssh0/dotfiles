# vim: set ft=zsh
#=#=#=
# Set aliases (if available)
#
# **Ex)**
#
# * apt for apt-faset
# * vim for nvim
# * g for git
# * :q for exit
# * f for thefuck
# * cf-* (functions for editing some applications)
# * rl-* (functions for reload some applications)
#=#=

# apt update
if hash apt-fast 2>/dev/null; then
  alias apt-upd='apt-fast update'
  alias apt-upg='apt-fast upgrade'
  alias apt-ins='apt-fast install'
  alias apt-get='apt-fast'
else
  alias apt-upd='sudo apt update'
  alias apt-upg='sudo apt upgrade'
  alias apt-ins='sudo apt install'
fi

# git alias to "g"
alias g='git'

if hash nvim 2>/dev/null; then
  alias vim='nvim'
  alias vimdiff='nvim -d'
fi

alias v='vim'

alias r='ranger'

# I often type ":q" to exit terminal
alias :q='exit'

# s command
alias o='s'

alias info='info --vi-keys'

# thefuck (https://github.com/nvbn/thefuck)
alias f='eval "$(thefuck $(fc -ln -1 | tail -n 1)); fc -R"'

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

function _speedometer() {
  speedometer -b -rx "$1" -tx "$1"
}
alias spdmeter='_speedometer'

# enable aliases in sudo
alias sudo='sudo '

# edit configuration file by $EDITOR (vim).
function _ec() {
  if [[ -f "$2" ]]; then
    alias "cf-$1"="$EDITOR '$2'"
  elif [[ -d "$2" ]]; then
    alias "cf-$1"="builtin cd '$2'; ls"
  else
    alias "cf-$1::NEW"="echo \"File '$2' doesn't exist. \"; \
                     confirm y \"Create new one?\" && $EDITOR '$2'"
  fi
}

_ec alias        ${ZSH_ROOT}/functions/alias.zsh
_ec completion   ${ZSH_ROOT}/completions
_ec compton      ~/.config/compton/compton.conf
_ec dein         ~/.config/nvim/dein.toml
_ec dein_lazy    ~/.config/nvim/dein_lazy.toml
_ec dotlink      ~/.dotfiles/dotlink
_ec dotrc        ~/.dotfiles/dotrc
_ec env          ${ZSH_ROOT}/functions/environment.zsh
_ec functions    ${ZSH_ROOT}/functions
_ec history      ${ZSH_ROOT}/history
_ec latexmk      ~/.latexmkrc
_ec luakit       ~/.config/luakit
_ec mplayer      ~/.mplayer/config
_ec mpd          ~/.config/mpd/mpd.conf
_ec mpv          ~/.config/mpv/mpv.conf
_ec mutt         ~/.mutt/muttrc
_ec nvim         ~/.config/nvim/init.vim
_ec ncmpcpp      ~/.ncmpcpp/config
_ec prompt       ${ZSH_ROOT}/functions/prompt.zsh
_ec ranger       ~/.config/ranger/rc.conf
_ec ranger_rifle ~/.config/ranger/rifle.conf
_ec s            ~/bin/s_provider
_ec tig          ~/.tigrc
_ec tmux         ~/.tmux.conf
_ec turses       ~/.turses/config
_ec vim          ~/.vimrc
_ec vimcolor     ~/.vim/bundle/easy-reading.vim/colors/easy-reading.vim
_ec vimperator   ~/.vimperatorrc
_ec w3m          ~/.w3m/config
_ec w3m-keymap   ~/.w3m/keymap
_ec websearch    ~/Workspace/python/web_search/websearch/config.py
_ec xdefaults    ~/.Xdefaults
_ec xmodmap      ~/.Xmodmap
_ec xmonad       ~/.xmonad/xmonad.hs
_ec xresources   ~/.Xresources
_ec zshrc        ~/.zshrc
_ec zgen         ${ZSH_ROOT}/functions/zgen.zsh

unfunction _ec

# reload configurations
rl-xdefaults() { xrdb ~/.Xdefaults ;}
rl-xmodmap() { xmodmap ~/.Xmodmap ;}
rl-xresources() { xrdb -load ~/.Xresources ;}
rl-zshrc() { exec zsh -l ;}

