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
    # get the id of a seattached session
    ID="`tmux ls | grep -vm1 attached | cut -d: -f1`"
    if [[ -z "$ID" ]]; then
      tmux new-session && exit
    else
      tmux attach-session -d -t "$ID" && exit
    fi
  fi
fi

