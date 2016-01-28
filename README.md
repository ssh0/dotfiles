[日本語](./README_ja.md)

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

![screenshot\_fullscreen\_mode.png](./screenshots/screenshot_fullscreen_mode.png)

Install
-------

### Install with [dot](https://github.com/ssh0/dot)

#### 1. Install `dot`

##### 1.a Install with zsh plugin manager

If you use zsh plugin manager already, add below line to your `zshrc`.

* [zplug](https://github.com/b4b4r07/zplug)

```
zplug "ssh0/dot"
```

* [zgen](https://github.com/tarjoilija/zgen)

```
zgen load ssh0/dot
```

* [antigen](https://github.com/zsh-users/antigen)

```
antigen bundle ssh0/dot
```

Then if you have your dotfiles already, write the below line to your `zshrc`.
`dot` looks the variables to manage it.

```
export DOT_REPO="https://github.com/username/dotfiles.git"
export DOT_DIR="$HOME/.dotfiles"
```

If you want to know more installation guide, see `dot`'s [README](https://github.com/ssh0/dot).

##### 1.b Install manually

Clone the `dot`'s repository:

```
git clone https://github.com/ssh0/dot.git ~/.zsh/plugins/dot
```

And write like the below into `bashrc` or `zshrc` in order to enable to use `dot` command.

```
source $HOME/.zsh/plugins/dot
```

In order to take effect, close the terminal and restart.

#### 2. Clone and deploy using dot

Running the below command

```
DOT_REPO="https://github.com/ssh0/dotfiles.git"; DOT_DIR="$HOME/.dotfiles-ssh0"
dot clone && dot set -v
```

clone this repository to your computer and make the symbolic links.
If files or links have already existed, this command will ask you to choose the operation for it, so don't worry about it.

Or if you know what kind of files are no need to make links, you can comment out the line in `~/.dotfiles-ssh0/dotlink` and these will be ignored by `dot` command.

### Install without dot(simple)

Clone (or folk) this repository to your computer:

```
git clone --depth 1 https://github.com/ssh0/dotfiles.git ~/.dotfiles-ssh0
```

then, you can copy or make a symbolic from the directory to the right place(
which is described in `dotlink`).

License
-------

All the files in this repository (except submodule) is under [WTFPL - Do What the Fuck You Want to Public License](http://www.wtfpl.net/).

See full text at [LICENSE](./LICENSE).

