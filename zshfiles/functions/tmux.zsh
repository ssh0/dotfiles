# tmux
# Aliases

alias ta='tmux attach -t'
alias ts='tmux new-session -s'
alias tl='tmux list-sessions'
alias tksv='tmux kill-server'
alias tkss='tmux kill-session -t'

# Only run if tmux is actually installed
if hash tmux; then
  # Autostart if not already in tmux.
  if [[ -z "$TMUX" ]]; then
    # get the IDs
    ID="`tmux ls`"
    if [[ -z "$ID" ]]; then
      tmux new-session && exit
    fi
    ID="$ID\nCreate New Session:"
    ID="`echo $ID | $PERCOL | cut -d: -f1`"
    if [[ "$ID" = "Create New Session" ]]; then
      tmux new-session && exit
    fi
    tmux attach-session -d -t "$ID" && exit
  fi
fi

