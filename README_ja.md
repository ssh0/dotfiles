[English](./README.md)

dotfiles
========

このリポジトリには，設定ファイル群であるdotfilesが含まれています。

シンボリックリンクを張ったり，新しいファイルをリポジトリ内に取り込んだり，マシンごとの設定を管理するために，シェルスクリプト製のdotfileマネージャ[dot](https://github.com/ssh0/dot)を使っています。

内容
====

* [herbstluftwm](https://www.herbstluftwm.org/)
    * [autostart](./herbstluftwm/autostart)
    * その他スクリプト
* [tmux](https://tmux.github.io/)
    * [tmux.conf](./tmux/tmux.conf)
* [zsh](http://www.zsh.org/)
    * [zplug](https://github.com/zplug/zplug)
    * [zshfiles](./zshfiles/)
* [neovim](https://neovim.io/)
    * [init.vim](./neovim/init.vim)
* [ranger](http://ranger.nongnu.org/)
    * [config files](./ranger/)
* [xmonad](http://xmonad.org/)
    * [xmonad.hs](./xmonad/xmonad.hs)
* [便利なシェルスクリプト群](./bin/)

スクリーンショット
==================

![screenshot.png](./screenshots/screenshot.png)

インストール方法
================

* [`dot`を用いる方法](#install_with_dot)
    * [install.shを用いる方法](#install_sh)
    * [手動でインストール](#manually)
        1. [`dot`のインストール](#install_dot)
        2. [`dot`を用いてリポジトリをクローン、シンボリックリンクを作成](#clone_and_deploy_using_dot)
* [`dot`を用いない方法](#install_without_dot)

## <a name="install_with_dot">`dot`を用いる方法</a>

>[ssh0/dot: dotfiles management framework with shell](https://github.com/ssh0/dot)

### <a name="install_sh">install.shを用いる方法</a>

```
git clone https://github.com/ssh0/dotfiles.git ~/.ssh0-dotfiles
```

などとしてこのリポジトリをクローンした後に，

```
cd ~/.ssh0-dotifles
./install.sh
```

と実行してください。

[install.sh](./install.sh)は一時的に`dot`コマンドを使用できるようにし，`[dotlink](./dotlink)`に書かれたファイルの対応関係に基づいてシンボリックリンクを張ります。

### <a name="manually">手動でインストール</a>

#### <a name="install_dot">1. `dot``のインストール</a>

* リポジトリのクローン

```
git clone https://github.com/ssh0/dot $HOME/.zsh/dot
```

* 自分の{bash|zsh}rcファイルに以下を追記

```
export DOT_REPO="https://github.com/your_username/dotfiles.git"
export DOT_DIR="$HOME/.dotfiles"
fpath=($HOME/.zsh/dot $fpath)  # <- for completion
source $HOME/.zsh/dot/dot.sh
```

詳しくは`dot`の[README](https://github.com/ssh0/dot/blob/master/README_ja.md)を参照してください。

#### <a name="clone_and_deploy_using_dot">2. dotを用いてリポジトリをクローン、シンボリックリンクを作成</a>

* dotコマンド用の設定ファイルを準備する

```
mkdir -p $HOME/.config/dot
cat > $HOME/.config/dot/dotrc-ssh0 << EOF
clone_repository="https://github.com/ssh0/dotfiles.git"
dotdir="$HOME/.dotfiles-ssh0"
dotlink="$HOME/.dotfiles-ssh0/dotlink"
linkfiles=("$HOME/.dotfiles-ssh0/dotlink")
EOF
```

* 自分の{bash|zsh}rcファイルに以下を追記(その後shellrcファイルを再読み込み)

```
alias dot-ssh0="dot_main -c $HOME/.config/dot/dotrc-ssh0"
```

* 以下のコマンドを実行

```
dot-ssh0 clone && dot-ssh0 set
```

これにより、このリポジトリ内のファイルがローカルにクローンされ、シンボリックリンクが生成されていきます。もし既にファイルが存在している場合には、操作を選択できるので、そこで操作を指定してください。

もしくは、`dot set -i`とオプションをつければ、重複するファイルなどはすべて無視されます。

このリポジトリは進行中のプロジェクトであるため、いくつかのファイルは将来変更、追加される可能性があります。
これらのファイルを最新に保つには、

```
dot-ssh0 update
```

としてください。

## <a name="install_without_dot">dotを用いない方法</a>

このリポジトリをクローンするかフォークしてください:

```
git clone --recursive  https://github.com/ssh0/dotfiles.git ~/.dotfiles-ssh0
```

お好みの設定ファイルをコピーしたり，シンボリックリンクを張ったりして，設定を反映させてください。

ローカル設定
============

別のPC用

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


ライセンス
==========

このリポジトリ内の(サブモジュール化されたものを除く)すべてのファイルは[WTFPL](http://www.wtfpl.net/)ライセンスの下で公開されます。

全文は[ここ](./LICENSE)に記載してあります。

