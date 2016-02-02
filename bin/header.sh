#!/bin/bash
# written by Shotaro Fujimoto (https://github.com/ssh0)
#
# `$1`: filename
#
# * return lines from line 3 to
# "#=============================================================================="
# * Needs space after '#'.
#==============================================================================

grep -E '^\s*#' "$1" | sed '1,2d' \
  | nl --number-width=2 --number-separator='' --number-format='ln' \
    --section-delimiter='#==============================================================================' \
  | grep -ve '^\s*#' | cut -b5-

