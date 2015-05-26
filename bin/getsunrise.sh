#! /bin/sh

#######################################################################
#
# 日の出・日の入時刻検索コマンド GETSUNRISE.SH
#
# [概要]
# ・第1引数に郵便番号(必須,7桁)、第2引数に日付(任意,8桁)を与えると
#   WebAPIを叩きに行って、その地域、その日の日の出&日の入り時刻を返すよ。
#
# [動かすのに必要なもの]
# ・BourneシェルとUNIX標準コマンド群（UNIXが動いているなら特に準備の必要なし）
# ・curlコマンド（pathの通っている場所に置いてあればOK）
# ・拙作の JSON & XML パーサー(parsrj.sh,unesc.sh,parsrx.sh)
#   - 説明ページ→   https://gist.github.com/richmikan/3251311
#   - ダウンロード→ https://gist.github.com/richmikan/3251311/download
#   - このシェルスクリプトと同じディレクトリーに実行権限付で置いておくこと
#
#######################################################################


# ===== WebAPI（お世話になります!）URLの設定 =========================

# --- 1.郵便番号API（HeartRails Geo API＠ハートレイルズさん）
ZIPCODEAPI='http://geoapi.heartrails.com/api/json'

# --- 2.日の出・日の入時刻API（おはこん番地は!?＠ビットマイスターさん）
SUNAPI='http://labs.bitmeister.jp/ohakon/api/'


# ===== エラー関数定義 ===============================================

error_exit() {
  echo 'Usage : ${0##*/} <zipcode> [date]' 2>&1  # 書式を表示して終了
  exit 1
}


# ===== 引数チェック =================================================

# --- 引数は1つまたは2つでなければならない
[ $# -gt 0 ] || error_exit
[ $# -lt 3 ] || error_exit

# --- 1つ目(必須)、郵便番号のチェック
echo "_$1" | grep -E '^_[0-9]{3}-?[0-9]{4}$' >/dev/null
[ $? -eq 0 ] || error_exit
zipcode=$(echo $1 | tr -d '-')

# --- 2つ目(任意)、年月日のチェック
echo "_$2" | grep -E '^_([0-9]{4}/?[0-9]{2}/?[0-9]{2}|)$' >/dev/null
[ $? -eq 0 ] || error_exit
yyyymmdd=$(echo $2 | tr -d '/')
[ -z "$yyyymmdd" ] && yyyymmdd=$(date '+%Y%m%d')


# ===== 郵便番号に基づき、地名と緯度経度の取得 =======================

requrl="${ZIPCODEAPI}?method=searchByPostal&postal=${zipcode}"

# --- 郵便番号→住所 WebAPI を叩いて都道府県＆市区町村を取り出す
rslt=$(curl -s "$requrl"              | # WebAPIを叩く
       tr -d '\r'                     | # CR+LF→LF
       ${0%/*}/parsrj.sh              | # JSONパーサーにかける
       ${0%/*}/unescj.sh              | # JSONエンコード文字を元に戻す
       grep -F 'location[0]'          | # 最初の検索結果だけにする
       awk '                          #   必要なデータだけ抽出
         $1~/prefecture$/{p=$2;next;} #    (都道府県)
         $1~/city$/      {c=$2;next;} #    (市区町村)
         $1~/town$/      {t=$2;next;} #    (町)
         $1~/x$/         {x=$2;next;} #    (経度)
         $1~/y$/         {y=$2;next;} #    (緯度)
         END {                        #
           printf("%s%s%s ",p,c,t);   #  "住所 緯度,経度"
           printf("%s,%s",y,x);       #  のフォーマットで出力
         }'                           )

# --- 存在しない郵便番号だったら、メッセージ吐いておわり
if [ "$rslt" = ' ,' ]; then
  echo "${0##*/} : そんな郵便番号はないみたいです。" 2>&1
  exit 1
fi

# --- (次のWebAPIのために)、地名と緯度経度を分離
addr=${rslt% *}
loc=${rslt#* }


# ===== 次のAPIは、15秒のウェイトが入るっぽいので、メッセージを出す。=

printf '%s、%sの日の出・日の入時刻を調べます。\n(15秒くらい待ってね...)\n\n' \
       "${addr}"                                                             \
       "${yyyymmdd}"                                                         \
       2>&1


# ===== 日の出・日の入WebAPIを叩き、レポートを作成 ===================

# --- 年月日を分離
monthdate=${yyyymmdd#[0-9][0-9][0-9][0-9]}
year=${yyyymmdd%[0-9][0-9][0-9][0-9]}
month=${monthdate%[0-9][0-9]}
day=${monthdate#[0-9][0-9]}

# --- リクエストURLを作る
requrl="${SUNAPI}?mode=sun_moon_rise_set"
requrl="$requrl&year=$year&month=$month&day=$day&lat=${loc%,*}&lng=${loc#*,}"

# --- 住所&日付→日の出日の入APIを叩いて、時刻を取り出す
curl -s "$requrl"                                           | # WebAPIを叩く
tr -d '\r'                                                  | # CR+LF→LF
${0%/*}/parsrx.sh                                           | # XMLパーサーへ
awk -v "add=$addr" '                                        # 
  $1=="/result/date/year"               {y  =$2; next;}     # このあたりで
  $1=="/result/date/month"              {m  =$2; next;}     # XMLの中から
  $1=="/result/date/day"                {d  =$2; next;}     # 欲しい値を選んで
  $1=="/result/location/coordinate/lat" {lat=$2; next;}     # 変数に
  $1=="/result/location/coordinate/lng" {lng=$2; next;}     # 格納している
  $1=="/result/rise_and_set/sunrise_hm" {ris=$2; next;}     # ←(ここ日の出)
  $1=="/result/rise_and_set/sunset_hm"  {set=$2; next;}     # ←(ここ日の入)
  END {                                                     #
    if (! match(ris set,/[0-9]/)) {                         # 対象地域外だったら
      print addr "の日の出・日の入データは無いようです。";  # その旨伝えて
      exit;                                                 # 終了
    }                                                       #
    printf("%s(緯度=%s,経度=%s)における、\n",add, lat,lng); # 最後に
    printf("%d年%d月%d日の ", y, m, d);                     # レポートする
    printf("日の出時刻は%s、日の入時刻は%s、", ris, set);   # (人にやさしく)
    print  "みたいですよ。";                                #
  }                                                         '
