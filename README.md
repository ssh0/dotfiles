[日本語](./README_ja.md)

dotfiles
========

This repository contains my dotfiles.

I use dotfiles manager [dot](https://github.com/ssh0/dot) in order to:

* Set symbolic links
* Add new file to this repository
* Switch machine specific configurations

Contents
========

* [xmonad](http://xmonad.org/)
    * [xmonad.hs](./xmonad/xmonad.hs)
* [tmux](https://tmux.github.io/)
    * [tmux.conf](./tmux/tmux.conf)
* [zsh](http://www.zsh.org/)
    * [zplug](https://github.com/zplug/zplug)
    * [zshfiles](./zshfiles/)
* [neovim](https://neovim.io/)
    * [init.vim](./neovim/init.vim)
* [ranger](http://ranger.nongnu.org/)
    * [config files](./ranger/)
* [Some useful scripts](./bin/)

Screenshot
==========

![screenshot.png](./screenshots/screenshot.png)

How to Install
==============

* [Install by `dot`](#install_with_dot)
    * [Execute install.sh](#install_sh)
    * [Install manually](#manually)
        1. [Install `dot`](#install_dot)
        2. [Clone repository and make symbolic links](#clone_and_deploy_using_dot)
* [Install without `dot`](#install_without_dot)


## <a name="install_with_dot">Install by `dot`</a>

>[ssh0/dot: dotfiles management framework with shell](https://github.com/ssh0/dot)

### <a name="install_sh">Execute install.sh</a>

Clone this repository by

```
git clone https://github.com/ssh0/dotfiles.git ~/.ssh0-dotfiles
```

Then, execute:

```
cd ~/.ssh0-dotifles
./install.sh
```

[install.sh](./install.sh) will install `dot` and make the symolic links written in `dotlink`.

### <a name="manually">Install manually</a>

#### <a name="install_dot"> 1. Install `dot`</a>

* Clone the repository

```
git clone https://github.com/ssh0/dot $HOME/.zsh/dot
```

* Write in your {bash|zsh}rc like below:

```
export DOT_REPO="https://github.com/your_username/dotfiles.git"
export DOT_DIR="$HOME/.dotfiles"
fpath=($HOME/.zsh/dot $fpath)  # <- for completion
source $HOME/.zsh/dot/dot.sh
```

See details at [dot's README](https://github.com/ssh0/dot).

#### <a name="clone_and_deploy_using_dot"> 2. Clone repository and make symbolic links</a>

* Create the dot's config file for this repository(of cource you can make that for your own dotfiles)

```
mkdir -p $HOME/.config/dot
cat > $HOME/.config/dot/dotrc-ssh0 << EOF
clone_repository="https://github.com/ssh0/dotfiles.git"
dotdir="$HOME/.dotfiles-ssh0"
dotlink="$HOME/.dotfiles-ssh0/dotlink"
linkfiles=("$HOME/.dotfiles-ssh0/dotlink")
EOF
```

* Write like below in your {bash|zsh}rc and reload shellrc:

```
alias dot-ssh0="dot_main -c $HOME/.config/dot/dotrc-ssh0"
```

* Execute the `dot` command:

```
dot-ssh0 clone -f && dot-ssh0 set
```

Then, this repository is cloned on your computer and the symbolic links will be created.

If files or links have already existed, this command will ask you to choose the operation.
So, don't worry about breaking your existing system.
You can skip these conflict files by using `dot-ssh0 set -i`.

This repository is **work-in-progress** and some files will be changed in the future.
If you want to follow up-to-date settings:

```
dot-ssh0 update
```

## <a name="install_without_dot">Install without `dot`</a>

Clone (or folk) this repository on your computer:

```
git clone --recursive https://github.com/ssh0/dotfiles.git ~/.dotfiles-ssh0
```

then, you can copy or make a symbolic from the directory to the right place(described in `dotlink`).

Local settings
==============

For my other machines ...

## ThinkPad T540p

`~/.zsh/rc.mine`

```sh
export PC=T540p/
```

## Lenovo IdeaPad S10e

`~/.zsh/rc.mine`

```sh
export PC=S10e/
```


License
=======

All the files in this repository (except submodule) is under [WTFPL - Do What the Fuck You Want to Public License](http://www.wtfpl.net/).

See full text at [LICENSE](./LICENSE).

