" for bib file
let g:quickrun_config.bib = {
\ 'command' : 'bib2html_wrapper.sh',
\ 'srcfile' : expand("%"),
\ 'outputter' : 'error',
\ 'outputter/error/success' : 'null',
\ 'outputter/error/error' : 'quickfix',
\ 'cmdopt': '-o '. expand('%S:p:r.html'),
\ 'exec': '%c %o %a %s',
\}

autocmd BufWritePost,FileWritePost *.bib QuickRun -type bib
