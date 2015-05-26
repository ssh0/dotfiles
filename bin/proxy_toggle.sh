#!/bin/sh

HTTP_PROXY_HOST=www-proxy.waseda.jp
HTTP_PROXY_PORT=8080
HTTPS_PROXY_HOST=www-proxy.waseda.jp
HTTPS_PROXY_PORT=8080
FTP_PROXY_HOST=proxy.waseda.jp
FTP_PROXY_PORT=21

shellrc=$HOME/.zshrc  # .bashrc

if [ $# = 0 ]; then
    echo "Error: no args"
    exit 1
else
    if [ $1 = "on" ]; then
    sudo sed -i.bak '/http[s]::proxy/Id' /etc/apt/apt.conf
    sudo sed -i.bak '/ftp::proxy/Id' /etc/apt/apt.conf
    sudo tee -a /etc/apt/apt.conf <<EOF
Acquire::ftp::proxy "ftp://$HTTP_PROXY_HOST:$HTTP_PROXY_PORT/";
Acquire::http::proxy "http://$HTTP_PROXY_HOST:$HTTP_PROXY_PORT/";
Acquire::https::proxy "https://$HTTPS_PROXY_HOST:$HTTPS_PROXY_PORT/";
EOF

    sudo sed -i.bak "/http_proxy/Id" /etc/environment
    sudo sed -i.bak "/HTTP_PROXY/Id" /etc/environment
    sudo sed -i.bak "/https_proxy/Id" /etc/environment
    sudo sed -i.bak "/HTTPS_PROXY/Id" /etc/environment
    sudo sed -i.bak "/ftp_proxy/Id" /etc/environment
    sudo sed -i.bak "/FTP_PROXY/Id" /etc/environment
    sudo tee -a /etc/environment <<EOF
http_proxy=http://$HTTP_PROXY_HOST:$HTTP_PROXY_PORT
HTTP_PROXY=http://$HTTP_PROXY_HOST:$HTTP_PROXY_PORT
https_proxy=http://$HTTPS_PROXY_HOST:$HTTPS_PROXY_PORT
HTTPS_PROXY=http://$HTTPS_PROXY_HOST:$HTTPS_PROXY_PORT
ftp_proxy=ftp://$HTTP_PROXY_HOST:$HTTP_PROXY_PORT
FTP_PROXY=ftp://$HTTP_PROXY_HOST:$HTTP_PROXY_PORT
EOF
    sed -i.bak '/http_proxy/Id' $shellrc
    sed -i.bak '/HTTP_PROXY/Id' $shellrc
    sed -i.bak '/https_proxy/Id' $shellrc
    sed -i.bak '/HTTPS_PROXY/Id' $shellrc
    sed -i.bak '/ftp_proxy/Id' $shellrc
    sed -i.bak '/FTP_PROXY/Id' $shellrc
    tee -a $shellrc <<EOF
export http_proxy=http://$HTTP_PROXY_HOST:$HTTP_PROXY_PORT
export HTTP_PROXY=http://$HTTP_PROXY_HOST:$HTTP_PROXY_PORT
export https_proxy=http://$HTTPS_PROXY_HOST:$HTTPS_PROXY_PORT
export HTTPS_PROXY=http://$HTTPS_PROXY_HOST:$HTTPS_PROXY_PORT
export ftp_proxy=ftp://$HTTP_PROXY_HOST:$HTTP_PROXY_PORT
export FTP_PROXY=ftp://$HTTP_PROXY_HOST:$HTTP_PROXY_PORT
EOF
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
        else
            echo "arg: 'on' or 'off'"
            exit 1
        fi
    fi
fi
exit 0
