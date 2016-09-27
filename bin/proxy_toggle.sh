#!/bin/sh
#=#=#=
# If you are in proxy network, you should manage your proxy setting.
#
# This script enables you to toggle proxy setting by one command.
#=#=
HTTP_PROXY_HOST="http://www-proxy.waseda.jp:8080"
HTTPS_PROXY_HOST="https://www-proxy.waseda.jp:8080"
FTP_PROXY_HOST="ftp://proxy.waseda.jp:21"

# shellrc=$HOME/.zshrc  # .bashrc
shellrc=${ZSH}/rc.mine  # .bashrc

cancel() {
  echo "[proxy-toggle] Aborted." >&2
  exit
}

trap cancel SIGINT

if [ $# = 0 ]; then
  echo "Error: no args"
  exit 1
else
  if [ $1 = "on" ]; then
    sudo sed -i.bak '/http[s]::proxy/Id' /etc/apt/apt.conf
    sudo sed -i.bak '/ftp::proxy/Id' /etc/apt/apt.conf
    sudo tee -a /etc/apt/apt.conf <<EOF
Acquire::http::proxy "$HTTP_PROXY_HOST/";
Acquire::https::proxy "$HTTPS_PROXY_HOST/";
Acquire::ftp::proxy "$FTP_PROXY_HOST/";
EOF

    sudo sed -i.bak "/http_proxy/Id" /etc/environment
    sudo sed -i.bak "/HTTP_PROXY/Id" /etc/environment
    sudo sed -i.bak "/https_proxy/Id" /etc/environment
    sudo sed -i.bak "/HTTPS_PROXY/Id" /etc/environment
    sudo sed -i.bak "/ftp_proxy/Id" /etc/environment
    sudo sed -i.bak "/FTP_PROXY/Id" /etc/environment
    sudo tee -a /etc/environment <<EOF
http_proxy=$HTTP_PROXY_HOST
HTTP_PROXY=$HTTP_PROXY_HOST
https_proxy=$HTTPS_PROXY_HOST
HTTPS_PROXY=$HTTPS_PROXY_HOST
ftp_proxy=$FTP_PROXY_HOST
FTP_PROXY=$FTP_PROXY_HOST
EOF
    sed -i.bak '/http_proxy/Id' $shellrc
    sed -i.bak '/HTTP_PROXY/Id' $shellrc
    sed -i.bak '/https_proxy/Id' $shellrc
    sed -i.bak '/HTTPS_PROXY/Id' $shellrc
    sed -i.bak '/ftp_proxy/Id' $shellrc
    sed -i.bak '/FTP_PROXY/Id' $shellrc
    tee -a $shellrc <<EOF
export http_proxy=$HTTP_PROXY_HOST
export HTTP_PROXY=$HTTP_PROXY_HOST
export https_proxy=$HTTPS_PROXY_HOST
export HTTPS_PROXY=$HTTPS_PROXY_HOST
export ftp_proxy=$FTP_PROXY_HOST
export FTP_PROXY=$FTP_PROXY_HOST
EOF
    sudo npm -g config set proxy "$HTTP_PROXY_HOST"
    sudo npm -g config set https-proxy "$HTTPS_PROXY_HOST"
    sudo npm -g config set registry "http://registry.npmjs.org/"
  else
    if [ $1 = "off" ]; then
      sudo sed -i.bak "/http::proxy/Id" /etc/apt/apt.conf
      sudo sed -i.bak "/https::proxy/Id" /etc/apt/apt.conf
      sudo sed -i.bak "/ftp::proxy/Id" /etc/apt/apt.conf
      sudo sed -i.bak "/http_proxy/Id" /etc/environment
      sudo sed -i.bak "/HTTP_PROXY/Id" /etc/environment
      sudo sed -i.bak "/https_proxy/Id" /etc/environment
      sudo sed -i.bak "/HTTPS_PROXY/Id" /etc/environment
      sudo sed -i.bak "/ftp_proxy/Id" /etc/environment
      sudo sed -i.bak "/FTP_PROXY/Id" /etc/environment
      sed -i.bak '/http_proxy/Id' $shellrc
      sed -i.bak '/HTTP_PROXY/Id' $shellrc
      sed -i.bak '/https_proxy/Id' $shellrc
      sed -i.bak '/HTTPS_PROXY/Id' $shellrc
      sed -i.bak '/ftp_proxy/Id' $shellrc
      sed -i.bak '/FTP_PROXY/Id' $shellrc
      tee -a $shellrc <<EOF
export http_proxy=
export HTTP_PROXY=
export https_proxy=
export HTTPS_PROXY=
export ftp_proxy=
export FTP_PROXY=
EOF
      sudo npm -g config delete proxy
      sudo npm -g config delete https-proxy
      sudo npm -g config set registry "https://registry.npmjs.org/"
    else
      echo "arg: 'on' or 'off'"
      exit 1
    fi
  fi
fi
exit 0
