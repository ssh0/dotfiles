# Set environment variables

export ZSH_CACHE_DIR=$ZSH/cache

# PATH to /usr/local/lib
export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH

# set language environment
export LANG=en_US.UTF-8
export LC_TIME=en_US.UTF-8

# set PATH
export MANPATH="/usr/local/man:$MANPATH"

# find alternative apps if it is installed on your system
find_alt() {
  local i
  for i in $@; do
    hash "$i" 2>/dev/null && echo "$i" && return 0
  done
  return 1
}

# set the default program
# the first program in the array will be chosen as the default
export OPENER=$(find_alt xdg-open exo-open gnome-open )
export BROWSER=$(find_alt luakit firefox google-chrome chromium chromium-browser $OPENER )
export BROWSERCLI=$(find_alt w3m links2 links lynx elinks $OPENER )
export EDITOR=$(find_alt nvim vim emacs nano leafpad gedit pluma $OPENER )
export FILEMANAGER=$(find_alt thunar nautilus dolphin pcmanfm tspacefm enlightenment_filemanager $OPENER )
export PAGER=$(find_alt less more most)
export PERCOL=$(find_alt fzf peco percol)
export PLAYER=$(find_alt mpv mplayer cvlc $OPENER )
export READER=$(find_alt mupdf zathura evince $OPENER )
export TERMCMD=$(find_alt urxvt xterm gnome-terminal)

unfunction find_alt

# To stop ranger from loading both the default and my custom rc.conf
export RANGER_LOAD_DEFAULT_RC=false

# dot management (ssh0/dot)
export DOT_REPO="https://github.com/ssh0/dotfiles.git"
export DOT_DIR="$HOME/.dotfiles"

# enhancd by "c"
export ENHANCD_COMMAND='c'

# takenote
export TAKENOTE_ROOTDIR="$HOME/Workspace/blog"
export TAKENOTE_FILERCMD=ranger

