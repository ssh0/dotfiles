#!/bin/bash
#
# Record the radiko progrom.
# 
# forked from [here](https://github.com/haru8/radiko_rec).
#==============================================================================

LANG=ja_JP.utf8

pid=$$
date=`date '+%Y-%m-%d-%H_%M'`
playerurl=http://radiko.jp/player/swf/player_3.0.0.01.swf
playerfile="/tmp/player.swf"
keyfile="/tmp/authkey.png"

outdir="."

if [ $# -le 1 ]; then
  echo "usage : $0 channel_name duration(minuites) [outputdir] [prefix]"
  exit 1
fi

if [ $# -ge 2 ]; then
  channel=$1
  DURATION=`expr $2 \* 60`
fi
if [ $# -ge 3 ]; then
  outdir=$3
fi
PREFIX=${channel}
if [ $# -ge 4 ]; then
  PREFIX=$4
fi

#
# get player
#
if [ ! -f $playerfile ]; then
  wget -q -O $playerfile $playerurl

  if [ $? -ne 0 ]; then
    echo "failed get player"
    exit 1
  fi
fi

#
# get keydata (need swftool)
#
if [ ! -f $keyfile ]; then
  swfextract -b 14 $playerfile -o $keyfile

  if [ ! -f $keyfile ]; then
    echo "failed get keydata"
    exit 1
  fi
fi

if [ -f auth1_fms_${pid} ]; then
  rm -f auth1_fms_${pid}
fi

#
# access auth1_fms
#
wget -q \
     --header="pragma: no-cache" \
     --header="X-Radiko-App: pc_1" \
     --header="X-Radiko-App-Version: 2.0.1" \
     --header="X-Radiko-User: test-stream" \
     --header="X-Radiko-Device: pc" \
     --post-data='\r\n' \
     --no-check-certificate \
     --save-headers \
     -O auth1_fms_${pid} \
     https://radiko.jp/v2/api/auth1_fms

if [ $? -ne 0 ]; then
  echo "failed auth1 process"
  exit 1
fi

#
# get partial key
#
authtoken=`perl -ne 'print $1 if(/x-radiko-authtoken: ([\w-]+)/i)' auth1_fms_${pid}`
offset=`perl -ne 'print $1 if(/x-radiko-keyoffset: (\d+)/i)' auth1_fms_${pid}`
length=`perl -ne 'print $1 if(/x-radiko-keylength: (\d+)/i)' auth1_fms_${pid}`

partialkey=`dd if=$keyfile bs=1 skip=${offset} count=${length} 2> /dev/null | base64`

#echo "authtoken: ${authtoken} \noffset: ${offset} length: ${length} \npartialkey: $partialkey"

rm -f auth1_fms_${pid}

if [ -f auth2_fms_${pid} ]; then
  rm -f auth2_fms_${pid}
fi

#
# access auth2_fms
#
wget -q \
     --header="pragma: no-cache" \
     --header="X-Radiko-App: pc_1" \
     --header="X-Radiko-App-Version: 2.0.1" \
     --header="X-Radiko-User: test-stream" \
     --header="X-Radiko-Device: pc" \
     --header="X-Radiko-Authtoken: ${authtoken}" \
     --header="X-Radiko-Partialkey: ${partialkey}" \
     --post-data='\r\n' \
     --no-check-certificate \
     -O auth2_fms_${pid} \
     https://radiko.jp/v2/api/auth2_fms

if [ $? -ne 0 -o ! -f auth2_fms_${pid} ]; then
  echo "failed auth2 process"
  exit 1
fi

#echo "authentication success"

areaid=`perl -ne 'print $1 if(/^([^,]+),/i)' auth2_fms_${pid}`
#echo "areaid: $areaid"

rm -f auth2_fms_${pid}

#
# get stream-url
#

if [ -f ${channel}.xml ]; then
  rm -f ${channel}.xml
fi

wget -q "http://radiko.jp/v2/station/stream/${channel}.xml"

stream_url=`echo "cat /url/item[1]/text()" | xmllint --shell ${channel}.xml | tail -2 | head -1`
url_parts=(`echo ${stream_url} | perl -pe 's!^(.*)://(.*?)/(.*)/(.*?)$/!$1://$2 $3 $4!'`)

rm -f ${channel}.xml

#
# rtmpdump
#
#rtmpdump -q \
rtmpdump \
         -r ${url_parts[0]} \
         --app ${url_parts[1]} \
         --playpath ${url_parts[2]} \
         -W $playerurl \
         -C S:"" -C S:"" -C S:"" -C S:$authtoken \
         --live \
         --stop ${DURATION} \
         --flv "/tmp/${channel}_${date}"

ffmpeg -loglevel quiet -y -i "/tmp/${channel}_${date}" -acodec libmp3lame -ab 128k "${outdir}/${PREFIX}_${date}.mp3"
if [ $? = 0 ]; then
  rm -f "/tmp/${channel}_${date}"
fi

