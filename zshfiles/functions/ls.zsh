#=#=#=
# Set `ls` options
#
# |Options                     |Description                                 |
# |---                         |---                                         |
# |`--human-readable`,`-h`     |append a size letter to each size           |
# |`--classify`,`-F`           |append a character indicating the file type |
# |`--sort=version`,`-v`       |sort by version name and number             |
# |`--time-style=long-iso`     |time stamp format "%Y-%m-%d %H:%M"          |
# |`--group-directories-first` |group all the directory before the files    |
# |`--color`                   |always use color                            |
#
#
# To see full documentaion for `ls`:
#
#     info coreutils 'ls invocation'
#
#=#=

LS_OPTIONS="-hFv --time-style=long-iso --group-directories-first"

if command -p ls --color -d . &>/dev/null 2>&1; then
  LS_OPTIONS="${LS_OPTIONS} --color"
fi

alias ls="ls ${LS_OPTIONS}"

