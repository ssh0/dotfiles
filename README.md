dotfiles
========

This repository contains my dotfiles.

I use [dot](https://github.com/ssh0/dot) in order to set symbolic link to add new file to this repository and to deal with machine specific configurations.

Contents
--------

* XMonad([http://xmonad.org/](http://xmonad.org/))
    * [xmonad.hs](./xmonad/xmonad.hs)
* tmux([https://tmux.github.io/](https://tmux.github.io/))
    * [tmux.conf](./rcfiles/tmux.conf)
* zsh([http://www.zsh.org/](http://www.zsh.org/))
    * zgen([tarjoilija/zgen](https://github.com/tarjoilija/zgen))
    * [zshfiles](./zshfiles/)
* vim([http://www.vim.org/](http://www.vim.org/))
    * [vimrc](./vimfiles/vimrc)
* ranger([http://ranger.nongnu.org/](http://ranger.nongnu.org/))
    * [config files](./ranger/)
* luakit([https://mason-larobina.github.io/luakit/](https://mason-larobina.github.io/luakit/))
    * [config files](./luakit/)
* [some useful scripts](./bin/)

Screenshot
-----------

![screenshot.png](./screenshots/screenshot.png)

Install
-------

### Using dot

Clone this repository in your computer(default: `~/.dotfiles`),

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

Then, clone this repository to your specified directory (default: `~/.dotfiles`).

```
dot clone [/path/you/want/to/clone]
```

In order to make symbolic links:

```
dot set
```

In case that there are exisiting files, the script asks you what to do.

If you don't want to add some files, you can comment out the line in `~/.dotfiles/dotlink` with "#".

In order to update newer setting,

```
dot pull
```

### Simple installation without dot

Clone or folk this repository:

```
git clone https://github.com/ssh0/dotfiles.git ~/.ssh0-dotfiles
```

Then you can modify or copy the file you want.
