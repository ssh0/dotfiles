dotfiles
========

This repository contains my dotfiles.
In order to set symbolic link, add new file to the directory, and manage machine specific configurations, I use [dot](https://github.com/ssh0/dot) which is bash script and is simple and configurable.

Contents
--------

* XMonad([http://xmonad.org/](http://xmonad.org/))
    * [my xmond.hs](./xmonad/xmonad.hs)
* tmux([https://tmux.github.io/](https://tmux.github.io/))
    * [my tmux.conf](./rcfiles/tmux.conf)
* zsh([http://www.zsh.org/](http://www.zsh.org/))
    * oh-my-zsh([https://github.com/robbyrussell/oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh))
    * [my zshfiles](./zshfiles/)
* vim([http://www.vim.org/](http://www.vim.org/))
    * [my vimrc](./vimfiles/vimrc)
* ranger([http://ranger.nongnu.org/](http://ranger.nongnu.org/))
    * [my ranger config files](./ranger/)
* luakit([https://mason-larobina.github.io/luakit/](https://mason-larobina.github.io/luakit/))
    * [my luakit config files](./luakit/)
* [some useful scripts](./bin/)

Screenshots
-----------

![xmonad.png](./screenshots/xmonad.png)

![tmux.browsing](./screenshots/browsing.png)

![vim.png](./screenshots/vim.png)

Install
-------

Clone this repository in your computer(default: ~/.dotfiles),

```bash
bash <(curl -L https://raw.githubusercontent.com/ssh0/dot/master/dot) clone
```

And make symbolic links by following command,

```bash
dot set
```

and this script replace existing files interactively.

If you want not to make some links, open `~/.dotfiles/dotlink` and comment out these lines.
The lines commented out are ignored by this script.

Usage of '[dot](https://github.com/ssh0/dot)' command
----------------------

Configuration file is in '[dotrc](./dotrc)'.
Link relation table is in '[dotlink](./dotlink)'.

* Clone the dotfile repository on your computer.  
```bash
dot clone [<dir_to_clone>]
```

* Pull remote dotfile repository (by git).  
```bash
dot pull
```

* Make symbolic link interactively.  
  This command sets symbolic links configured in 'dotlink'.(If you have your file already, you can choose the operation interactively: show diff, edit these files, overwrite, make-backup or do-nothing).  With option "-i", this script runs without interaction mode and with "-v", this script shows verbose message.
```bash
dot set [-i][-v]
```

* Move the new file to the dotfile dir, make the link, and edit 'dotlink'.  
```bash
dot add some_file [~/.dotfiles/path/to/the/file]
```

* Unlink the selected symbolic links and copy its original files from the dotfile directory.  
```bash
dot unlink <link> [<link> <link> ... ]
```

* Remove the *all* symbolic link written in the config file 'configfile'.
```bash
dot clear
```
