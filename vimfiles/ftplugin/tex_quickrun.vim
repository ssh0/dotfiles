" LaTeX Quickrun
let g:quickrun_config['tex'] = {
\ 'command' : 'latexmk',
\ 'outputter' : 'error',
\ 'outputter/error/success' : 'message',
\ 'outputter/error/error' : 'quickfix',
\ 'cmdopt': '-pdfdvi',
\ 'exec': '%c %o %s',
\}

" 部分的に選択してコンパイル
" http://auewe.hatenablog.com/entry/2013/12/25/033416 を参考に
let g:quickrun_config.tmptex = {
\   'exec': [
\           'mv %s %a/tmptex.latex',
\           'latexmk -pdfdvi -pv -output-directory=%a %a/tmptex.latex',
\           ],
\
\   'outputter' : 'error',
\   'outputter/error/error' : 'quickfix',
\
\   'hook/eval/enable'   : 1,
\   'hook/eval/cd'       : "%s:r",
\
\   'hook/eval/template' : '\documentclass{jsarticle}'
\                         .'\usepackage[dvipdfmx]{graphicx, hyperref}'
\                         .'\usepackage{float}'
\                         .'\usepackage{amsmath,amssymb,amsthm,ascmac}'
\                         .'\allowdisplaybreaks[1]'
\                         .'\theoremstyle{definition}'
\                         .'\newtheorem{theorem}{定理}'
\                         .'\newtheorem*{theorem*}{定理}'
\                         .'\newtheorem{definition}[theorem]{定義}'
\                         .'\newtheorem*{definition*}{定義}'
\                         .'\begin{document}'
\                         .'%s'
\                         .'\end{document}',
\
\   'hook/sweep/files'   : [
\                          '%a/tmptex.latex',
\                          '%a/tmptex.out',
\                          '%a/tmptex.fdb_latexmk',
\                          '%a/tmptex.log',
\                          '%a/tmptex.aux',
\                          '%a/tmptex.dvi'
\                          ],
\}

vnoremap <silent><buffer> <Space>$  <ESC>:<C-u>
\let @x = expand("%:p:h:gs?\\\\?/?")<CR>
\gv:<C-u>QuickRun -mode v -type tmptex -args @x<CR>

nnoremap <silent><buffer> <Space>$  :<C-u>
\let @x = expand("%:p:h:gs?\\\\?/?")<CR>
\mx
\?begin.*align<CR>V
\/end.*align<CR>
\:<C-u>QuickRun -mode v -type tmptex -args @x<CR>
\`x

" QuickRun and view compile result quickly
nnoremap <silent><F5> :QuickRun<CR>

" set some useful macros
let @d='a\mathrm{}idl'
let @f='a\frac{}{}hh'
let @b='f(i\leftl%i\righthhhhh'
