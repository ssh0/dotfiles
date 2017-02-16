#=#=#=
# set tmux aliases and start up behavior
#
# > [Start a new session from within tmux with ZSH_TMUX_AUTOSTART=true - Super User](http://superuser.com/questions/821339/start-a-new-session-from-within-tmux-with-zsh-tmux-autostart-true)
#
# Auto start tmux when the terminal launched.
#=#=

tmux-new-session() {
  if [[ -n $TMUX ]]; then
    tmux switch-client -t "$(TMUX= tmux -S "${TMUX%,*,*}" new-session -dP "$@")"
  else
    tmux new-session "$@"
  fi
}

tmux_sessions() {
  # Select existing session or create session with fuzzy search tool
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
    tmux-new-session
  elif [[ -n "$ID" ]]; then
    if [[ -n $TMUX ]]; then
      tmux switch-client -t "$ID"
    else
      tmux attach-session -t "$ID"
    fi
  else
    :  # Start terminal normally
  fi
}

# Aliases
if [[ -n $TMUX ]]; then
  alias ta='tmux switch-client -t'
else
  alias ta='tmux attach-session -t'
fi
alias tl='tmux_sessions'
alias ts='tmux-new-session -s'
alias tksv='tmux kill-server'
alias tkss='tmux kill-session -t'

if ${TMUX_AUTO_START:-false} && [[ ! -n $TMUX && $- == *l* ]]; then
  tmux_sessions
fi
