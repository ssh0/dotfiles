#=#=#=
# Bind keys
#
# **Ex)**
#
# * ^xe for edit in command line (useful)
# * ^t for fzf-completion
# * ^r for history search with fzf
#=#=

bindkey -e

# edit command line in vim:
# by pressing: ^xe or ^i
# Edit the current command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line

# reverse-menu-complete by `Shift+Tab`
bindkey '^[[Z' reverse-menu-complete

# by C-p, C-n
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

if hash fzf 2>/dev/null; then
  bindkey '^T' fzf-completion
fi

bindkey '^r' peco-select-history
