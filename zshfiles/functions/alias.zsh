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
function edit_config() {
  if [[ -e "$2" ]]; then
    alias "cf-$1"="$EDITOR '$2'"
  else
    alias "cf-$1::NEW"="echo \"File '$2' doesn't exist. \nCreate new one ...\"; \
                     sleep 1; \
                     $EDITOR '$2'"
  fi
}

edit_config alias        ${ZSH_ROOT}/functions/alias.zsh
edit_config compton      ~/.config/compton/compton.conf
edit_config dotlink      ~/.dotfiles/dotlink
edit_config dotrc        ~/.dotfiles/dotrc
edit_config env          ${ZSH_ROOT}/functions/environment.zsh
edit_config functions    ${ZSH_ROOT}/functions
edit_config history      ${ZSH_ROOT}/history
edit_config latexmk      ~/.latexmkrc
edit_config luakit       ~/.config/luakit
edit_config mplayer      ~/.mplayer/config
edit_config mpd          ~/.config/mpd/mpd.conf
edit_config mpv          ~/.config/mpv/mpv.conf
edit_config mutt         ~/.mutt/muttrc
edit_config nvim         ~/.config/nvim/init.vim
edit_config ncmpcpp      ~/.ncmpcpp/config
edit_config prompt       ${ZSH_ROOT}/functions/prompt.zsh
edit_config ranger       ~/.config/ranger/rc.conf
edit_config ranger_rifle ~/.config/ranger/rifle.conf
edit_config s            ~/bin/s_provider
edit_config tig          ~/.tigrc
edit_config tmux         ~/.tmux.conf
edit_config turses       ~/.turses/config
edit_config vim          ~/.vimrc
edit_config vimcolor     ~/.vim/bundle/easy-reading.vim/colors/easy-reading.vim
edit_config vimperator   ~/.vimperatorrc
edit_config w3m          ~/.w3m/config
edit_config w3m-keymap   ~/.w3m/keymap
edit_config websearch    ~/Workspace/python/web_search/websearch/config.py
edit_config xdefaults    ~/.Xdefaults
edit_config xmodmap      ~/.Xmodmap
edit_config xmonad       ~/.xmonad/xmonad.hs
edit_config xresources   ~/.Xresources
edit_config zshrc        ~/.zshrc
edit_config zgen         ${ZSH_ROOT}/functions/zgen.zsh

unfunction edit_config

# reload configurations
rl-xdefaults() { xrdb ~/.Xdefaults ;}
rl-xmodmap() { xmodmap ~/.Xmodmap ;}
rl-xresources() { xrdb -load ~/.Xresources ;}
rl-zshrc() { exec zsh -l ;}

