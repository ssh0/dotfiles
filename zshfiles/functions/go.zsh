if [ -x "`which go`" ]; then
    export GOPATH=$HOME/src
    export PATH=$PATH:$GOPATH
fi