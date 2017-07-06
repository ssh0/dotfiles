# vim: set ft=zsh
#=#=#=
# Set aliases (if available)
#
# **Ex)**
#
# * apt for apt-fast
# * vim for nvim
# * g for git
# * :q for exit
# * f for thefuck
# * cf-* (edit the configuration file of an application)
# * rl-* (reload the configuration file on an application)
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

alias vi='vim'
alias v='vim'

alias r='ranger'

# I often type ":q" to exit terminal
alias :q='exit'

# typo
alias py='python'
alias pytohn='python'

alias pyst='cd ~/Workspace/python/tuto && $EDITOR "$(incfn -b test -e py -n 2)"'

# pip install
alias pipins='sudo -H pip install'
# pip update
alias pipupd='sudo -H pip install -U'

# s command
alias o='s'

alias info='info --vi-keys'

alias updatedb='sudo /usr/libexec/locate.updatedb'

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
alias sudo='sudo -E '

alias hc='herbstclient'

# edit configuration file by $EDITOR (vim).
function _ec() {
  local cmd alis
  if [[ ! -e "$2" ]]; then
    alias "cf-$1::NEW"="echo \"File '$2' doesn't exist. \"; \
                     confirm y \"Create new one?\" && $EDITOR '$2'"
    return -1
  fi

  alis="$1"
  if [[ -n "$3" ]]; then
    local target
    target="$2"
    cmd="$3"
    shift 3
    cmd="$cmd '$target' "$@""
  elif [[ -f "$2" ]]; then
    cmd="$EDITOR '$2'"
  elif [[ -d "$2" ]]; then
    cmd="ranger --cmd='cd '$2''"
    # cmd="builtin cd '$2'; ls"
  fi
  alias "cf-${alis}"="$cmd"
  return 0
}


_ec alias      ${ZSH_ROOT}/functions/alias.zsh
_ec completion ${ZSH_ROOT}/completions
_ec compton    ~/.config/compton/compton.conf
_ec dotlink    ~/.dotfiles/dotlink
_ec dotrc      ~/.dotfiles/dotrc
_ec env        ${ZSH_ROOT}/functions/environment.zsh
_ec functions  ${ZSH_ROOT}/functions
_ec herbstluftwm ~/.config/herbstluftwm/autostart
_ec history    ${ZSH_ROOT}/history
_ec latexmk    ~/.latexmkrc
_ec luakit     ~/.config/luakit
_ec mplayer    ~/.mplayer/config
_ec mpd        ~/.config/mpd/mpd.conf
_ec mpv        ~/.config/mpv/mpv.conf
_ec mutt       ~/.mutt/muttrc
_ec nvim       ~/.config/nvim/init.vim
_ec ncmpcpp    ~/.ncmpcpp/config
_ec plug       ~/.config/nvim/plug.vim
_ec prompt     ${ZSH_ROOT}/functions/prompt.zsh
_ec ranger     ~/.config/ranger/rc.conf
_ec ranger.d   ~/.config/ranger
_ec s          ~/bin/s_provider
_ec tig        ~/.tigrc
_ec tmux       ~/.tmux.conf
_ec turses     ~/.turses/config
_ec vim        ~/.vimrc
_ec vimcolor   ~/gitrepo/easy-reading.vim/colors/easy-reading.vim
_ec vimperator ~/.vimperatorrc
_ec w3m        ~/.w3m/config
_ec w3m-keymap ~/.w3m/keymap
_ec websearch  ~/Workspace/python/web_search/websearch/config.py
_ec xdefaults  ~/.Xdefaults
_ec xmodmap    ~/.Xmodmap
_ec xmonad     ~/.xmonad/xmonad.hs
_ec xresources ~/.Xresources
_ec zplug      ${ZSH_ROOT}/functions/zplug.zsh
_ec zshrc      ~/.zshrc
_ec zgen       ${ZSH_ROOT}/functions/zgen.zsh

unfunction _ec

# reload configurations
rl-xdefaults() { xrdb ~/.Xdefaults ;}
rl-xmodmap() { xmodmap ~/.Xmodmap ;}
rl-xresources() { xrdb -load ~/.Xresources ;}
rl-zgen() { source $HOME/.zgen/tarjoilija/zgen-master/zgen.zsh ;}
rl-zplug() { source $HOME/.zplug/init.zsh ;}
rl-zshrc() { exec zsh -l ;}

# Get recent config file and edit the file with vimdiff
function _uc() {
  local alis org target
  alis=$1
  org=$2
  target=$3
  shift 3

  alias "uc-${alis}"="eval $@ && vimdiff ${org} ${target}"
  return 0
}

# _uc alias original target_config update_cmd

_uc ranger ~/gitrepo/ranger/ranger/config/rc.conf ~/.config/ranger/rc.conf 'builtin cd ~/gitrepo/ranger && git pull && sudo make install && builtin cd -'
_uc rifle ~/gitrepo/ranger/ranger/config/rifle.conf ~/.config/ranger/rifle.conf 'builtin cd ~/gitrepo/ranger && git pull && sudo make install && builtin cd -'

unfunction _uc
