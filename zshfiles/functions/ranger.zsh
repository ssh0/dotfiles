# vim: set ft=zsh
#=#=#=
#
# Compatible with ranger 1.4.2 through 1.7.*
#
# ## Features
#
# **Automatically change the directory in bash after closing ranger**
#
# This is a bash function for .bashrc to automatically change the directory to
# the last visited one after ranger quits.
# To undo the effect of this function, you can type "cd -" to return to the
# original directory.
#
# **Start new ranger instance only if it's not running in current shell**
#
# > [ranger - ArchWiki](https://wiki.archlinux.org/index.php/Ranger#Start_new_ranger_instance_only_if_it.27s_not_running_in_current_shell)
#=#=

function ranger() {
  if [ -z "$RANGER_LEVEL" ]; then
    local tempfile="$(mktemp -t tmp.XXXXXXX)"
    # for manual install
    /usr/local/bin/ranger \
    --choosedir="$tempfile" "${@:-$(pwd)}"
    # for package install
    # /Library/Frameworks/Python.framework/Versions/3.6/bin/ranger \
    # /usr/bin/ranger --choosedir="$tempfile" "${@:-$(pwd)}"
    test -f "$tempfile" &&
    if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
        cd "$(cat "$tempfile")"
    fi
    rm -f -- "$tempfile"
  else
    exit
  fi
}

