# vim: set ft=zsh

# peco-history
#-------------

function peco-select-history() {
    typeset tac
    if hash tac > /dev/null; then
        tac=tac
    else
        tac='tail -r'
    fi
    BUFFER=$(fc -l -n 1 | eval $tac | peco --query "$LBUFFER" --prompt ">")
    CURSOR=$#BUFFER
    zle redisplay
}
zle -N peco-select-history

# Keybinding
bindkey '^r' peco-select-history

