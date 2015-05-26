#!/bin/sh
# readlog.sh 読書記録

date=`date +%F_%T`
log=`zenity --entry \
	--title="readlog" \
	--text="読了ページ"`

echo "$date $log" >> /home/shotaro/Workspace/readlog.txt
