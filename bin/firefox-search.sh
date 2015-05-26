#!/bin/sh
# firefox-search 検索キーワードとオプションからfirefoxを起動するシェルスクリプト

bun=`zenity --entry \
	--title="Firefox-search" \
	--text="Search or enter address" \
	--window-icon=/home/shotaro/.icons/Faenza-Dark/actions/scalable/edit-find.svg`


if [ $? -ne 0 ] || [ -z "$bun" ]; then
	exit 0
else
	if [ "$bun" = "-c" ] ; then
				cinii.sh
	else
        hiduke=`date +%F_%T`
        echo "$hiduke $bun" >> /home/shotaro/Dropbox/log.txt
		case ${bun} in
		
			-[wW]*) # Wikipediaで検索
				pattern="https://ja.wikipedia.org/wiki/${bun#-[wW] }"
				;;
				
			-[nN]*) # ニコニコ動画で検索
				pattern="http://www.nicovideo.jp/search/${bun#-[nN] }"
				;;
				
			-[yY]*) # Youtubeで検索
				pattern="http://www.youtube.com/results?search_query=${bun#-[yY] }&sm=3"
				;;
				
			-[pP]*) # Google画像検索
				pattern="https://www.google.com/search?hl=ja&site=imghp&tbm=isch&source=hp&q=${bun#-[pP]}&oq=${bun#-[pP] }"
				;;
				
			-rt*) # Yahooリアルタイム検索
				pattern="http://realtime.search.yahoo.co.jp/search?tt=c&ei=UTF-8&fr=sfp_as&aq=-1&oq=&p=${bun#-rt }"
				;;
				
			-sc*) # Google Scholar検索
				pattern="http://scholar.google.co.jp/scholar?lr=&q=${bun#-sc }&hl=ja&as_sdt=0,5&as_vis=1"
				;;
				
			-[tT]*) # 翻訳
				pattern="http://ejje.weblio.jp/content/${bun#-[tT] }"
				;;
				
			http*) # 直接URL貼り付け
				pattern="$bun"
				;;
				
			*) # Google検索
				pattern="https://www.google.co.jp/#q=$bun"
				;;
				
		esac
		
		firefox -new-tab "$pattern"
		
	fi
fi

