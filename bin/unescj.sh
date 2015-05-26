#! /bin/sh
#
# unsecj.sh
#    JSONによるエスケープ文字を含む文字列をアンエスケープする
#    ・Unicodeエスケープが含まれている場合はその部分をUTF-8化する
#    ・このスクリプトはJSONの値部分のみの処理を想定している
#      (値の中に改行を示すエスケープがあったら素直に改行に変換する。
#       これが困る場合は -n オプションを使う。すると "\n" と出力される)
#    ・JSON文字列のパース(キーと値の分離)はjsonparser.shで予め行うこと
#
# Usage: unsecj.sh [-n] [JSON_value_textfile]
#
# Written by Rich Mikan(richmikan[at]richlab.org) / Date : Feb 2, 2014


BS=$(printf '\010')             # バックスペース
TAB=$(printf '\011')            # タブ
LF=$(printf '\\\n_');LF=${LF%_} # 改行(sedコマンド取扱用)
FF=$(printf '\014')             # 改ページ
CR=$(printf '\015')             # キャリッジリターン

if [ \( $# -ge 1 \) -a \( "_$1" = '_-n' \) ]; then
  LF_NONDECODE=1
  shift
fi
if [ \( $# -eq 1 \) -a \( \( -f "$1" \) -o \( -c "$1" \) \) ]; then
  file=$1
elif [ \( $# -eq 0 \) -o \( \( $# -eq 1 \) -a \( "_$1" = '_-' \) \) ]
then
  file='-'
else
  echo "Usage : ${0##*/} [-n] [JSON_value_textfile]" 1>&2
  exit 1
fi

# === データの流し込み ============================================= #
cat "$file"                                                          |
#                                                                    #
# === もとからあった改行に印"\n"をつける =========================== #
if [ -z "${LF_NONDECODE:-}" ]; then                                  #
  sed '$!s/$/\\n/'                                                   #
else                                                                 #
  sed '$!s/$/\\N/' # -nオプション付の場合は"\n"を保持する為"\N"とする#
fi                                                                   |
#                                                                    #
# === Unicodeエスケープ文字列(\uXXXX)の手前に改行を挿入 ============ #
sed 's/\(\\u[0-9A-Fa-f]\{4\}\)/'"$LF"'\1/g'                          |
#                                                                    #
# === Unicodeエスケープ文字列をデコード ============================ #
#     (但し\u000a と \u000d と \u005c は \n、\r、\\ に変換する）     #
awk '                                                                \
BEGIN {                                                              \
  OFS=""; ORS="";                                                    \
  for(i=255;i>=0;i--) {                                              \
    s=sprintf("%c",i);                                               \
    bhex2chr[sprintf("%02x",i)]=s;                                   \
    bhex2chr[sprintf("%02X",i)]=s;                                   \
    #bhex2int[sprintf("%02x",i)]=i;                                  \
    #bhex2int[sprintf("%02X",i)]=i;                                  \
  }                                                                  \
  for(i=65535;i>=0;i--) {          # 0000～FFFFの16進値を10進値に変  \
    whex2int[sprintf("%02x",i)]=i; # 換する際、00～FFまでの連想配列  \
    whex2int[sprintf("%02X",i)]=i; # 256個を作って2桁ずつ2度使うより \
  }                                # こちらを1度使う方が若干速かった \
}                                                                    \
/^\\u000[Aa]/ {                                                      \
  print "\\n", substr($0,7);                                         \
  next;                                                              \
}                                                                    \
/^\\u000[Dd]/ {                                                      \
  print "\\r", substr($0,7);                                         \
  next;                                                              \
}                                                                    \
/^\\u005[Cc]/ {                                                      \
  print "\\\\", substr($0,7);                                        \
  next;                                                              \
}                                                                    \
/^\\u00[0-7][0-9a-fA-F]/ {                                           \
  print bhex2chr[substr($0,5,2)], substr($0,7);                      \
  next;                                                              \
}                                                                    \
/^\\u0[0-7][0-9a-fA-F][0-9a-fA-F]/ {                                 \
  i=whex2int[substr($0,3,4)];                                        \
  #i=bhex2int[substr($0,3,2)]*256+bhex2int[substr($0,5,2)];          \
  printf("%c",192+int(i/64));                                        \
  printf("%c",128+    i%64 );                                        \
  print substr($0,7);                                                \
  next;                                                              \
}                                                                    \
/^\\u[0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F]/ {                 \
  i=whex2int[substr($0,3,4)];                                        \
  #i=bhex2int[substr($0,3,2)]*256+bhex2int[substr($0,5,2)];          \
  printf("%c",224+int( i/4096    ));                                 \
  printf("%c",128+int((i%4096)/64));                                 \
  printf("%c",128+     i%64       );                                 \
  print substr($0,7);                                                \
  next;                                                              \
}                                                                    \
{                                                                    \
  print;                                                             \
}                                                                    \
'                                                                    |
# === \\ 以外のエスケープ文字列をデコード ========================== #
sed 's/\\"/"/g'                                                      |
sed 's/\\\//\//g'                                                    |
sed 's/\\b/'"$BS"'/g'                                                |
sed 's/\\f/'"$FF"'/g'                                                |
if [ -z "${LF_NONDECODE:-}" ]; then                                  #
  sed 's/\\n/'"$LF"'/g'                                              #
else                                                                 #
  sed 's/\\N/'"$LF"'/g'                                              #
fi                                                                   |
sed 's/\\r/'"$CR"'/g'                                                |
sed 's/\\t/'"$TAB"'/g'                                               |
#                                                                    #
# === \\ をデコード ================================================ #
sed 's/\\\\/\\/g'