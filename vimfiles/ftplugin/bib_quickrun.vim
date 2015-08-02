" for bib file
let g:quickrun_config.bib = {
\ 'runner' : 'vimproc',
\ 'command' : 'bib2html_wrapper.sh',
\ 'srcfile' : expand("%:p"),
\ 'outputter' : 'error',
\ 'outputter/error/success' : 'null',
\ 'outputter/error/error' : 'quickfix',
\ 'exec': '%c %o %s',
\}

autocmd BufWritePost,FileWritePost *.bib QuickRun -type bib
