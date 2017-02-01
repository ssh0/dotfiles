#=#=#=
# set tmux aliases and start up behavior
#
# > [Start a new session from within tmux with ZSH_TMUX_AUTOSTART=true - Super User](http://superuser.com/questions/821339/start-a-new-session-from-within-tmux-with-zsh-tmux-autostart-true)
#
# Auto start tmux when the terminal launched.
#=#=

tmux-new-session() {
  if [[ -n $TMUX ]]; then
    tmux switch-client -t "$(TMUX= tmux -S "${TMUX%,*,*}" new-session -dP -s "$@")"
  else
    tmux new-session -s "$@"
  fi
}

# Aliases
if [[ -n $TMUX ]]; then
  alias ta='tmux switch-client -t'
else
  alias ta='tmux attach-session -t'
fi
alias ts='tmux-new-session'
alias tl='tmux list-sessions'
alias tksv='tmux kill-server'
alias tkss='tmux kill-session -t'

# Autostart if not already in tmux.
if [[ ! -n $TMUX && $- == *l* ]]; then
  # get the IDs
  if ! ID="$(tmux list-sessions 2>/dev/null)"; then
    # tmux returned error, so try cleaning up /tmp
    /bin/rm -rf /tmp/tmux*
  fi
  create_new_session="Create New Session"
  if [[ -n "$ID" ]]; then
    ID="${create_new_session}:\n$ID"
  else
    ID="${create_new_session}:"
  fi
  ID="$(echo $ID | $PERCOL | cut -d: -f1)"
  if [[ "$ID" = "${create_new_session}" ]]; then
    tmux new-session
  elif [[ -n "$ID" ]]; then
    tmux attach-session -t "$ID"
  else
    :  # Start terminal normally
  fi
fi

