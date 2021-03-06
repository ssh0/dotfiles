# vim: ft=zsh
#=#=#=
# shtest - Make testing snippet of shell script
#
# **Usage:**
#
# ```
# shtest [OPTION]
# ```
#
# | Option | Arguments | Description              |
# | ------ | --------- | ------------------------ |
# | `-o`   | FILE      | Set the filename to edit |
# | `-l`   |           | List the files           |
# | `-h`   |           | Show help message        |
#
# Require: [zsh-takenote](https://github.com/ssh0/zsh-takenote)
#=#=

shtest() {

  show_usage() {
    echo ""
    echo "shtest - Make testing snippet for shell script."
    echo ""
    echo "Usage: shtest [OPTION]"
    echo ""
    echo "Option:"
    echo "  -o FILE: Set the file name to save. "
    echo "  -l     : List the files."
    echo "  -h     : Show this message."
    unset -f $0
  }

  if [ "$1" = "-h" ]; then
    show_usage
    return 1
  fi

  local _TAKENOTE_FILENAME_PRE="${TAKENOTE_FILENAME_PRE}"
  local _TAKENOTE_FILENAME_EXTENSION="${TAKENOTE_FILENAME_EXTENSION}"

  TAKENOTE_FILENAME_PRE="${SHTEST_FILENAME_PRE}"
  TAKENOTE_FILENAME_EXTENSION="${SHTEST_FILENAME_EXTENSION}"

  takenote -d "$HOME/bin" $@

  export TAKENOTE_FILENAME_PRE="${_TAKENOTE_FILENAME_PRE}"
  export TAKENOTE_FILENAME_EXTENSION="${_TAKENOTE_FILENAME_EXTENSION}"
  unset _TAKENOTE_FILENAME_PRE _TAKENOTE_FILENAME_EXTENSION

  return 0
}

