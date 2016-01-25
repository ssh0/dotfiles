# tmux
# Aliases

alias ta='tmux attach -t'
alias ts='tmux new-session -s'
alias tl='tmux list-sessions'
alias tksv='tmux kill-server'
alias tkss='tmux kill-session -t'

# Only run if tmux is actually installed
if hash tmux; then
  # Wrapper function for tmux.
  function _zsh_tmux_plugin_run() {
    # We have other arguments, just run them
    if [[ -n "$@" ]]; then
      \tmux $@
      # Just run tmux, fixing the TERM variable if requested.
    else
      \tmux && exit 0
    fi
  }

  # Use the completions for tmux for our function
  compdef _tmux _zsh_tmux_plugin_run

  # Alias tmux to our wrapper function.
  alias tmux=_zsh_tmux_plugin_run

  # Autostart if not already in tmux.
  [[ ! -n "$TMUX" ]] && _zsh_tmux_plugin_run
fi

