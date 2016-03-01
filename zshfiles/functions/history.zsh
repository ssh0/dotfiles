#=#=#=
# Set options for history
#
# **Features**
#
# * increase history size
# * ignore duplicate line
# * share history with each terminals
#=#=

HISTFILE="$ZSH_ROOT/history"

HISTSIZE=10000
SAVEHIST=10000

# Show history
case $HIST_STAMPS in
  "mm/dd/yyyy") alias history='fc -fl 1' ;;
  "dd.mm.yyyy") alias history='fc -El 1' ;;
  "yyyy-mm-dd") alias history='fc -il 1' ;;
  *) alias history='fc -l 1' ;;
esac

setopt extended_history      # コマンドの開始時刻と経過時間を登録
setopt hist_ignore_dups      # 直線のコマンド行と同一なら登録しない
setopt hist_ignore_all_dups  # 登録済みコマンドの古い方を削除
setopt hist_ignore_space     # コマンド行の先頭が空白なら登録しない
setopt hist_reduce_blanks    # 余分な空白は詰めて登録
setopt hist_verify
setopt share_history         # ヒストリの共有
