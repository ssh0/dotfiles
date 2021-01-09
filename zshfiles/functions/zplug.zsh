#=#=#=
# zplug load settings
#
# **Features:**
#
# * Install zplug if not installed
#
# **Plugins**
#
# * fcambus/ansiweather
# * b4b4r07/enhancd
# * Tarrasch/zsh-bd
# * chrissicool/zsh-256color
# * ssh0/zsh-takenote
# * ssh0/dot
# * zsh-users/zsh-syntax-highlighting
#=#=

zplug_source="$HOME/.zplug/init.zsh"

# if zplug is not installed, automatically clone it and reload shell
if [[ ! -f "${zplug_source}" ]]; then
  echo "zplug is not installed in this machine."
  echo "Installing zplug..."
  echo ""
  # curl -sL zplug.sh/installer | zsh
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
  # source "$HOME/.zplug/init.zsh"
  zplug update --self
fi

source ${zplug_source}
unset -v zplug_source

zplug "fcambus/ansiweather", as:command
zplug "b4b4r07/enhancd", use:init.sh
zplug "Tarrasch/zsh-bd"
zplug "chrissicool/zsh-256color"
zplug "ssh0/zsh-takenote"
zplug "ssh0/dot", use:dot.sh
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zplug/zplug", hook-build:'zplug --self-manage'

# Install plugins if there are plugins that have not been installed
# if ! zplug check; then
#   zplug install
# fi

# Then, source plugins and add commands to $PATH
# zplug load --verbose
zplug load
