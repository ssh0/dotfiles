#!/bin/bash
# written by Shotaro Fujimoto (https://github.com/ssh0)
#=#=#=
# install.sh - Clone this repository to your computer and deploy with 'dot' command
#=#=

DOT_DIR="$(builtin cd "$(dirname "${BASH_SOURCE:-${(%):-%N}}")" && pwd)"
DOT_REPO="https://github.com/ssh0/dotfiles.git"
DOT_SCR="$HOME/.dot"

echo "Install ssh0's dotfiles ..."
echo

echo "First, Clone 'dot' command from GitHub."
echo
git clone https://github.com/ssh0/dot.git "${DOT_SCR}"

echo "Make a temporary configuration file for 'dot'."
temp_config="$(mktemp)"

echo
cat << EOF | tee "${temp_config}"
clone_repository='${DOT_REPO}'
dotdir='${DOT_DIR}'
EOF

# Source dot command
. "${DOT_SCR}/dot.sh"

# Ask full install or not
read -p "You want to install all the symlinks? [y/N]" confirm
echo
if [ "$confirm" != "y" ]; then
  echo "You can edit 'dotlink' file to toggle which files to be made symlinks."
  echo "Comment out the lines you don't want to make symlinks."
  echo "(The script asks you when the files already exists. Don't worry about it.)"
  echo
  echo -n "Press any key to edit 'dotlink' ..."; read
  dot_main -c "${temp_config}" edit
  echo
fi

echo "Now, set the symbolic links."
echo -n "Press any key to continue ..."; read
dot_main -c "${temp_config}" set -v

