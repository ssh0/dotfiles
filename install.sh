#!/bin/bash
# written by Shotaro Fujimoto (https://github.com/ssh0)
#=#=#=
# install.sh - Clone this repository to your computer and deploy with 'dot' command
#=#=

DOT_DIR="$(builtin cd "$(dirname "${BASH_SOURCE:-${(%):-%N}}")" && pwd)"
DOT_REPO="https://github.com/ssh0/dotfiles.git"
DOT_SCR="$HOME/.dot"

echo "-------------------------"
echo " Install ssh0's dotfiles "
echo "-------------------------"
echo
echo "First, Clone 'dot' command from GitHub."
echo "    $ git clone https://github.com/ssh0/dot.git ${DOT_SCR}"
echo
git clone https://github.com/ssh0/dot.git "${DOT_SCR}"

# Source dot command
if [ -f "${DOT_SCR}/dot.sh" ] && . "${DOT_SCR}/dot.sh"; then
  echo "Succefully installed 'dot'."
  echo
else
  echo "'dot' command cannot be installed."
  echo "Try manuall installation."
  echo "See https://github.com/ssh0/dotfiles#manually"
  echo
  exit 1
fi

# Create temporary configuration file to set some variables.
temp_config="$(mktemp)"
cat << EOF > "${temp_config}"
clone_repository='${DOT_REPO}'
dotdir='${DOT_DIR}'
EOF

# Ask full install or not
read -p "You want to install **all** the symlinks? [y/N]" confirm
echo
if [ "$confirm" != "y" ]; then
  echo "Edit 'dotlink' file to toggle which files to be made symlinks."
  echo "Comment out the lines you don't want to make symlinks."
  echo "(The script asks you when the files already exists. Don't worry about it.)"
  echo
  echo -n "Press any key to edit 'dotlink' ..."; read
  dot_main -c "${temp_config}" edit
  echo
fi

echo "Now, set the symbolic links."
echo -n "Press any key to continue ..."; read
echo

dot_main -c "${temp_config}" set -v

