# vim: set ft=zsh

# agvim
#------------------------------------------------------------------------------
# http://qiita.com/fmy/items/b92254d14049996f6ec3

function agvim() {
  local agfilepath
  agfilepath="$(echo $(ag $@ | peco --query "$LBUFFER" | awk -F : '{print "+" $2 " \047" $1 "\047"}'))"
  if [ -n "$agfilepath" ]; then
    eval $(echo "vim $agfilepath")
  fi
}

