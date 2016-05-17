bin
===

## [agvim](./agvim)

agvim - Search files with ag, select with `$PERCOL`, and edit in vim.

**Usage:**

```
cd ~/Workspace/blog
agvim xmonad
```

>[ag(The Silver Searcher)で検索しpecoで更に絞り込みvimで該当行を開く - Qiita](http://qiita.com/fmy/items/b92254d14049996f6ec3)

## [alarm](./alarm)

```
NAME
      alarm - Alert after specified time with popup and sound.

SYNOPSYS
      alarm NUMBER[smhd]
      alarm [-t <Notification title>][-b <Notification body>] NUMBER[smhd]
      alarm -h

OPTION
      -h: Show this help.
      -t: Set notification title
      -b: Set notification body

EXAMPLE
      # ramen timer
      alarm 3m

      # alert after 1 hour 10 minutes 30 seconds
      alarm 1h 10m 30s

      # with custom message
      alarm -t "Time to sleep" -b "zzz..." 6h
```

## [allmp4tomp3.sh](./allmp4tomp3.sh)

allmp4tomp3.sh - Convert all mp4 file in the current dir to mp3 files.

Required: ffmpeg

## [autopep8\_diff.sh](./autopep8_diff.sh)

```
Name
      autopep8_diff.sh - Show the difference between the original python file
                         and the file created with autopep8 command.

Usage
      # Show diff
      autopep8_diff.sh sample.py

      # To see this help
      autopep8_diff.sh -h

Require
      * autopep8 (can be installed with pip)
      * (optionally) vimdiff
      * (optionally) colordiff
```

## [bib2html\_wrapper.sh](./bib2html_wrapper.sh)

bibtex2html wrapper script to convert bibtex file to
readable and searchable html file.  
(I often use with vim-quickrun to automatically execute this script.)

Required: [bibtex2html](https://www.lri.fr/~filliatr/bibtex2html/)

```
apt-get install bibtex2html
```

See details here. (japanese article)

>[bibtex2htmlを利用したクールな文献管理 - Qiita](http://qiita.com/ssh0/items/7af727f0513c3fbf09a4)

## [cachecleener](./cachecleener)

This script erase cache memory (need sudo).

Thanks to SONY5614.  
and modified by Shotaro Fujimoto (https://github.com/ssh0)

## [cecho](./cecho)

cecho - colorized echo

**Usage**

```
cecho blue "Hello world!"
```

## [color-pallete.sh](./color-pallete.sh)

color-pallete.sh - Show zenity color pallete and pick a color.

But it doesn't work properly in Ubuntu 14.04 because of zenity's bug.  
>[https://bugs.launchpad.net/ubuntu/+source/zenity/+bug/1355423](https://bugs.launchpad.net/ubuntu/+source/zenity/+bug/1355423)

## [cplay.sh](./cplay.sh)

cplay.sh - send pause command to cmus or if it has not launched, run cmus.

if there is no process of cmus, start cmus on urxvt terminal.  
else play / pause remote command will be sent to cmus program.  
It's useful if you set the shortcut-key with multimedia key.

## [dripaudio](./dripaudio)

dripaudio - extract aac codec audio files from mp4 files in `$PWD`

**Require:**

* ffmpeg

## [facebook](./facebook)

launch facebook chrome-app from command line

## [google-keep](./google-keep)

launch google-keep chrome-app from command line

## [googleTTS.sh](./googleTTS.sh)

```
Text to speech CLI interface using Google translate_TTS API
Usage: googleTTS.sh [OPTION] TERM

Set options for language, saving directory:
  -l,    Set language (default: $LNG)
  -d,    Set saving directory (default: ${HOME}/Downloads/TTS/$LNG)
  -p,    Set the output player command (default: $playcmd)

  -h,    Show this message and quit quietly
```

## [header.sh](./header.sh)

```
NAME
      header.sh - Print the 'header part' of the file.

USAGE
      header.sh [-h] <file>

REMARK
      'header part' starts with "#=#=#=" and ends with "#=#="
      Needs space after each '#'
```

## [incfn](./incfn)

```
NAME
      incfn - get a serialised filename incremented by 1

USAGE
      incfn [OPTOINS]
      (At least one option from (-b -a -e -h) are necessary.)

OPTIONS
      -h    Show this help message.

      -b filename_before
            Set the string before the number. [default: ""]

      -a filename_after
            Set the string after the number. [default: ""]

      -e filename_extension
            Set the extension of the file. [default: ""]

      -d root_dir
            Specify the directory. [default: $PWD]

      -n num_of_digits
            Specify the number of digits. [default: 3]

```

### Examples

In your shell script, sometimes you want save a file in '/path/to/save'
with serial-numbered file name.
Assume that the structure of '/path/to/save' is now

```
path
└── to
    └── save
        ├── 01_file
        ├── 02_file
        ├── 04_file
        ├── file_001.txt
        ├── file_002.txt
        └── file_003.txt
```

Then you can get the seriarised file name incremented by 1 like below:

```bash
$ cd /path/to/save

$ incfn -b file_ -e txt
/path/to/save/file_004.txt

$ incfn -n 2 -a _file
/path/to/save/05_file

$ incfn -d /path/to/other -b newfile_ -e md
/path/to/other/newfile_001.md
```

**Remark**

This script prints a filename **whether the targeted directory exists or not**.

## [latexmk\_wrapper](./latexmk_wrapper)

I often use this script with vim-quickrun to compile latex files.

If the executed file is in named "source" directory,
this script automatically look the upper directory and search the file named
"main.tex" to compile.  
(You can change the source code if you'd like to use different name.)

>[TeXをもっと便利に使う!(自動コンパイル・部分コンパイル・分割ファイルから親ファイルのコンパイル)【Vim + vim-quickrun + latexmk】 - Qiita](http://qiita.com/ssh0/items/e6d7540cd46fac580bc2)

## [LINE](./LINE)

launch LINE chrome-app from command line

## [makebinreadme.sh](./makebinreadme.sh)

Make bin/README.md

Required: [header.sh](./header.sh)

## [man2pdf](./man2pdf)

Convert man page to pdf file using ps2pdf

You can change `${output_dir}`
(Dropbox is useful; you can read the pdf documents from anywhere)

Example:

```
man2pdf awk
```

## [mkdpreview](./mkdpreview)

```
NAME
      mkdpreview - Simply render markdown by pandoc.

SYNOPSYS
      mkdpreview [OPTION] markdownfile

OPTIONS
      -s: Save html file in the source file dir.
      -u: Update (the same name's) html file in the source file dir.
      -o: Set the name of html file. \`mkdpreview -o bar.html foo.md\`
      -p: Preview HTML file in firefox.
      -h: Show this message.

```

This script make it easy to use pandoc for converting markdown to html file.
It is assumed that this script is called from vim-quickrun
in order to edit markdown file with live-preview.

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

my header.html

```html
<div id="main_content_wrap" class="outer">
<section id="main_content" class="inner">
```

my footer.html

```html
</section>
</div>
```

If the executed file is in "source" directory,
this script converts a html file to the upper directory.
(And if "html" directory exists, the html file will be converted to there.)

>[markdownの編集環境をいい感じに整えてみた[vim + quickrun + pandoc] - Qiita](http://qiita.com/ssh0/items/b68263a7866b4ce9eaf1)

## [mplayer\_term\_wrapper.sh](./mplayer_term_wrapper.sh)

play video with color ascii on xterm.

## [mpv\_term](./mpv_term)

Execute mpv with another terminal (urxvtc(urxvt client))

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
NAME
      mytask - start my current tasks easily.

USAGE
      mytask [option] [start|add|remove|list] [cmdoption]

OPTION
      -h:  Show this help message.

COMMAND
      start    Execute the taskset.
      add      Add new taskset.
      edit     Edit the existing taskset.
      remove   Remove a taskset.
      list     List all existing taskset.
```

## [pandoc\_beamerwrapper.sh](./pandoc_beamerwrapper.sh)

```
NAME
      pandoc_beamerwrapper - pandoc wrapper for converting to beamer

USAGE
      pandoc_beamerwrapper [-h] [pandoc's options] INPUTFILE(or stdin)

OPTION
      -h: Show this help message.
```

## [pandoc\_latexwrapper.sh](./pandoc_latexwrapper.sh)

```
NAME
      pandoc_latexwrapper - pandoc wrapper for converting to latex

USAGE
      pandoc_latexwrapper [-h] [pandoc's options] INPUTFILE(or stdin)

OPTION
      -h: Show this help message.
```

## [pdfocr](./pdfocr)

Convert a scanned pdf to the pdf file which contains the embedded
transparent texts generated by OCR engine 'tesseract'.

**Require**

* tesseract
    * [GitHub repository](https://github.com/tesseract-ocr/tesseract)
    * Install with `apt` command  
```
sudo apt-get install tesseract-ocr tesseract-ocr-jpn
```

* pdftk
* pdftoppm

**Usage**

```
pdfocr foo.pdf
```

**TODO**

* receive some options

## [presenmode.sh](./presenmode.sh)

xrandr wrapper for switching display at presentaion.

You may change these environment variables. (write and export in 'zshrc')

```
OUTPUT_DEV=eDP1
OUTPUT_RES=1920x1080
```

```
projector="VGA1"
projector_mode="1024x768"
```

```
NAME
      presenmode.sh - provide easy way to manage the monitors with xrandr.

USAGE
      presenmode.sh COMMAND [-d output] [-m mode] [-h]

COMMAND
      start: Start Presentation mode
      stop : Stop Presentaion mode

OPTION
      -d: Output device connecting (default: $projector)
      -m: Manually select the display resolution (default: $projector_mode)
      -h: Show this message and quit
```

## [presentation.sh](./presentation.sh)

impressive(presentation software) wrapper script.

## [progressbar](./progressbar)

progressbar - make progress bar easily

**Usage:**

```
progressbar n [ barchar_empty barchar_fill ]
```

(int `n`: 0 ~ 100) 

> [bash - How to add a progress bar to a shell script? - Stack Overflow](http://stackoverflow.com/questions/238073/how-to-add-a-progress-bar-to-a-shell-script)

## [proxy\_toggle.sh](./proxy_toggle.sh)

If you are in proxy network, you should manage your proxy setting.

This script enables you to toggle proxy setting by one command.

## [pydocpdf](./pydocpdf)

```
NAME
      pydocpdf - Create python module documentation with pdf format

SYNOPSYS
      pydocpdf ./proto.py

OPTION
      -h: Show this help.

DEPENDENCY
      * pydoc
      * wkhtmltopdf (installable by apt)

```

## [radiko\_rec.sh](./radiko_rec.sh)

Record the radiko progrom.

forked from [here](https://github.com/haru8/radiko_rec).

## [s](./s)

```
NAME
      s - Search from terminal

USAGE
      s [-h|-l] <search_provider> <search queries>

OPTIONS
      -h    Show help message
      -t    Set the browser to use (-g option is already enabled)
      -l    Show search providers list
      -g    Force search in GUI browser

ENVIRONMENT VARIABLE:
      $BROWSERCLI     browser used in terminal
      $BROWSER        GUI browser
```

## [screenshot\_select.sh](./screenshot_select.sh)

Take screenshot (select area by mouse dragging or click) and save it to daydir(%Y-%m-%d).

You may change the variable below.

```
rootdir=$HOME/Workspace/blog
```

>[ShellScript - スクリーンショットを撮って日付のディレクトリに連番で保存するスクリプト - Qiita](http://qiita.com/ssh0/items/2b4e7a4146cb2da01187)

## [screenshot.sh](./screenshot.sh)

Take screenshot (full window) and save it to daydir(%Y-%m-%d).

You may change the variable below.

```
rootdir=$HOME/Workspace/blog
```

>[ShellScript - スクリーンショットを撮って日付のディレクトリに連番で保存するスクリプト - Qiita](http://qiita.com/ssh0/items/2b4e7a4146cb2da01187)

## [sound\_volume\_change\_wrapper.sh](./sound_volume_change_wrapper.sh)

You should set a shortcut to the multimediakey(volume up/down/mute) to call this script.

You can also execute this command on terminal.

## [s\_provider](./s_provider)

s - Search from terminal

This file contains the list of the provides to search.

FORMAT:

```
 +--- Line that matches with '^# \"' is used for printing providers lists.
 |   +--- After ': ' parts is also used for printing providers lists.
 |   |                      +--- After the second ': ' is real comment.
 |   |                      |
# "A": Some description here: This field is ignored by completion.
A,url,{true|false}
|  |    |
|  |    +--- Open in GUI browser or not.
|  +--- Set the search providers url. Search query is placed in "%s".
+--- Alias for the provider.
```

* Commeting line is used by zsh completion function '_s'.  
See [here](../zshfiles/completions/_s).

EXAMPLE:

```
# "m": Google Map: Search with Google Map and open page in GUI browser.
m,https://www.google.com/maps/place/%s,true
```

## [start\_urxvtd.sh](./start_urxvtd.sh)

If there is no process of urxvtd (urxvt daemon), start urxvtd.

## [streamradio](./streamradio)

```
streamradio - remote control script with streamradio

SYNOPSYS
      streamradio start <URL>
      streamradio pause
      streamradio list [stations|current]
      streamradio quit
      streamradio [-h|--help] 
```

## [streamradio-daemon](./streamradio-daemon)

Streamradio daemon program

## [terminal-colors](./terminal-colors)

This file echoes a bunch of color codes to the 
terminal to demonstrate what's available.  Each 
line is the color code of one forground color,
out of 17 (default + 16 escapes), followed by a 
test use of that color on all nine background 
colors (default + 8 escapes).

>[http://tldp.org/HOWTO/Bash-Prompt-HOWTO/x329.html](http://tldp.org/HOWTO/Bash-Prompt-HOWTO/x329.html)

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

## [toggle\_compton.sh](./toggle_compton.sh)

I use composite mangager compton.

This script toggle enabling the composite manager.

## [toggle\_xcompmgr.sh](./toggle_xcompmgr.sh)

This script toggle enabling the composite manager xcompmgr.

I don't use xcompmgr because it's slightly buggy.

## [touchpad\_toggle.sh](./touchpad_toggle.sh)

toggle enabling the touchpad.

I often use this srcipt in my laptop. (also shortcut to it)

>[How to disable the touchpad? - Ask Ubuntu](http://askubuntu.com/questions/65951/how-to-disable-the-touchpad)

## [trackpoint\_toggle.sh](./trackpoint_toggle.sh)

Toggle trackpoint enable/disable (useful when you in Lenovo Thinkpad).

## [trello](./trello)

launch trello chrome-app from command line.

>[Trello External Window - Chrome Web Store](https://chrome.google.com/webstore/detail/trello-external-window/gkcknpgdmiigoagkcoglklgaagnpojed)

## [urxvt\_float.sh](./urxvt_float.sh)

urxvt with `urxvt_float` name.

For xmonad float window handling.

## [usage\_all](./usage_all)

```
NAME
      usage_all - Show all usage written in 'header' part of a script

SYNOPSYS
      usage_all <script_file_path>

DEPENDENCE
      * pandoc
      * w3m
```

## [wmatomp3\_converter.sh](./wmatomp3_converter.sh)

Converts wma to mp3 recursively. does not delete any static files, so 
cleanup and renaming is needed afterwards. 

**requirements:**

* [lame](http://lame.sourceforge.net/download.php)
* mplayer
    * `apt-get install mplayer` or download from [here](http://www.mplayerhq.hu/design7/dload.html)

## [ytdl](./ytdl)

```
NAME
      ytdl - wrapper script for youtube-dl.

USAGE
      ytdl [-h] [-A] [-L FILE] URL [youtube-dl options]

      You should place the URL *before* the youtube-dl's options.
      If you want to know youtube-dl's options, see manpage.

OPTION
      -A: Don't add the URL to list file
      -L: Set the list file to save URL (default file: '.list')
      -e: Edit the list file manually.
      -h: Show this help message
```

---

This page is generated automatically by [makebinreadme.sh](https://github.com/ssh0/dotfiles/blob/master/bin/makebinreadme.sh)

