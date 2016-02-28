[English](./README.md)

dotfiles
========

このリポジトリには，設定ファイル群であるdotfilesが含まれています。

シンボリックリンクを張ったり，新しいファイルをリポジトリ内に取り込んだり，マシン固有の設定を管理するために，[dot](https://github.com/ssh0/dot)を使っています。

内容
====

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
* [便利なシェルスクリプト群](./bin/)

スクリーンショット
==================

![screenshot.png](./screenshots/screenshot.png)

インストール
============

* [dotを用いた方法](#install_with_dot)
    * [スクリプトを用いた方法](#install_sh)
    * [手動でインストール](#manually)
        1. [dotのインストール](#install_dot)
        2. [dotを用いてリポジトリをクローン、シンボリックリンクを作成](#clone_and_deploy_using_dot)
* [dotを用いない方法](#install_without_dot)

## <a name="install_with_dot">dotを用いた方法</a>

* [dot](https://github.com/ssh0/dot)

### <a name="install_sh">スクリプトを用いた方法</a>

```
git clone https://github.com/ssh0/dotfiles.git ~/.ssh0-dotfiles
```

などとしてこのリポジトリをクローンした後に，

```
cd ~/.ssh0-dotifles
./install.sh
```

と実行してください。

[このスクリプト](./install.sh)は一時的に`dot`コマンドを使用できるようにし，`dotlink`に書かれたファイルの対応関係に基づいてシンボリックリンクを張ります。

### <a name="manually">手動でインストール</a>

#### <a name="install_dot">1. dotのインストール</a>

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
echo 'clone_repository="https://github.com/ssh0/dotfiles.git"' > $HOME/.config/dot/dotrc-ssh0
echo 'dotdir="$HOME/.dotfiles-ssh0"' >> $HOME/.config/dot/dotrc-ssh0
echo 'dotlink="$HOME/.dotfiles-ssh0/dotlink"' >> $HOME/.config/dot/dotrc-ssh0
echo 'linkfiles=("$HOME/.dotfiles-ssh0/dotlink")' >> $HOME/.config/dot/dotrc-ssh0
```

* 自分の{bash|zsh}rcファイルに以下を追記(その後shellrcファイルを再読み込み)

```
alias dot-ssh0="dot -c $HOME/.config/dot/dotrc-ssh0"
```

* 以下のコマンドを実行

```
dot-ssh0 clone && dot-ssh0 set -v
```

これにより、このリポジトリ内のファイルがローカルにクローンされ、シンボリックリンクが生成されていきます。もし既にファイルが存在している場合には、操作を選択できるので、そこで操作を指定してください。

もしくは、`dot set --ignore -v`とオプションをつければ、重複するファイルなどはすべて無視されます。

このリポジトリは進行中のプロジェクトであるため、いくつかのファイルは将来変更、追加される可能性があります。
これらのファイルを最新に保つには、

```
dot-ssh0 update -v -i
```

と実行してください。

## <a name="install_without_dot">dotを用いないシンプルな方法</a>

このリポジトリをクローンするかフォークしてください:

```
git clone --depth 1 --recursive  https://github.com/ssh0/dotfiles.git ~/.dotfiles-ssh0
```

お好みの設定ファイルをコピーしたり，シンボリックリンクを張ったりして，設定を反映させてください。

ライセンス
==========

このリポジトリ内の(サブモジュール化されたものを除く)すべてのファイルは[WTFPL](http://www.wtfpl.net/)ライセンスの下で公開されます。

全文は[ここ](./LICENSE)に記載してあります。

