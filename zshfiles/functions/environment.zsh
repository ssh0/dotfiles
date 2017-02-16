#=#=#=
# Set environment variables
#
# **Features**
#
# * language
# * default application (find_alt is useful function)
# * some applications options (ranger, enhancd, takenote, cheat)
#=#=

export ZSH_CACHE_DIR=$ZSH/cache

# PATH to /usr/local/lib
export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH

# XDG_CONFIG_HOME
export XDG_CONFIG_HOME=$HOME/.config

# set language environment
export LANG=en_US.UTF-8
export MANLANG=ja_JP.UTF-8
export LC_TIME=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

# python startup
export PYTHONSTARTUP="$HOME/.pythonrc.py"

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
export BROWSER=$(find_alt firefox luakit google-chrome chromium chromium-browser $OPENER )
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

# override the safe location for pick
# export PICK_SAFE="$HOME/Dropbox/conf/pick.safe"

# tmux auto start
export TMUX_AUTO_START=false

# enhancd by "cd"
export ENHANCD_COMMAND='cd'

# dot
export DOT_COMMAND='d'

# takenote
export TAKENOTE_ROOTDIR="$HOME/Workspace/blog"
export TAKENOTE_FILERCMD=ranger

# shtest
export SHTEST_FILENAME_PRE="test_"
export SHTEST_FILENAME_EXTENSION="sh"

# cheat
# -----
# cheat allows you to create and view interactive cheatsheets on the
# command-line. It was designed to help remind *nix system administrators of
# options for commands that they use frequently, but not frequently enough to
# remember.
# [chrisallenlane/cheat](https://github.com/chrisallenlane/cheat)
# sudo pip install cheat
export CHEATCOLORS=true

# TensorFlow
# Ubuntu/Linux 64-bit, CPU only, Python 2.7
# export TF_BINARY_URL=https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-0.9.0-cp27-none-linux_x86_64.whl

export PC=
