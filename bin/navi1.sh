#!/bin/sh
#


# オプションチェック
while getopts d: OPT
do
  case ${OPT} in
    d) FLG_D="TRUE" ;
       D="$OPTARG"
       ;; 
  esac
done

if [ "$FLG_D" != "TRUE" ]; then
    # デフォルトは0日（0日後の天気 = 今日）
    D=0
fi

if [ $D -gt 6 ]; then
    echo "-dオプションは6以下である必要があります。"
    exit;
fi

# areaの添字を変えるとエリアが変わる（今は東京）
WEATHERINFO=`xpath -e /weatherforecast/pref/area[4]/info[${D}+1] /home/shotaro/Workspace/weather.xml 2> /dev/null`

DATE=`echo $WEATERINFO | sed -e 's/<info date=\"//' -e 's/\">.+//'`
WEATHER=`echo  $WEATHERINFO | xpath -e /info[1]/weather 2> /dev/null | sed -e 's/<weather>//' -e 's/<\/weather>//'`
DWEATHER=`echo  $WEATHERINFO | xpath -e /info[1]/weather_detail 2> /dev/null | sed -e 's/<weather_detail>//' -e 's/<\/weather_detail>//'`
MAXTEMP=`echo  $WEATHERINFO | xpath -e /info[1]/temperature/range[1] 2> /dev/null | sed -e 's/<range centigrade="max">//' -e 's/<\/range>//'`
MINTEMP=`echo  $WEATHERINFO | xpath -e /info[1]/temperature/range[2] 2> /dev/null | sed -e 's/<range centigrade="min">//' -e 's/<\/range>//'`
RAIN1=`echo  $WEATHERINFO | xpath -e /info[1]/rainfallchance/period[1] 2> /dev/null | sed -e 's/<period hour="00-06">//' -e 's/<\/period>//'`
RAIN2=`echo  $WEATHERINFO | xpath -e /info[1]/rainfallchance/period[2] 2> /dev/null | sed -e 's/<period hour="06-12">//' -e 's/<\/period>//'`
RAIN3=`echo  $WEATHERINFO | xpath -e /info[1]/rainfallchance/period[3] 2> /dev/null | sed -e 's/<period hour="12-18">//' -e 's/<\/period>//'`
RAIN4=`echo  $WEATHERINFO | xpath -e /info[1]/rainfallchance/period[4] 2> /dev/null | sed -e 's/<period hour="18-24">//' -e 's/<\/period>//'`

echo "${DATE} \n
	天気    :\\t"${WEATHER}" \n
	詳細    :\\t"${DWEATHER}" \n
	最高気温:\\t"${MAXTEMP}"℃\n
	最低気温:\\t"${MINTEMP}"℃\n
	\\t 時間帯\\t降水確率\n
	\\t  00-06\\t"${RAIN1}"％\n
	\\t  06-12\\t"${RAIN2}"％\n
	\\t  12-18\\t"${RAIN3}"％\n
	\\t  18-24\\t"${RAIN4}"％"
	
