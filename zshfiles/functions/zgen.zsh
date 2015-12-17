# zgen load settings

export ZGEN_AUTOLOAD_COMPINIT=false

zgen_repo_url="https://github.com/tarjoilija/zgen.git"
zgen_raw_url="https://raw.githubusercontent.com/tarjoilija/zgen.git"

# where to clone antigen
zgen_root="$HOME/.zsh/plugins/zgen"

# if Antigen is not installed, automatically clone it and reload shell
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
    zsh-users/zsh-syntax-highlighting
    robbyrussell/oh-my-zsh lib/git.zsh
    robbyrussell/oh-my-zsh lib/spectrum.zsh
    robbyrussell/oh-my-zsh lib/termsupport.zsh
    robbyrussell/oh-my-zsh lib/theme-and-appearance.zsh
    fcambus/ansiweather
    b4b4r07/enhancd zsh
    Tarrasch/zsh-bd
    chrissicool/zsh-256color
    ssh0/zsh-get_serialised_filename
    ssh0/zsh-takenote
    ssh0/dot
EOPLG

  # save all to init script
  zgen save
fi

