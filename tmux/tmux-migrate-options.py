#!/usr/bin/env python
# vim: set fileencoding=utf-8
#
# @see https://qiita.com/TsutomuNakamura/items/663b8e456768f29e37ed
# curl -L https://gist.githubusercontent.com/tbutts/6abf7fb5b948c066bf180922fb37adcf/raw/198f744327a9924febdd11677f044a4ecd3f3c96/tmux-migrate-options.py > tmux-migrate-options.py
# USAGE:
# Back up your tmux old config, run the script and redirect stdout to your conf
# file. Example:
#
#   $ cp  ~/.tmux.conf  ~/.tmux.conf.orig
#   $ python ./tmux-migrate-options.py  ~/.tmux.conf.orig  >  ~/.tmux.conf
#
#
# PURPOSE:
# This script accepts the path to a tmux conf file to read, then combines the
# deprecated -fg, -bg, and -attr options into the new -style option, and
# prints the updated tmux conf to stdout. The deprecated options were flagged
# for removal in tmux v1.9, and then removed in tmux v2.9 years later.
#
# The script will place the new "-style" option at the location of the last
# matching prefix for that option family. This means if your config file had
# a triplet of "window-status-bg", "window-status-fg", and "window-status-attr"
# settings, they will be merged into one line at that location with the option
# "window-status-style bg=...,fg=...,<attr>", in that order.
#
# If your config file has duplicate settings for, say, -fg, they will all
# appear on the same -style option line, in the same order which should give
# the same effect as before.
#
# The parser used here is a naive regex which should be enough for most configs.
# There is *no effort* to handle tmux conditional lines or cases where you
# already have -style options as well as old -fg, -bg, -attr options.
# If you rely on those to set colors and styles, then you may want to avoid
# this script as it will break your config.
# ---
# ISC License (ISC)
#
# Copyright 2019 April | tbutts
#
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
# REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND
# FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
# INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
# LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
# OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
# PERFORMANCE OF THIS SOFTWARE.
#
from __future__ import print_function, unicode_literals
from io import open

import os
import re
import sys


if len(sys.argv) < 2:
    sys.exit("[ERR] specify path to tmux config file")

tmux_conf = sys.argv[1]

with open(tmux_conf, mode='r', encoding='utf-8') as tmux_file:
    content = tmux_file.readlines()

if not content:
    sys.exit("[ERR] tmux config file appears to be empty")

OPTION_PREFIXES=[
     "message-command-",
     "message-",
     "mode-",
     "pane-active-border-",
     "pane-border-",
     "status-left-",
     "status-right-",
     "status-",
     "window-active-",
     "window-status-activity-",
     "window-status-bell-",
     "window-status-current-",
     "window-status-last-",
     "window-status-",
     "window-",
]

SET_OPTION_RE=r"""
    ^\s*[^#]*                    # ignore comment lines
    (?P<set_option>set\S*\s+-g)  # set, setw, set-option, etc.
    \s+
    {prefix}                     # any of the above option strings
    (?P<style>fg|bg|attr)        # the style part name
    \s+
    (?P<value>\S+)               # color value, attribute (bold/dim/none/etc)
"""

for opt in OPTION_PREFIXES:
    option_matcher = re.compile(SET_OPTION_RE.format(prefix=opt), re.VERBOSE)

    set_cmd = ""  # track type of "set-option" command
    line_no = 0   # track last line number of any matching set-option* command
    settings = [] # track -fg, -bg, and -attr options

    # Going line-by-line from content, attempt a string match with the current 'opt' option family.
    # Use index-based iteration, so that 'content' can be modified while looping.
    i = 0
    while i < len(content):
        match = option_matcher.search(content[i])
        if match:
            re_groups = match.groupdict()
            set_cmd = re_groups["set_option"]
            style = re_groups["style"]
            value = re_groups["value"]

            if style in ["fg", "bg"]:
                settings.append("{}={}".format(style, value))
            else:
                # One of the -attr options (bold, dim, none, etc.)
                settings.append(value)
            line_no = i
            content.pop(i)
        else:
            i += 1

    if set_cmd:
        style_replacement_line = "{} {} {}{}".format(
                set_cmd,
                opt+"style",
                ",".join(settings),
                os.linesep)

        content.insert(line_no, style_replacement_line)

# Print the updated config to stdout
if sys.version_info.major > 2:
    print(''.join(content), end='')
else:
    import codecs
    codecs.getwriter('utf8')(sys.stdout).write(''.join(content))
