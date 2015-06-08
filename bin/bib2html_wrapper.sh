#!/bin/sh
# written by Shotaro Fujimoto (https://github.com/ssh0)
# first edited: 2015-05-29

style='junsrt'
bibtex_command='pbibtex'
css="$HOME/Workspace/blog/styles/bootstrap-md.css"

bibtex2html -s "${style}" -c "${bibtex_command}" -css "${css}" $@
