# vim: set ft=zsh

# command-not-found (available on Ubuntu)
#------------------------------------------------------------------------------

if [[ -x /usr/lib/command-not-found ]] ; then
  function command_not_found_handler() {
  /usr/lib/command-not-found --no-failure-msg -- "$1"
}
fi

