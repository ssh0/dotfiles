#! /bin/sh
#
# radiru
#   NHK サイマル放送 らじる★らじるコンソール・プレイヤー
# https://gist.github.com/mitsugu/1187648#file-radiru
#
#   動作確認環境
#     Ubuntu 10.04 Lucid Lynx
#     MPlayer SVN-r34165-4.4.3 (リポジトリ・ビルド)
#     Codec ( 自家ビルド )
#       https://github.com/mitsugu/bash/tree/master/AV/codecs
#
case $1 in
  am2)
    mplayer -really-quiet -playlist http://mfile.akamai.com/129932/live/reflector:46056.asx
    ;;
  tokyo1)
    mplayer -really-quiet -playlist http://mfile.akamai.com/129931/live/reflector:46032.asx
    ;;
  tokyofm)
    mplayer -really-quiet -playlist http://mfile.akamai.com/129933/live/reflector:46051.asx
    ;;
  osaka1)
    mplayer -really-quiet -playlist http://mfile.akamai.com/220635/live/reflector:53531.asx
    ;;
  osakafm)
    mplayer -really-quiet -playlist http://mfile.akamai.com/220636/live/reflector:50883.asx
    ;;
  nagoya1)
    mplayer -really-quiet -playlist http://mfile.akamai.com/220637/live/reflector:52219.asx
    ;;
  nagoyafm)
    mplayer -really-quiet -playlist http://mfile.akamai.com/220638/live/reflector:55740.asx
    ;;
  sendai1)
    mplayer -really-quiet -playlist http://mfile.akamai.com/220639/live/reflector:59124.asx
    ;;
  sendaifm)
    mplayer -really-quiet -playlist http://mfile.akamai.com/220640/live/reflector:52017.asx
    ;;
  *)
    echo 'Usage:'
    echo '  radiru am2'
    echo '  radiru tokyo1'
    echo '  radiru tokyofm'
    echo '  radiru osaka1'
    echo '  radiru osakafm'
    echo '  radiru nagoya1'
    echo '  radiru nagoyafm'
    echo '  radiru sendai1'
    echo '  radiru sendaifm'
    exit 1
    ;;
esac

