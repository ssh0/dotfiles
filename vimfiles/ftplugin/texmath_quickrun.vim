" LaTeX Quickrun (texmath)
let g:quickrun_config['texmath'] = {
\ 'runner' : 'vimproc',
\ 'command' : 'texmath',
\ 'outputter' : 'error',
\ 'outputter/error/success' : 'null',
\ 'outputter/error/error' : 'quickfix',
\ 'srcfile' : expand("%s"),
\ 'exec': '%c %s',
\}

augroup texmath_autocompile
  autocmd!
  autocmd BufWritePost,FileWritePost *.tex :QuickRun
  endif
augroup END
