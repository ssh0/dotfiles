functions
===

## [alias.zsh](./alias.zsh)

Set aliases (if available)

**Ex)**

* apt for apt-fast
* vim for nvim
* g for git
* f for thefuck
* :q for exit
* f for thefuck
* cf-* (edit the configuration file of an application)
* rl-* (reload the configuration file on an application)

## [bindkey.zsh](./bindkey.zsh)

Bind keys

**Ex)**

* ^xe for edit in command line (useful)
* ^t for fzf-completion
* ^r for history search with fzf

## [colorize.zsh](./colorize.zsh)

Colorize some applications outputs

* mplayer
* twitter command
* diff aliased to colordiff
* tree -C
* grep

## [command-not-found.zsh](./command-not-found.zsh)

command-not-found (available on Ubuntu)

(currently not using)

## [completion.zsh](./completion.zsh)

Set completion options

**Features**

* show completion menu
* verobose output (with description)
* ls colors with LS_COLORS

## [confirm.zsh](./confirm.zsh)

Function for asking user yes or no

**Features**

* can set default answer (default one is shown in caitals)
* can set messages
* loop if the answer is invalid
* ignorecase

```
Name
      confirm - confirm user yes or no

Usage
      confirm [ y | n ] [<message>]

Examples
      Use this function to ask user yes or no.

      * Set default answer by setting first argument 'y':

          $ confirm y "Choose y or n " && echo "Yes" || echo "No"
          Choose y or n (Y/n)
          Yes

          $ confirm y "Choose y or n " && echo "Yes" || echo "No"
          Choose y or n (Y/n) n
          No

      * If the first argument is not 'y' or 'n':

          $ confirm "Choose y or n " && echo "Yes" || echo "No"
          Choose y or n (y/n)
          Please answer with 'y' or 'n'.
          Choose y or n (y/n) y
          Yes

      * You can answer with upper characters:

          $ confirm "Choose y or n " && echo "Yes" || echo "No"
          Choose y or n (y/n) YeS
          Yes

```

## [environment.zsh](./environment.zsh)

Set environment variables

**Features**

* language
* default application (find_alt is useful function)
* some applications options (ranger, enhancd, takenote, cheat)

## [extract.zsh](./extract.zsh)

extract - extract archive files by detecting extension

**Supported format**  
* tar.gz, tgz, tar.xz, xz, zip, lzh, tar.bz2, tbz, tar.Z, gz, bz2, Z, tar, arj

## [git.zsh](./git.zsh)

get git status information for creating prompts

**Features**

* outputs current branch info
* checks if working tree is dirty
* gets the difference between the local and remote branches
* outputs the name of the current branch
* gets the number of commits ahead from remote
* outputs if current branch is ahead of remote
* outputs if current branch is behind remote
* outputs if current branch exists on remote or not
* formats prompt string for current git commit short SHA
* formats prompt string for current git commit long SHA
* get the status of the working tree

## [history.zsh](./history.zsh)

Set options for history

**Features**

* increase history size
* ignore duplicate line
* share history with each terminals

## [less.zsh](./less.zsh)

Set options for less

**Features**

* with color
* different color for bold, underline, standout font
* verbose status line message (show file name)

## [longrun-command-tracker.zsh](./longrun-command-tracker.zsh)

Notification of local host command

Automatic notification via growlnotify / notify-send  

> http://qiita.com/hayamiz/items/d64730b61b7918fbb970

"==ZSH LONGRUN COMMAND TRACKER==" is printed after long run command execution  
You can utilize it as a trigger.

## [ls.zsh](./ls.zsh)

Set `ls` options

|Options                     |Description                                 |
|---                         |---                                         |
|`--human-readable`,`-h`     |append a size letter to each size           |
|`--classify`,`-F`           |append a character indicating the file type |
|`--sort=version`,`-v`       |sort by version name and number             |
|`--time-style=long-iso`     |time stamp format "%Y-%m-%d %H:%M"          |
|`--group-directories-first` |group all the directory before the files    |
|`--color`                   |always use color                            |


To see full documentaion for `ls`:

    info coreutils 'ls invocation'

## [man.zsh](./man.zsh)

man (available for buitlin commands)

**Features:**

* for zsh builtin commands
* for reserved word
* for alias
* for zsh function
* for (natural) command
* if the same name exists, choose one by fzf
* with color

>* [Can I get individual man pages for the bash builtin commands? - Unix & Linux Stack Exchange](http://unix.stackexchange.com/questions/18087/can-i-get-individual-man-pages-for-the-bash-builtin-commands)
>* [manpage - How to make `man` work for shell builtin commands and keywords? - Ask Ubuntu](http://askubuntu.com/questions/439410/how-to-make-man-work-for-shell-builtin-commands-and-keywords)

But I want to know about zsh builtins, so I wrote this.

Install zsh manuals to enable `man zshbuiltins`:

```
$ mkdir -p ~/Downloads/zsh-doc; cd $_
$ wget http://downloads.sourceforge.net/project/zsh/zsh/5.0.2/zsh-5.0.2.tar.bz2
$ tar -xvf zsh-5.0.2.tar.bz2
$ sudo cp zsh-5.0.2/Doc/*.1 /usr/local/share/man/man1
```

**Require:**

* fzf
* "pygmentize" or "highlight" for highlighting scripts
* LESS="R" option for ansi color in "less" command

## [peco-history.zsh](./peco-history.zsh)

peco-select-history - for history search with ^r key

But I don't use peco now. I use fzf instead.

## [prompt.zsh](./prompt.zsh)

simle_is_power theme  
folked from agnoster's Theme - https://gist.github.com/3712874

In order for this theme to render correctly, you will need a
[Powerline-patched font](https://github.com/Lokaltog/powerline-fonts).

## [ranger.zsh](./ranger.zsh)


Compatible with ranger 1.4.2 through 1.7.*

## Features

**Automatically change the directory in bash after closing ranger**

This is a bash function for .bashrc to automatically change the directory to
the last visited one after ranger quits.
To undo the effect of this function, you can type "cd -" to return to the
original directory.

**Start new ranger instance only if it's not running in current shell**

> [ranger - ArchWiki](https://wiki.archlinux.org/index.php/Ranger#Start_new_ranger_instance_only_if_it.27s_not_running_in_current_shell)

## [shtest.zsh](./shtest.zsh)

shtest - Make testing snippet of shell script

**Usage:**

```
shtest [OPTION]
```

| Option | Arguments | Description              |
| ------ | --------- | ------------------------ |
| `-o`   | FILE      | Set the filename to edit |
| `-l`   |           | List the files           |
| `-h`   |           | Show help message        |

Require: [zsh-takenote](https://github.com/ssh0/zsh-takenote)

## [termsupport.zsh](./termsupport.zsh)

Set terminal window and tab/icon title

usage: title short_tab_title [long_window_title]

See: http://www.faqs.org/docs/Linux-mini/Xterm-Title.html#ss3.1
Fully supports screen, iterm, and probably most modern xterm and rxvt
(In screen, only short_tab_title is used)

## [tmux.zsh](./tmux.zsh)

set tmux aliases and start up behavior

> [Start a new session from within tmux with ZSH_TMUX_AUTOSTART=true - Super User](http://superuser.com/questions/821339/start-a-new-session-from-within-tmux-with-zsh-tmux-autostart-true)

Auto start tmux when the terminal launched.

## [zgen.zsh](./zgen.zsh)

zgen load settings

* b4b4r07/enhancd zsh
* chrissicool/zsh-256color
* ssh0/dot
* ssh0/zsh-takenote
* fcambus/ansiweather
* Tarrasch/zsh-bd
* zsh-users/zsh-syntax-highlighting

## [zplug.zsh](./zplug.zsh)

zplug load settings (not in use now)

* fcambus/ansiweather
* b4b4r07/enhancd
* b4b4r07/zplug
* Tarrasch/zsh-bd
* chrissicool/zsh-256color
* ssh0/zsh-takenote
* ssh0/dot
* zsh-users/zsh-syntax-highlighting

---

This page is generated automatically by [makebinreadme.sh](https://github.com/ssh0/dotfiles/blob/master/bin/makebinreadme.sh)

