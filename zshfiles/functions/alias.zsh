# vim: set ft=zsh

# Alias
#------------------------------------------------------------------------------

# apt update
if hash apt-fast 2>/dev/null; then
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

if hash nvim 2>/dev/null; then
  alias vim='nvim'
  alias vimdiff='nvim -d'
fi

alias v='vim'
compdef v=vim

# I often type ":q" to exit terminal
alias :q='exit'

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

# edit config file
cf-alias() { $EDITOR ~/.zsh/functions/alias.zsh ;}
cf-compton() { $EDITOR ~/.config/compton/compton.conf ;}
cf-dotlink() { $EDITOR ~/.dotfiles/dotlink ;}
cf-dotrc() { $EDITOR ~/.dotfiles/dotrc ;}
cf-environmnet() { $EDITOR ~/.zsh/functions/environment.zsh ;}
cf-functions() { $EDITOR ~/.zsh/functions ;}
cf-history() { $EDITOR ${ZSH_ROOT}/history ;}
cf-latexmkrc() { $EDITOR ~/.latexmkrc ;}
cf-luakit() { $EDITOR ~/.config/luakit ;}
cf-mplayer() { $EDITOR ~/.mplayer/config ;}
cf-mpv() { $EDITOR ~/.config/mpv/mpv.conf ;}
cf-mutt() { $EDITOR ~/.mutt/muttrc ;}
cf-nvim() { $EDITOR ~/.config/nvim/init.vim ;}
cf-ranger() { $EDITOR ~/.config/ranger/rc.conf ;}
cf-ranger-rifle() { $EDITOR ~/.config/ranger/rifle.conf ;} # edit open_with extensions
cf-tig() { $EDITOR ~/.tigrc ;}
cf-tmux() { $EDITOR ~/.tmux.conf ;}
cf-turses() { $EDITOR ~/.turses/config ;}
cf-vim() { $EDITOR ~/.vimrc ;}
cf-vimcolor() { $EDITOR ~/.vim/bundle/easy-reading.vim/colors/easy-reading.vim ;}
cf-vimperatorrc() { $EDITOR ~/.vimperatorrc ;}
cf-w3m() { $EDITOR ~/.w3m/config ;}
cf-w3m-keymap() { $EDITOR ~/.w3m/keymap ;}
cf-websearch() { $EDITOR ~/Workspace/python/web_search/websearch/config.py ;}
cf-xdefaults() { $EDITOR ~/.Xdefaults ;}
cf-xmodmap() { $EDITOR ~/.Xmodmap ;}
cf-xmonad() { $EDITOR ~/.xmonad/xmonad.hs ;}
cf-xresources() { $EDITOR ~/.Xresources ;}
cf-zshrc() { $EDITOR ~/.zshrc ;}

# reload configurations
rl-xdefaults() { xrdb ~/.Xdefaults ;}
rl-xmodmap() { xmodmap ~/.Xmodmap ;}
rl-xresources() { xrdb -load ~/.Xresources ;}
rl-zshrc() { exec zsh -l ;}

