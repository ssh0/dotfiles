# vim: set ft=zsh

# Start new ranger instance only if it's not running in current shell
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

