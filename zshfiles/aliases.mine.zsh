# vim: set ft=zsh
# written by Shotaro Fujimoto (https://github.com/ssh0)
#------------------------------------------------------------------------------
# export variables                                                          {{{
#------------------------------------------------------------------------------

# find alternative apps if it is installed on your system
find_alt() { for i;do which "$i" >/dev/null && { echo "$i"; return 0;};done;return 1; }

# set the default program
# the first program in the array will be chosen as the default
export OPENER=$(find_alt xdg-open exo-open gnome-open )
export BROWSER=$(find_alt luakit firefox google-chrome chromium chromium-browser $OPENER )
export BROWSERCLI=$(find_alt w3m links2 links lynx elinks $OPENER )
export EDITOR=$(find_alt vim emacs nano leafpad gedit pluma $OPENER )
export FILEMANAGER=$(find_alt thunar nautilus dolphin pcmanfm tspacefm enlightenment_filemanager $OPENER )
export PAGER=$(find_alt less more most)
export PLAYER=$(find_alt mpv mplayer cvlc $OPENER )
export READER=$(find_alt mupdf zathura evince $OPENER )
export TERMCMD=$(find_alt urxvt xterm gnome-terminal)

#---------------------------------------------------------------------------}}}
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

# mplayer alias
alias mplayer='mplayer -msgcolor'

# twitter color
alias twitter='twitter -f ansi'

# colordiff
if [[ -x `which colordiff` ]]; then
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
    if which tac > /dev/null; then
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
  vim $(ag $@ | peco --query "$LBUFFER" --prompt ">" | awk -F : '{printf("-c %s %s"),$2,$1;}')
}

#---------------------------------------------------------------------------}}}
# takenote                                                                  {{{
#------------------------------------------------------------------------------

function takenote() {
  local get_dir=false
  local get_name=false
  local alternative=false
  local show_list=false
  local filercmd=r
  local filer=false
  local rootdir=$HOME/Workspace/blog
  local pattern='s/note_\([0-9]\{2\}\).md/\1/p'

  show_usage() {
    echo "Usage: takenote [-d dir] [-o filename] [-g editor] [-l] [-r] [-h]"
    echo "  -d dir     : set the saving directory (default: '$rootdir')"
    echo "  -o filename: set the file's name"
    echo "  -g editor  : open with an altenative program (default: '$EDITOR')"
    echo "  -l         : list the today's files"
    echo "  -r         : open the today's dir or the root dir with the filer (default: '$filercmd')"
    echo "  -h         : show this message"
  }

  check_dir() {
    if [ ! -e "$1" ]; then
      echo "Directory '$1' doesn't exist."
      return 1
    fi
  }

  while getopts d:o:g:lrh OPT
  do
    case $OPT in
      "d" ) get_dir=true
            dir="$OPTARG" ;;
      "o" ) get_name=true
            name="$OPTARG" ;;
      "g" ) alternative=true
            editor="$OPTARG" ;;
      "l" ) show_list=true ;;
      "r" ) filer=true ;;
      "h" ) show_usage;
            return 0 ;;
        * ) show_usage;
            return 0 ;;
    esac
  done

  # set the saving directory
  if ! $get_dir; then
    if check_dir "$rootdir"; then
      daydir=$(date +%Y-%m-%d)
      dir=$rootdir/$daydir
    else
      return 1
    fi
  fi

  # only show existing file in the directory
  if $show_list; then
    if check_dir "$dir"; then
      list=$(ls "$dir")
      echo "$list"
    fi
    return 0
  fi

  # move to today's directory by the user defined filer
  if $filer; then
    if [ ! -e "$dir" ]; then
      echo "Today's directory has not been created yet."
      echo "Open root directory '$rootdir' ..."
      "$filercmd" "$rootdir"
    else
      "$filercmd" "$dir"
    fi
    return 0
  fi

  # set the filename
  if ! $get_name; then
    if [ ! -e "$dir" ]; then
      i=1
    else
      i=$(( $(ls "$dir" | sed -n $pattern | tail -n 1) + 1 ))
    fi
    name="$(printf note_%02d.md "$i")"
  fi

  # change directory
  local cwd="`pwd`"
  cd $dir

  if $alternative; then
    $editor "$dir/$name"
  else
    $EDITOR "$dir/$name"
  fi

  # back to recent working directory
  cd $cwd

  return 0
}

#---------------------------------------------------------------------------}}}
# shtest                                                                    {{{
#------------------------------------------------------------------------------

function shtest() {
  show_usage() {
    echo ""
    echo "Make testing snippet for shell script."
    echo ""
    echo "Usage: show_usage [OPTION]"
    echo ""
    echo "Option:"
    echo "  -o FILE: Set the file name to save. "
    echo "  -l     : List the formatted files."
    echo "  -h     : Show this message."
  }

  local pattern='s/test_\([0-9]\{2\}\).sh/\1/p'
  local pattern_full='s/\(test_[0-9]\{2\}.sh\)/\1/p'
  local get_name=false
  local dir="$HOME/bin"
  local cwd="`pwd`"

  show_list() {
    list="$(ls "$dir" | sed -n $pattern_full)"
    echo "$list"
  }

  while getopts o:lh OPT
  do
    case $OPT in
      "o" ) get_name=true
            name="$OPTARG" ;;
      "l" ) show_list
            return 0 ;;
      "h" ) show_usage;
            return 1 ;;
        * ) show_usage;
            return 1 ;;
    esac
  done

  if ! $get_name; then
    i=$(( $(ls "$dir" | sed -n $pattern | tail -n 1) + 1 ))
    name="$(printf test_%02d.sh "$i")"
  fi

  # change directory
  cd $dir
  $EDITOR "$dir/$name"

  # return to recent working directory
  cd $cwd

  return 0
}

#---------------------------------------------------------------------------}}}
# zsh-bd                                                                    {{{
#------------------------------------------------------------------------------
# Quickly go back to aspecific parent directory instead of typing cd ../../../
# [Tarrasch/zsh-bd](https://github.com/Tarrasch/zsh-bd)

function bd () {
  (($#<1)) && {
    print -- "usage: $0 <name-of-any-parent-directory>"
    print -- "       $0 <number-of-folders>"
    return 1
  } >&2
  local num=${#${(ps:/:)${PWD} }}
  local dest="./"

  # If the user provided an integer, go up as many times as asked
  if [[ "$1" = <-> ]]
  then
    if [[ $1 -gt $num ]]
    then
      print -- "bd: Error: Can not go up $1 times (not enough parent directories)"
      return 1
    fi
    for i in {1..$1}
    do
      dest+="../"
    done
    cd $dest
    return 0
  fi

  # else, find the correct parent directory
  # Get parents (in reverse order)
  local parents
  local i
  for i in {$((num+1))..2}
  do
    parents=($parents "$(echo $PWD | cut -d'/' -f$i)")
  done
  parents=($parents "/")
  # Build dest and 'cd' to it
  local parent
  foreach parent (${parents})
  do
    if [[ $1 == $parent ]]
    then
      cd $dest
      return 0
    fi
    dest+="../"
  done
  print -- "bd: Error: No parent directory named '$1'"
  return 1
}
_bd () {
  # Get parents (in reverse order)
  local num=${#${(ps:/:)${PWD}} }
  local i
  for i in {$((num+1))..2}
  do
    reply=($reply "`echo $PWD | cut -d'/' -f$i`")
  done
  reply=($reply "/")
}
compctl -V directories -K _bd bd

#---------------------------------------------------------------------------}}}
# Configurations                                                            {{{
#------------------------------------------------------------------------------

cfg-aliases() { $EDITOR ~/.aliases.mine.zsh ;}
cfg-compton() { $EDITOR ~/.config/compton/compton.conf ;}
cfg-dotfiles() { $EDITOR ~/.dotfiles/setup_config_link ;}
cfg-history() { $EDITOR ~/.zsh_history ;}
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
cfg-zshrc() { $EDITOR ~/.zshrc.mine ;}

#---------------------------------------------------------------------------}}}
# Configurations Reload                                                     {{{
#------------------------------------------------------------------------------

rld-xdefaults() { xrdb ~/.Xdefaults ;}
rld-xmodmap() { xmodmap ~/.Xmodmap ;}
rld-xresources() { xrdb -load ~/.Xresources ;}
rld-zshrc() { source ~/.zshrc ;}

#---------------------------------------------------------------------------}}}
