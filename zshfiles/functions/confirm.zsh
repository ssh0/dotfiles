#=#=#=
# Function for asking user yes or no
#
# **Features**
#
# * can set default answer (default one is shown in caitals)
# * can set messages
# * loop if the answer is invalid
# * ignorecase
#
# ```
# Name
#       confirm - confirm user yes or no
#
# Usage
#       confirm [ y | n ] [<message>]
#
# Examples
#       Use this function to ask user yes or no.
#
#       * Set default answer by setting first argument 'y':
#
#           $ confirm y "Choose y or n " && echo "Yes" || echo "No"
#           Choose y or n (Y/n)>
#           Yes
#
#           $ confirm y "Choose y or n " && echo "Yes" || echo "No"
#           Choose y or n (Y/n)> n
#           No
#
#       * If the first argument is not 'y' or 'n':
#
#           $ confirm "Choose y or n " && echo "Yes" || echo "No"
#           Choose y or n (y/n)>
#           Please answer with 'y' or 'n'.
#           Choose y or n (y/n)> y
#           Yes
#
#       * You can answer with upper characters:
#
#           $ confirm "Choose y or n " && echo "Yes" || echo "No"
#           Choose y or n (y/n)> YeS
#           Yes
#
# ```
#=#=
function confirm() {
  # confirm [ y | n ] [<message>]
  local yn mes __confirm ret _b _r
  _b="\e[1m"
  _r="\e[m"
  if [ "$1" = "y" ]; then
    yn="${_b}Y${_r}/${_b}n${_r}"
    mes="$2"
    ret=0
  elif [ "$1" = "n" ]; then
    yn="${_b}y${_r}/${_b}N${_r}"
    mes="$2"
    ret=1
  else
    yn="y/n"
    yn="${_b}y${_r}/${_b}n${_r}"
    mes="$1"
    ret=-1
  fi

  echo -n "$mes ($yn) "
  read __confirm
  __confirm=$(echo ${__confirm} | tr '[:upper:]' '[:lower:]')
  case ${__confirm} in
    y|yes) return 0 ;;
     n|no) return 1 ;;
       "") if [ $ret -eq -1 ]; then
             echo "Please answer with 'y' or 'n'."
             confirm "$@"
           else
             return $ret
           fi
           ;;
        *) echo "Please answer with 'y' or 'n'."
           confirm $@;;
  esac

}
