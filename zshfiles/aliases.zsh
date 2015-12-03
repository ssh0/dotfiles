# vim: set ft=zsh
# written by Shotaro Fujimoto (https://github.com/ssh0)
#------------------------------------------------------------------------------
# Alias                                                                     {{{
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

# Colorize 
# ========

# mplayer alias
alias mplayer='mplayer -msgcolor'

# twitter color
alias twitter='twitter -f ansi'

# colordiff
if hash colordiff; then
  alias diff='colordiff -u'
else
  alias diff='diff -u'
fi

# color echo
cecho() {
  local color
  case $1 in
    red) color=31 ;;
    green) color=32 ;;
    yellow) color=33 ;;
    blue) color=34 ;;
    magenta) color=35 ;;
    cyan) color=36 ;;
    *) return 1 ;;
  esac
  shift
  echo "\033[${color}m$@\033[m"
}

alias tree='tree -C'

# speedometer
function _speedometer() {
  speedometer -b -rx "$1" -tx "$1"
}
alias spdmeter='_speedometer'

#---------------------------------------------------------------------------}}}
# extract images                                                            {{{
#------------------------------------------------------------------------------

function extract() {
  case $1 in
    *.tar.gz|*.tgz) tar xzvf $1;;
    *.tar.xz) tar Jxvf $1;;
    *.zip) unzip $1;;
    *.lzh) lha e $1;;
    *.tar.bz2|*.tbz) tar xjvf $1;;
    *.tar.Z) tar zxvf $1;;
    *.gz) gzip -d $1;;
    *.bz2) bzip2 -dc $1;;
    *.Z) uncompress $1;;
    *.tar) tar xvf $1;;
    *.arj) unarj $1;;
  esac
}
alias -s {qz,tgz,zip,lzh,bz2,tbz,Z,tar,arj,xz}=extract
alias -s {png,jpg,bmp,PNG,JPG,BMP}='feh --scale-down'

#---------------------------------------------------------------------------}}}
# ranger-cd                                                                 {{{
#------------------------------------------------------------------------------
# Compatible with ranger 1.4.2 through 1.7.*
#
# Automatically change the directory in bash after closing ranger
#
# This is a bash function for .bashrc to automatically change the directory to
# the last visited one after ranger quits.
# To undo the effect of this function, you can type "cd -" to return to the
# original directory.

function ranger-cd {
    tempfile="$(mktemp -t tmp.XXXXXXX)"
    # for manual install
    /usr/local/bin/ranger --choosedir="$tempfile" "${@:-$(pwd)}"
    # for package install
    # /usr/bin/ranger --choosedir="$tempfile" "${@:-$(pwd)}"
    test -f "$tempfile" &&
    if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
        cd -- "$(cat "$tempfile")"
    fi
    rm -f -- "$tempfile"
}

#---------------------------------------------------------------------------}}}
# Start new ranger instance only if it's not running in current shell       {{{
#------------------------------------------------------------------------------
# https://wiki.archlinux.org/index.php/Ranger#Start_new_ranger_instance_only_if_it.27s_not_running_in_current_shell

function r() {
    if [ -z "$RANGER_LEVEL" ]; then
        ranger-cd $@
    else
        exit
    fi
}
compdef r=ranger

#---------------------------------------------------------------------------}}}
# peco-history alias                                                        {{{
#------------------------------------------------------------------------------

function peco-select-history() {
    typeset tac
    if hash tac > /dev/null; then
        tac=tac
    else
        tac='tail -r'
    fi
    BUFFER=$(fc -l -n 1 | eval $tac | peco --query "$LBUFFER" --prompt ">")
    CURSOR=$#BUFFER
    zle redisplay
}
zle -N peco-select-history

#---------------------------------------------------------------------------}}}
# agvim                                                                     {{{
# http://qiita.com/fmy/items/b92254d14049996f6ec3
#------------------------------------------------------------------------------

function agvim(){
  local agfilepath
  agfilepath="$(echo $(ag $@ | peco --query "$LBUFFER" | awk -F : '{print "+" $2 " \047" $1 "\047"}'))"
  if [ "$agfilepath" != "" ]; then
    eval $(echo "vim $agfilepath")
  fi
}

#---------------------------------------------------------------------------}}}
# shtest                                                                    {{{
#------------------------------------------------------------------------------

export SHTEST_FILENAME_PRE="test_"
export SHTEST_FILENAME_EXTENSION="sh"


function shtest() {

  show_usage() {
    echo ""
    echo "shtest - Make testing snippet for shell script."
    echo ""
    echo "Usage: shtest [OPTION]"
    echo ""
    echo "Option:"
    echo "  -o FILE: Set the file name to save. "
    echo "  -l     : List the files."
    echo "  -h     : Show this message."
  }

  if [ "$1" = "-h" ]; then
    show_usage
    return 1
  fi

  local _TAKENOTE_FILENAME_PRE="${TAKENOTE_FILENAME_PRE}"
  local _TAKENOTE_FILENAME_EXTENSION="${TAKENOTE_FILENAME_EXTENSION}"

  TAKENOTE_FILENAME_PRE="${SHTEST_FILENAME_PRE}"
  TAKENOTE_FILENAME_EXTENSION="${SHTEST_FILENAME_EXTENSION}"

  takenote -d "$HOME/bin" $@

  export TAKENOTE_FILENAME_PRE="${_TAKENOTE_FILENAME_PRE}"
  export TAKENOTE_FILENAME_EXTENSION="${_TAKENOTE_FILENAME_EXTENSION}"

  return 0
}

#---------------------------------------------------------------------------}}}
# Notification of local host command {{{
# ----------------------------------
#
# Automatic notification via growlnotify / notify-send
#
#
# Notification of remote host command
# -----------------------------------
#
# "==ZSH LONGRUN COMMAND TRACKER==" is printed after long run command execution
# You can utilize it as a trigger
#
# ## Example: iTerm2 trigger( http://qiita.com/yaotti/items/3764572ea1e1972ba928 )
#
#  * Trigger regex: ==ZSH LONGRUN COMMAND TRACKER==(.*)
#  * Parameters: \1
#

__timetrack_threshold=300 # seconds
read -r -d '' __timetrack_ignore_progs <<EOF
less
emacs vi vim
ssh mosh telnet nc netcat
tmux mux
gdb
ranger r
mplayer
man
cmus
alarm
takenote
EOF

export __timetrack_threshold
export __timetrack_ignore_progs

function __my_preexec_start_timetrack() {
    local command=$1

    export __timetrack_start=`date +%s`
    export __timetrack_command="$command"
}

function __my_preexec_end_timetrack() {
    local exec_time
    local command=$__timetrack_command
    local prog=$(echo $command|awk '{print $1}')
    local notify_method
    local message

    export __timetrack_end=`date +%s`

    if test -n "${REMOTEHOST}${SSH_CONNECTION}"; then
        notify_method="remotehost"
    elif hash growlnotify >/dev/null 2>&1; then
        notify_method="growlnotify"
    elif hash notify-send >/dev/null 2>&1; then
        notify_method="notify-send"
    else
        return
    fi

    if [ -z "$__timetrack_start" ] || [ -z "$__timetrack_threshold" ]; then
        return
    fi

    for ignore_prog in $(echo $__timetrack_ignore_progs); do
        [ "$prog" = "$ignore_prog" ] && return
    done

    exec_time=$((__timetrack_end-__timetrack_start))
    if [ -z "$command" ]; then
        command="<UNKNOWN>"
    fi

    message="Command finished!\nTime: $exec_time seconds\nCOMMAND: $command"

    if [ "$exec_time" -ge "$__timetrack_threshold" ]; then
        case $notify_method in
            "remotehost" )
        # show trigger string
                echo -e "\e[0;30m==ZSH LONGRUN COMMAND TRACKER==$(hostname -s): $command ($exec_time seconds)\e[m"
        sleep 1
        # wait 1 sec, and then delete trigger string
        echo -e "\e[1A\e[2K"
                ;;
            "growlnotify" )
                echo "$message" | growlnotify -n "ZSH timetracker" --appIcon Terminal
                ;;
            "notify-send" )
                notify-send "ZSH timetracker" "$message" \
                    -i /usr/share/icons/gnome/scalable/status/dialog-information-symbolic.svg
                paplay /usr/share/sounds/freedesktop/stereo/complete.oga
                ;;
        esac
    fi

    unset __timetrack_start
    unset __timetrack_command
}

if hash growlnotify >/dev/null 2>&1 ||
    hash >/dev/null 2>&1 ||
    test -n "${REMOTEHOST}${SSH_CONNECTION}"; then
    add-zsh-hook preexec __my_preexec_start_timetrack
    add-zsh-hook precmd __my_preexec_end_timetrack
fi

# }}}
# Configurations                                                            {{{
#------------------------------------------------------------------------------

cfg-aliases() { $EDITOR ${ZSH_ROOT}/aliases.zsh ;}
cfg-compton() { $EDITOR ~/.config/compton/compton.conf ;}
cfg-dotlink() { $EDITOR ~/.dotfiles/dotlink ;}
cfg-dotrc() { $EDITOR ~/.dotfiles/dotrc ;}
cfg-history() { $EDITOR ${ZSH_ROOT}/history ;}
cfg-latexmkrc() { $EDITOR ~/.latexmkrc ;}
cfg-luakit() { $EDITOR ~/.config/luakit ;}
cfg-mpv() { $EDITOR ~/.mpv/config ;}
cfg-mplayer() { $EDITOR ~/.mplayer/config ;}
cfg-ranger() { $EDITOR ~/.config/ranger/rc.conf ;}
cfg-ranger-rifle() { $EDITOR ~/.config/ranger/rifle.conf ;} # edit open_with extensions
cfg-ranger-commands() { $EDITOR ~/.config/ranger/commands.py ;} # scripts
cfg-tig() { $EDITOR ~/.tigrc ;}
cfg-tmux() { $EDITOR ~/.tmux.conf ;}
cfg-tmuxinator() { $EDITOR ~/.tmuxinator/ ;}
cfg-turses() { $EDITOR ~/.turses/config ;}
cfg-vimcolor() { $EDITOR ~/.vim/bundle/easy-reading.vim/colors/easy-reading.vim ;}
cfg-vimperatorrc() { $EDITOR ~/.vimperatorrc ;}
cfg-vim() { $EDITOR ~/.vimrc ;}
cfg-xdefaults() { $EDITOR ~/.Xdefaults ;}
cfg-xmodmap() { $EDITOR ~/.Xmodmap ;}
cfg-xmonad() { $EDITOR ~/.xmonad/xmonad.hs ;}
cfg-xresources() { $EDITOR ~/.Xresources ;}
cfg-websearch() { $EDITOR ~/Workspace/python/web_search/websearch/config.py ;}
cfg-zshrc() { $EDITOR ~/.zshrc ;}

#---------------------------------------------------------------------------}}}
# Configurations Reload                                                     {{{
#------------------------------------------------------------------------------

rld-xdefaults() { xrdb ~/.Xdefaults ;}
rld-xmodmap() { xmodmap ~/.Xmodmap ;}
rld-xresources() { xrdb -load ~/.Xresources ;}
rld-zshrc() { exec zsh -l ;}

#---------------------------------------------------------------------------}}}
