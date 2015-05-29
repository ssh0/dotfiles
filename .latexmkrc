#!/usr/bin/perl
$latex = 'platex -kanji=utf-8 %S';
$dvipdf = 'dvipdfmx %S';
$bibtex = 'bibtex';
$pdf_mode = 3; # use dvipdf
$pdf_update_method = 2;
$pdf_previewer = "start mupdf %O %S";
# Prevent latexmk from removing PDF after typeset.
# $pvc_view_file_via_temporary = 0;
