#!/bin/sh
# eztranslation 窓に入れた英単語を日本語に訳すだけの簡単なプログラム

while :
do

hiduke=`date +%F_%T`
bun=`zenity --entry \
	--title="eztranslate" \
	--text="" \
	--window-icon=/home/shotaro/.icons/Faenza-Dark/actions/scalable/edit-find.svg`

if [ $? -ne 0 ] || [ -z "$bun" ]; then
	break
else
	firefox -new-tab "http://translate.google.com/?hl=ja&langpair=en|ja&text=${bun}"
	echo "$hiduke -tej $bun" >> /home/shotaro/Workspace/log.txt
fi

done
exit 0
