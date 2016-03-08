#!/bin/bash
# written by Shotaro Fujimoto (https://github.com/ssh0)
#=#=#=
# Make bin/README.md
# 
# Required: [header.sh](./header.sh)
#=#=

readme="README.md"
title="$(basename "${PWD}")"

# initialise
cat << EOF > "$readme"
${title}
===

EOF

for file in $(find . -type f -name "*" | sort | grep -v "README"); do
  echo "## ["$(echo ${file##\./} | sed 's@\_@\\_@g')"]($file)" >> "$readme"
  echo >> "$readme"
  echo "$(header.sh "$file")" >> "$readme"
  echo >> "$readme"
done

cat << EOF >> "$readme"
---

This page is generated automatically by [makebinreadme.sh](https://github.com/ssh0/dotfiles/blob/master/bin/makebinreadme.sh)

EOF

