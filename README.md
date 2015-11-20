dotfiles
========

This repository contains my dotfiles.
In order to set symbolic link, add new file to the directory, and manage machine specific configurations, I use [dot](https://github.com/ssh0/dot) which is bash script and is simple and configurable.

Contents
--------

* XMonad([http://xmonad.org/](http://xmonad.org/))
    * [my xmonad.hs](./xmonad/xmonad.hs)
* tmux([https://tmux.github.io/](https://tmux.github.io/))
    * [my tmux.conf](./rcfiles/tmux.conf)
* zsh([http://www.zsh.org/](http://www.zsh.org/))
    * antigen([https://github.com/zsh-users/antigen](https://github.com/zsh-users/antigen))
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

### Using dot

Clone this repository in your computer(default: ~/.dotfiles),

First, install dot.

Clone dot's project repository into your computer:

```
git clone https://github.com/ssh0/dot.git ~/.git/dot
```

Next, run this command for install:

```
cd ~/.git/dot
sudo make install
```

Maks sure if you successfully installed dot by

```
dot --help
```

Clone this repository to your specified directory (default: `~/.dotfiles`).

```
dot clone [/path/you/want/to/clone]
```

In order to make symbolilinks:

```
dot set
```

In case that there are exisiting files, the script asks you what to do.

If you don't want to add some files, you can comment out the line correspond to them in `~/.dotfiles/dotlink` with "#".

### Simple installation without dot

Clone or folk this repository:

```
git clone https://github.com/ssh0/dotfiles.git ~/.ssh0-dotfiles
```

Then you can modify or copy the file you want.
