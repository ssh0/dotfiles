#!/usr/bin/perl
$latex = 'platex -kanji=utf-8 -synctex=1 %S';
$dvipdf = 'dvipdfmx %S';
$bibtex = 'pbibtex';
$pdf_mode = 3; # use dvipdf
$pdf_update_method = 2;
$pdf_previewer = "start mupdf %O %S";
$max_repeat       = 5;
# Prevent latexmk from removing PDF after typeset.
$pvc_view_file_via_temporary = 0;
