" LaTeX Quickrun
let g:quickrun_config['tex'] = {
\ 'runner' : 'vimproc',
\ 'command' : 'latexmk_wrapper',
\ 'outputter' : 'error',
\ 'outputter/error/success' : 'null',
\ 'outputter/error/error' : 'quickfix',
\ 'srcfile' : expand("%s"),
\ 'exec': '%c %s %a %o',
\}

" 部分的に選択してコンパイル
" http://auewe.hatenablog.com/entry/2013/12/25/033416 を参考に
let g:quickrun_config.tmptex = {
\ 'runner' : 'vimproc',
\ 'exec': [
\         'mv %s %a/tmptex.latex',
\         'latexmk -pdfdvi -pv -output-directory=%a %a/tmptex.latex',
\         ],
\ 'args' : expand("%:p:h:gs?\\\\?/?"),
\ 'outputter' : 'error',
\ 'outputter/error/error' : 'quickfix',
\
\ 'hook/eval/enable' : 1,
\ 'hook/eval/cd' : "%s:r",
\
\ 'hook/eval/template' : '\documentclass{jsarticle}'
\                       .'\usepackage[dvipdfmx]{graphicx, hyperref}'
\                       .'\usepackage{float}'
\                       .'\usepackage{amsmath,amssymb,amsthm,ascmac,mathrsfs}'
\                       .'\allowdisplaybreaks[1]'
\                       .'\theoremstyle{definition}'
\                       .'\newtheorem{theorem}{定理}'
\                       .'\newtheorem*{theorem*}{定理}'
\                       .'\newtheorem{definition}[theorem]{定義}'
\                       .'\newtheorem*{definition*}{定義}'
\                       .'\renewcommand\vector[1]{\mbox{\boldmath{\(#1\)}}}'
\                       .'\begin{document}'
\                       .'%s'
\                       .'\end{document}',
\
\ 'hook/sweep/files' : [
\                      '%a/tmptex.aux',
\                      '%a/tmptex.dvi',
\                      '%a/tmptex.fdb_latexmk',
\                      '%a/tmptex.fls',
\                      '%a/tmptex.latex',
\                      '%a/tmptex.log',
\                      '%a/tmptex.out',
\                      ],
\}

vnoremap <silent><buffer> <F5> :QuickRun -mode v -type tmptex<CR>

" QuickRun and view compile result quickly (but don't preview pdf file)
nnoremap <silent><F5> :QuickRun<CR>

augroup latex_autocompile
  autocmd!
  if g:quickrun_user_tex_autorun != 0
    autocmd BufWritePost,FileWritePost *.tex :QuickRun
  endif
augroup END
