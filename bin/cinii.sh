#!/bin/sh
# cinnni.sh 検索キーワードから論文データベースCiNiiにアクセスするシェルスクリプト
#
#
zenity --question \
	--title="CiNii - 論文検索" \
	--text="詳細検索を行いますか?"
if [ $? -ne 0 ] ; then
	bun=`zenity --entry \
		--title="CiNii - 論文検索" \
		--text="検索キーワードを記入"`	
	if [ -z "$bun" ] ; then
		exit 0
	else
	    hiduke=`date +%F_%T`
		echo "$hiduke -cinii $bun" >> /home/shotaro/Dropbox/log.txt
		firefox -new-tab "http://ci.nii.ac.jp/opensearch/search?q=$bun&count=20&start=1&sortorder=$sortorder"
	fi
else
	bun=`zenity --forms \
		--title="CiNii - 論文検索" \
		--separator="," \
		--text="検索キーワードを記入" \
		--add-entry="検索ワード" \
		--add-entry="タイトル" \
		--add-entry="著者名" \
		--add-entry="著者所属" \
		--add-entry="刊行物名" \
		--add-entry="ISSN" \
		--add-entry="巻" \
		--add-entry="号" \
		--add-entry="ページ(例:12-27)" \
		--add-entry="出版者" \
		--add-entry="参考文献" \
		--add-entry="出版年(〜年から)" \
		--add-entry="出版年(〜年まで)"`
	if [ $? -ne 0 ] || [ "${bun}" = ",,,,,,,,,,,," ] ; then
		exit 0
	else
		q=`echo $bun | cut -d "," -f 1`
		title=`echo $bun | cut -d "," -f 2`
		author=`echo $bun | cut -d "," -f 3`
		affiliation=`echo $bun | cut -d "," -f 4`
		journal=`echo $bun | cut -d "," -f 5`
		issn=`echo $bun | cut -d "," -f 6`
		volume=`echo $bun | cut -d "," -f 7`
		issue=`echo $bun | cut -d "," -f 8`
		page=`echo $bun | cut -d "," -f 9`
		publisher=`echo $bun | cut -d "," -f 10`
		references=`echo $bun | cut -d "," -f 11`
		year_from=`echo $bun | cut -d "," -f 12`
		year_to=`echo $bun | cut -d "," -f 13`
#
		sortorder=`zenity --list \
		  --title="表示する順序を選んでください。" \
		  --width=300 --height=250 \
		  --column="No." --column="表示する順序" \
		  	1 "出版年：新しい順" \
			2 "出版年：古い順" \
			3 "タイトル：五十音逆順" \
			4 "タイトル：五十音順" \
			5 "刊行物名：五十音逆順" \
			6 "刊行物名：五十音順" \
			7 "被引用件数：多い順"`
		if [ $? -ne 0 ] ; then
			exit 0
		else
            hiduke=`date +%F_%T`
			echo "$hiduke -cinii $bun" >> /home/shotaro/Dropbox/log.txt
			firefox -new-tab "http://ci.nii.ac.jp/opensearch/search?q=$q&count=20&start=1&title=$title&author=$author&affiliation=$affiliation&journal=$journal&issn=$issn&volume=$volume&issue=$issue&page=$page&publisher=$publisher&references=$references&year_from=$year_from&year_to=$year_to&range=&sortorder=$sortorder"
		fi
	fi
fi

