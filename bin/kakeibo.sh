#!/bin/sh
# kakeibo.sh 簡単な家計簿風シェルスクリプト

bun=`zenity --forms \
	--title="家計簿" \
	--window-icon=/home/shotaro/.icons/Faenza/apps/scalable/accessories-calculator.svg \
	--text="以下の情報を記入" \
	--separator="	" \
	--forms-date-format="%Y	%m	%d" \
	--add-calendar="日付" \
	--add-entry="金額" \
	--add-entry="種類" \
	--add-entry="備考"` 

if [ $? -ne 0 ]; then
	exit
else
	echo "$bun" >> /home/shotaro/Workspace/kakeibo.csv

	zenity --info \
		--title="" \
		--text="$bun" \
		--timeout=3
fi
