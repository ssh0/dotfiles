#!/bin/sh
# このスクリプトにより、セットアップが楽に行えるようになります。

echo "マルチブート環境での時計の調整"
sudo sed -i 's/UTC=yes/UTC=no/g' /etc/default/rcS

echo "ホームフォルダ内のディレクトリ名を英語表記に"
env LANGUAGE=C LC_MESSAGES=C xdg-user-dirs-gtk-update

echo "ゲストログインとリモートデスクトップを無効化"
echo 'allow-guest=false' | sudo tee -a /etc/lightdm/lightdm.conf.d/10-ubuntu.conf
echo 'greeter-show-remote-login=false' | sudo tee -a /etc/lightdm/lightdm.conf.d/10-ubuntu.conf

# echo "トラックボールの設定"
# sudo gedit /usr/share/X11/xorg.conf.d/50-marblemouse.conf

echo "ディレクトリの作成"
cd
mkdir Workspace
cd Workspace
mkdir gnuplot
mkdir python
cd
cd Downloads
mkdir fonts
mkdir nicocache
mkdir pictures
cd

echo "ソフトウェアのアップグレード(default)"
sudo apt-get update -q && sudo apt-get upgrade

echo "追加アプリケーションのインストール"

echo "gparted"
sudo apt-get install gparted -y

echo "設定関連"
sudo apt-get install compizconfig-settings-manager compiz-plugins gnome-tweak-tool unity-tweak-tool -y

echo "gnome-shell"
sudo apt-get install gnome-shell -y

echo "media関連"
sudo apt-get install audacious audacious-plugins vlc vlc-nox vlc-data vlc-plugin-notify vlc-plugin-pulse -y

echo "preload"
sudo apt-get install preload -y

echo "gnuplotのx11表示"
sudo apt-get install gnuplot-x11 -y

# echo "Texlive日本語版(サイズが大きいため、時間がかかります。)" 
# sudo apt-get install texlive-lang-cjk

echo "各種ppaの追加"
sudo add-apt-repository ppa:webupd8team/java
sudo add-apt-repository ppa:danielrichter2007/grub-customizer
sudo add-apt-repository ppa:tualatrix/ppa
sudo add-apt-repository ppa:moka/moka-icon-theme
sudo add-apt-repository ppa:satyajit-happy/themes

sudo apt-get update -q
sudo apt-get install oracle-java7-installer grub-customizer ubuntu-tweak moka-icon-theme gnome-shell-theme-elegance-colors -y

echo "アプリケーションのアップグレード(最終)"
sudo apt-get update -q && sudo apt-get upgrade -y

echo "preloadの設定"
sudo preload
echo 'OPTIONS="-l /dev/null"' | sudo tee -a /etc/default/preload 
sudo service preload restart

