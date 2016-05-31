#=#=#=
# zgen load settings
#
# * b4b4r07/enhancd zsh
# * chrissicool/zsh-256color
# * ssh0/dot
# * ssh0/zsh-takenote
# * fcambus/ansiweather
# * Tarrasch/zsh-bd
# * zsh-users/zsh-syntax-highlighting
#=#=

export ZGEN_AUTOLOAD_COMPINIT=false

zgen_repo_url="https://github.com/tarjoilija/zgen.git"
zgen_raw_url="https://raw.githubusercontent.com/tarjoilija/zgen.git"

# where to clone antigen
zgen_root="$HOME/.zgen/tarjoilija/zgen-master"

# if zgen is not installed, automatically clone it and reload shell
if [[ ! -f "${zgen_root}/zgen.zsh" ]]; then
  echo "zgen is not installed in this machine."
  echo "Installing zgen..."
  echo ""
  if hash git 2>/dev/null; then
    install -d "${zgen_root}"
    git clone "${zgen_repo_url}" "${zgen_root}"
  elif hash curl 2>/dev/null; then
    install -d "${zgen_root}"
    curl -L "${zgen_raw_url}" -o "${zgen_root}/zgen.zsh"
  elif hash wget 2>/dev/null; then 
    install -d "${zgen_root}"
    wget "${zgen_raw_url}" -O "${zgen_root}/zgen.zsh"
  else
    echo "git or curl or wget required to install."
    echo "Aborted."
    exit 1
  fi
  exec zsh -l
fi

source "${zgen_root}/zgen.zsh"
unset -v zgen_repo_url zgen_raw_url zgen_root

# check if there's no init script
if ! zgen saved; then
  echo "Creating a zgen save"

  zgen loadall <<EOPLG
    chrissicool/zsh-256color
    ssh0/dot
    ssh0/zsh-takenote
    fcambus/ansiweather
    Tarrasch/zsh-bd
    zsh-users/zsh-syntax-highlighting
EOPLG

  # save all to init script
  zgen save
fi

