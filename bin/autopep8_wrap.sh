pyfile=$1
autopep8 ${pyfile} > tmp && mv tmp ${pyfile}
