#!/bin/sh -eux
#if [ -z $2 ] ; then
    platex $1; platex $1 && dvipdfmx "${1%%.tex}".dvi
    exit 0
#elif [ $2 = 'bib' ] ; then
#    platex $1; platex $1; pbibtex "${1%%.tex}" ; platex $1 && dvipdfmx "${1%%.tex}".dvi
#    exit 0
#else
#    exit 1
#fi
