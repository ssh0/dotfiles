#!/bin/sh
#

# 引数チェック
if [ $# = 0 ]; then
    echo "need at least one argument (0 given)" 1>&2
else
    if [ $# = 1 ]; then
        inputfile_extension=${1##*.}
        if [${inputfile_extension} -ne tex]; then
            echo "need to set 'tex' file for argument" 1>&2
            exit 0
        else
            inputfile=$1
            outputfile=${inputfile%.*}.rst
        fi
    else
        if [ $# = 2 ]; then
            inputfile_extension=${1##*.}
            if [${inputfile_extension} -ne tex]; then
                echo "need to set 'tex' file for argument" 1>&2
                exit 0
            else
                inputfile=$1
                outputfile=$2
        else
            echo "need 1 or 2 arguments ( %d given)"%$# 1>&2
            exit 0
        fi
    fi
fi

