[English](./README.md)

dotfiles
========

このリポジトリには，設定ファイル群であるdotfilesが含まれています。

シンボリックリンクを張ったり，新しいファイルをリポジトリ内に取り込んだり，マシン固有の設定を管理するために，[dot](https://github.com/ssh0/dot)を使っています。

内容
----

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
------------------

![screenshot.png](./screenshots/screenshot.png)

インストール
--------------

### [dot](https://github.com/ssh0/dot)を用いた方法。

まず，dotをインストールします。

dotのプロジェクトリポジトリを自分のPCにクローンしてください。

```
git clone https://github.com/ssh0/dot.git ~/.git/dot
```

次に，以下のコマンドを実行してください。

```
cd ~/.git/dot
sudo make install
```

dotを用いて，指定したディレクトリに本リポジトリをクローンします(デフォルト: `~/.dotfiles`)。

```
dot clone [/path/you/want/to/clone]
```

シンボリックリンクを張るには

```
dot set
```

を実行してください。もし既にファイルが存在している場合には，対話メニューが出るので，そこから操作を指定してください。

もし初めから追加したくないファイルがあるならば，`~/.dotfiles/dotlink`の該当行を"#"でコメントアウトしてください。

リポジトリを最新状態にするには，

```
dot pull
```

を実行してください。

### dotを用いないシンプルな方法

このリポジトリをクローンするかフォークしてください。

```
git clone https://github.com/ssh0/dotfiles.git ~/.ssh0-dotfiles
```

お好みの設定ファイルをコピーしたり，シンボリックリンクを張ったりして，設定を反映させてください。

ライセンス
----------

このリポジトリ内の(サブモジュール化されたものを除く)すべてのファイルは[WTFPL](http://www.wtfpl.net/)ライセンスの下で公開されます。

全文は[ここ](./LICENSE)に記載してあります。

