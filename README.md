dotfiles
========

This repository contains my dotfiles and some tools in order to make it easy to make a symbolic link to the right place and to add a new file into this repository.

Contents
--------

* [XMonad: http://xmonad.org/](http://xmonad.org/)
    * [my xmond.hs](./xmonad/xmonad.hs)
* [tmux: https://tmux.github.io/](https://tmux.github.io/)
    * [my tmux.conf](./rcfiles/tmux.conf)
* [zsh: http://www.zsh.org/](http://www.zsh.org/)
    * [oh-my-zsh: https://github.com/robbyrussell/oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
    * [my zshfiles](./zshfiles/)
* [vim: http://www.vim.org/](http://www.vim.org/)
    * [my vimrc](./vimfiles/vimrc)
* [ranger: http://ranger.nongnu.org/](http://ranger.nongnu.org/)
    * [my ranger config files](./ranger/)
* [luakit: https://mason-larobina.github.io/luakit/](https://mason-larobina.github.io/luakit/)
    * [my luakit config files](./luakit/)
* [some useful scripts](./bin/)

Screenshots
-----------

![xmonad.png](./screenshots/xmonad.png)

![tmux.browsing](./screenshots/browsing.png)

![vim.png](./screenshots/vim.png)

Install
-------

Clone this repository in your computer:

```bash
git clone https://github.com/ssh0/dotfiles.git ~/.dotfiles
```

And run:

```bash
cd ~/.dotfiles
./dotclean && ./setup.sh
```

and this script replace existing files interactively.

* [dotclean](./dotclean):  
  remove symbolic link which is written in [setup_config_link](./setup_config_link).

* [setup.sh](./setup.sh):  
  set symbolic link which is written in [setup_config_link](./setup_config_link)
  (if you have your file already, you can choose the operation
  interactively: show diff, vimdiff, overwrite, make-backup or do-nothing).

You can add new link by [dotmv](./bin/dotmv):

```bash
dotmv some_file ~/.dotfiles/path/to/file
```

Then, the script automatically move the file `some_file` to
`~/.dotfiles/path/to/file` and make symbolic link to the original
direction. After that, the script launch Vim and you can edit your link
setting (file name is `setup_config_link`) manually.
