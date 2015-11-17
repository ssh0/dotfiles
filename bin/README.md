bin
===

some useful user scripts.

## [alarm](./alarm)

```
Alart after given minutes.
Usage: alarm n

In n, you can set n minutes.
Option:
  -h: Show this help.
```

## [allmp4tomp3.sh](./allmp4tomp3.sh)

```
Convert all mp4 file in the current dir to mp3 files.
Required: ffmpeg
```

## [autopep8_wrap.sh](./autopep8_wrap.sh)

autopep8 wrapper for python code.

## [bib2html_wrapper.sh](./bib2html_wrapper.sh)

bibtex2html wrapper script.

I use this script with vim-quickrun.

See here. http://qiita.com/ssh0/items/7af727f0513c3fbf09a4

## [cachecleener](./cachecleener)

This script erase cache memory (need sudo).

Thanks to SONY5614.

## [color-pallete.sh](./color-pallete.sh)

show zenity color pallete

## [cplay.sh](./cplay.sh)

if there is no process of cmus, start cmus on urxvt terminal.

else play / pause remote command will be sent to cmus program.

It's useful if you set the shortcut-key with multimedia key.


```
dotunlink
Unlink the symbolic link mangaed by dotfiles and copy the file from the repository.

Usage: dotunlink FILE [FILE2 FILE3 ...]
Option:
  -h: show this help and exit
```

## [facebook](./facebook)

use chrome app

```
/opt/google/chrome/google-chrome --profile-directory=Default --app-id=dihbebhmaoagdpbcnfedokpfkkgmmpgc
```

## [google-keep](./google-keep)

use chrome app

```
/opt/google/chrome/google-chrome --profile-directory=Default --app-id=hmjkmjkepdijhoojdojkdfohbdgmmhki
```

## [googleTTS.sh](./googleTTS.sh)

folked from https://gist.github.com/markusfisch/873364#file-say-sh

```
Text to speech CLI interface using Google translate_TTS API
Usage: googleTTS.sh [OPTION] TERM

Set options for language, saving directory:
  -l,    Set language (default: $LNG)
  -d,    Set saving directory (default: ${HOME}/Downloads/TTS/$LNG)
  -p,    Set the output player command (default: $playcmd)

  -h,    Show this message and quit quietly
```

## [latexmk_wrapper](./latexmk_wrapper)

latexmk wrapper

I often use this script with vim-quickrun to compile latex files.

If the executed file is in named "source" directory,
this script automatically look the upper directory and search the file named "main.tex" to compile.
(You can change the source code if you'd like to use different name.)

See: [TeXをもっと便利に使う!(自動コンパイル・部分コンパイル・分割ファイルから親ファイルのコンパイル)【Vim + vim-quickrun + latexmk】 - Qiita](http://qiita.com/ssh0/items/e6d7540cd46fac580bc2)

## [LINE](./LINE)

use chrome app

```
/opt/google/chrome/google-chrome --profile-directory=Default --app-id=menkifleemblimdogmoihpfopnplikde
```

## [mkdpreview](./mkdpreview)

This script make it easy to use pandoc for conver markdown to html file.
It is assumed that this script is called from vim-quickrun in order to edit markdown file with previewing.

You can change your style sheet file.

```sh
template="$HOME/Workspace/blog/styles/stylesheet.css"
```

Of cource you can load the CSS file from the web.

```sh
template='http://szk-engineering.com/markdown.css'
```

You may change these files in order to show a header bar or a footer bar.

```
header="$HOME/Workspace/blog/html/header.html"
footer="$HOME/Workspace/blog/html/footer.html"
```

MINE:

header.html

```html
<div id="main_content_wrap" class="outer">
<section id="main_content" class="inner">
```

footer.html

```html
</section>
</div>
```

If the executed file is in "source" directory,
this script converts a html file to the upper directory.
(And if "html" directory exists, the html file will be converted to there.)

Usage:

```
Simply render markdown by pandoc.
Usage: mkdpreview [OPTION] markdownfile

OPTION:
  -s: Save html file in the source file dir.
  -u: Update (the same name's) html file in the source file dir.
  -o: Set the name of html file. \`mkdpreview -o bar.html foo.md\`
  -p: Preview HTML file in firefox.
  -h: Show this message.
```

See: [markdownの編集環境をいい感じに整えてみた[vim + quickrun + pandoc] - Qiita](http://qiita.com/ssh0/items/b68263a7866b4ce9eaf1)

## [mplayer_term_wrapper.sh](./mplayer_term_wrapper.sh)

play video with color ascii on xterm.

## [mpv_term](./mpv_term)

execute mpv with another terminal (urxvtc(urxvt client))

## [myrsync](./myrsync)

I use dropbox for daily work. And I often use rsync program to synchronize the directories.

You may change the variables.

```
dropboxpath="$HOME/Dropbox/Workspace/"
localpath="$HOME/Workspace/"
```

Usage:

`myrsync up` = `rsync -av --delete $localpath $dropboxpath`
`myrsync down` = `rsync -av --delete $dropboxpath $localpath`

## [mytask](./mytask)

```
mytask is the scirpt to start my current tasks easily.

Usage:
  $ mytask [option] [start|add|remove|list] [cmdoption]

Option:
  -h       Show this help message.

Command:
  start    Execute the taskset.
  add      Add new taskset.
  edit     Edit the existing taskset.
  remove   Remove a taskset.
  list     List all existing taskset.
```

## [pandoc_beamerwrapper.sh](./pandoc_beamerwrapper.sh)

```
pandoc_beamerwrapper: pandoc wrapper for converting to beamer
Usage: pandoc_beamerwrapper [-h] [pandoc's options] INPUTFILE(or stdin)

Option:
  -h: Show this help message.
```

## [pandoc_latexwrapper.sh](./pandoc_latexwrapper.sh)

```
pandoc_latexwrapper: pandoc wrapper for converting to latex
Usage: pandoc_latexwrapper [-h] [pandoc's options] INPUTFILE(or stdin)

Option:
  -h: Show this help message.
```

## [presenmode.sh](./presenmode.sh)

xrandr wrapper for switching display at presentaion.

You may change these variables.

```
default_output="eDP1"
default_mode="1920x1080"
projector="VGA1"
projector_mode="1024x768"
```

Usage:

```
Usage: $0 COMMAND [-d output] [-m mode] [-h]
  COMMAND:
    start: Start Presentation mode
    stop : Stop Presentaion mode
  OPTION:
    -d: Output device connecting (default: $projector)
    -m: Manually select the display resolution (default: $projector_mode)
    -h: Show this message and quit
```

## [presentation.sh](./presentation.sh)

impressive(presentation software) wrapper script.

## [proxy_toggle.sh](./proxy_toggle.sh)

If you are in proxy network, you should manage your proxy setting.

This script enables you to toggle proxy setting by one command.

## [radiko_rec.sh](./radiko_rec.sh)

forked from https://github.com/haru8/radiko_rec

record the radiko progrom.

## [ris2bib](./ris2bib)

forked from https://github.com/dpohanlon/ris2bib

Convert Nature .ris format to .bib bibliography format.

## [screenshot.sh](./screenshot.sh)

Take screenshot (full window) and save it to daydir(%Y-%m-%d).

You may change the variable below.

```
rootdir=$HOME/Workspace/blog
```

See: [ShellScript - スクリーンショットを撮って日付のディレクトリに連番で保存するスクリプト - Qiita](http://qiita.com/ssh0/items/2b4e7a4146cb2da01187)

## [screenshot_select.sh](./screenshot_select.sh)

Take screenshot (select area by mouse dragging or click) and save it to daydir(%Y-%m-%d).

You may change the variable below.

```
rootdir=$HOME/Workspace/blog
```

See: [ShellScript - スクリーンショットを撮って日付のディレクトリに連番で保存するスクリプト - Qiita](http://qiita.com/ssh0/items/2b4e7a4146cb2da01187)

## [sound_volume_change_wrapper.sh](./sound_volume_change_wrapper.sh)

You should set a shortcut to the multimediakey(volume up/down/mute) to call this script.

You can also execute this command on terminal.

## [start_urxvtd.sh](./start_urxvtd.sh)

If there is no process of urxvtd (urxvt daemon), start urxvtd.

## [terminal-colors](./terminal-colors)

This file echoes a bunch of color codes to the terminal to demonstrate what's available.
Each line is the color code of one forground color, out of 17 (default + 16 escapes),
followed by a test use of that color on all nine background colors (default + 8 escapes).

from: http://tldp.org/HOWTO/Bash-Prompt-HOWTO/x329.html

## [texmath](./texmath)

```
NAME
      texmath - compile latex to png with dvipng (and create texmath file)
USAGE
      texmath [-e FILE | FILE] [-h]
ARGUMENTS
      -e FILE: Open and edit FILE.
               Or create it when FILE doesn't exist, 
      FILE:    If you provide only file name, this script compiles the file with
               latexmk and then creates png file by dvipng.
      --help:  Display this help and exit

```

## [toggle_compton.sh](./toggle_compton.sh)

I use composite mangager compton.

This script toggle enabling the composite manager.

## [toggle_xcompmgr.sh](./toggle_xcompmgr.sh)

This script toggle enabling the composite manager xcompmgr.

I don't use xcompmgr because it's slightly buggy.

## [touchpad_toggle.sh](./touchpad_toggle.sh)

toggle enabling the touchpad.

I often use this srcipt in my laptop. (also shortcut to it)

From: [How to disable the touchpad? - Ask Ubuntu](http://askubuntu.com/questions/65951/how-to-disable-the-touchpad)

## [trackpoint_toggle.sh](./trackpoint_toggle.sh)

use when you in Lenovo Thinkpad.

## [urxvt_float.sh](./urxvt_float.sh)

urxvt with "urxvt_float" name.

For xmonad float window handling.

## [wmatomp3_converter.sh](./wmatomp3_converter.sh)

By Marko Haapala

converts wma to mp3 recursively. does not delete any static files, so cleanup and renaming is needed afterwards. 

**requirements:**

* lame    - http://lame.sourceforge.net/download.php
* mplayer - apt-get install mplayer or http://www.mplayerhq.hu/design7/dload.html

## [ytdl](./ytdl)

I usually use youtube-dl for download some video clips from internet.

This script is the wrapper script of youtube-dl to save video title and url to `list` file.

```
ytdl: Wrapper script for youtube-dl.

Usage: ytdl [-h] [-A] [-L FILE] URL [youtube-dl options]

NOTE: You should place the URL *before* the youtube-dl's options.

Option:
  -A: Don't add the URL to list file
  -L: Set the list file to save URL (default file: 'list')
  -h: Show this help message
```
