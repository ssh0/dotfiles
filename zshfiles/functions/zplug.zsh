# zplug load settings

source "$HOME/.zplug/zplug"

zplug "lib/git", from:oh-my-zsh
zplug "lib/grep", from:oh-my-zsh
zplug "lib/history", from:oh-my-zsh
zplug "lib/spectrum", from:oh-my-zsh
zplug "lib/termsupport", from:oh-my-zsh
zplug "lib/theme-and-appearance", from:oh-my-zsh

zplug "zsh-users/zsh-syntax-highlighting"
zplug "fcambus/ansiweather", as:command
zplug "b4b4r07/enhancd"
zplug "b4b4r07/zplug"
zplug "Tarrasch/zsh-bd"
zplug "chrissicool/zsh-256color"
zplug "ssh0/zsh-takenote"
zplug "ssh0/dot"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
# zplug load --verbose
zplug load
