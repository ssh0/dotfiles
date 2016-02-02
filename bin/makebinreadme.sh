#!/bin/bash
# written by Shotaro Fujimoto (https://github.com/ssh0)
# 
# Make bin/README.md
# 
# Required: ./header.sh
#==============================================================================

readme="README.md"

# initialise
cat << EOF > "$readme"
bin
===

Some useful user scripts.

EOF

for file in $(find . -type f -name "*" | sort | grep -v "README"); do
  echo "## ["$(echo ${file##\./} | sed 's@\_@\\_@g')"]($file)" >> "$readme"
  echo >> "$readme"
  echo "$(header.sh "$file")" >> "$readme"
  echo >> "$readme"
done

cat << EOF >> "$readme"
---

This page is generated automatically with [makebinreadme.sh](./makebinreadme.sh)

EOF

