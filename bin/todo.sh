#!/bin/sh

bun=`zenity --forms \
	--title="todo.txt" \
	--window-icon=/home/shotaro/.icons/Faenza/apps/scalable/tomboy-note.svg \
	--separator=" " \
	--forms-date-format="%Y-%m-%d" \
	--add-entry="Priority" \
	--add-calendar="Date" \
	--add-entry="Task" \
	--add-entry="Projects" \
	--add-entry="Contexts"` 

if [ $? -ne 0 ]; then
	exit
else
	echo "$bun" >> /home/shotaro/Dropbox/todo/todo.txt
fi

