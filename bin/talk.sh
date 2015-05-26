#!/bin/sh

while :
do
	text=`zenity --entry \
		--title="jtalk" \
		--text="喋らせたい文章を書き込んでください。"`
	if [ $? -ne 0 ] || [ -z "$text" ]; then
		break
	else
		TMP=/home/shotaro/Workspace/open-jtalk/open-talk.wav
		touch $TMP
		cd /usr/share/hts-voice/nitech-jp-atr503-m001
		#cd /usr/share/hts-voice/mei_happy
		echo "${text}" | open_jtalk \
		-td tree-dur.inf \
		-tf tree-lf0.inf \
		-tm tree-mgc.inf \
		-md dur.pdf \
		-mf lf0.pdf \
		-mm mgc.pdf \
		-dm mgc.win1 \
		-dm mgc.win2 \
		-dm mgc.win3 \
		-df lf0.win1 \
		-df lf0.win2 \
		-df lf0.win3 \
		-dl lpf.win1 \
		-ef tree-gv-lf0.inf \
		-em tree-gv-mgc.inf \
		-cf gv-lf0.pdf \
		-cm gv-mgc.pdf \
		-k gv-switch.inf \
		-s 17000 \
		-a 0.05 \
		-u 0.0 \
		-jm 1.0 \
		-jf 1.0 \
		-jl 1.0 \
		-x /var/lib/mecab/dic/open-jtalk/naist-jdic \
		-ow $TMP && \
		aplay --quiet $TMP
	fi
done
