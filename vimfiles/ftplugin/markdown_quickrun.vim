" markdown
let g:quickrun_config = {
\ 'markdown/normal' : {
\   'outputter' : 'error',
\   'outputter/error/error' : 'message',
\   'command' : 'mkdpreview',
\   'srcfile': expand("%"),
\   'cmdopt' : '-s',
\   'exec': '%c %o %s',
\   },
\
\ 'markdown/visual' : {
\   'outputter' : 'error',
\   'outputter/error/error' : 'message',
\   'command' : 'mkdpreview',
\   'cmdopt' : '-p',
\   'exec': '%c %o %s',
\   },
\}

let g:quickrun_config['markdown'] = {
\ 'outputter' : 'error',
\ 'outputter/error/error' : 'message',
\ 'command' : 'mkdpreview',
\ 'srcfile': expand("%"),
\ 'cmdopt' : '-s -p',
\ 'exec': '%c %o %s',
\}



" QuickRun and view compile result quickly
nnoremap <F5> :QuickRun markdown/normal<CR>
vnoremap <F5> :QuickRun markdown/visual<CR>
