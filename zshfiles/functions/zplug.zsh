#=#=#=
# zplug load settings (not in use now)
#
# * fcambus/ansiweather
# * b4b4r07/enhancd
# * b4b4r07/zplug
# * Tarrasch/zsh-bd
# * chrissicool/zsh-256color
# * ssh0/zsh-takenote
# * ssh0/dot
# * zsh-users/zsh-syntax-highlighting
#=#=

zplug_source="$HOME/.zplug/repos/b4b4r07/zplug/zplug"

# if zplug is not installed, automatically clone it and reload shell
if [[ ! -f "${zplug_source}" ]]; then
  echo "zplug is not installed in this machine."
  echo "Installing zplug..."
  echo ""
  curl -fLo "$HOME/.zplug/zplug" --create-dirs https://git.io/zplug
  source "$HOME/.zplug/zplug"
elif [[ -f $HOME/.zplug/zplug ]]; then
  source "$HOME/.zplug/zplug"
  rm "$HOME/.zplug/zplug"
fi

source ${zplug_source}
unset -v zplug_source

zplug "fcambus/ansiweather", as:command
zplug "b4b4r07/enhancd"
zplug "b4b4r07/zplug"
zplug "Tarrasch/zsh-bd"
zplug "chrissicool/zsh-256color"
zplug "ssh0/zsh-takenote"
zplug "ssh0/dot", of:"*.sh"
zplug "zsh-users/zsh-syntax-highlighting", nice:10

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
