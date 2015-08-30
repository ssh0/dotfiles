" markdown
let g:quickrun_config = {
\ 'markdown/update' : {
\   'runner' : 'vimproc',
\   'outputter' : 'error',
\   'outputter/error/error' : 'message',
\   'command' : 'mkdpreview',
\   'srcfile' : expand("%"),
\   'cmdopt' : '-u',
\   'exec': '%c %o %s',
\   },
\
\ 'markdown/visual' : {
\   'runner' : 'vimproc',
\   'outputter' : 'error',
\   'outputter/error/error' : 'message',
\   'command' : 'mkdpreview',
\   'cmdopt' : '-s -p',
\   'exec': '%c %o %s',
\   },
\}

let g:quickrun_config['markdown'] = {
\ 'runner' : 'vimproc',
\ 'outputter' : 'error',
\ 'outputter/error/error' : 'message',
\ 'command' : 'mkdpreview',
\ 'cmdopt' : '-s -p',
\ 'exec': '%c %o %s',
\}

" QuickRun and view compile result quickly
nnoremap <silent> <F5> :QuickRun -type markdown<CR>
vnoremap <silent> <F5> :QuickRun -type markdown/visual<CR>

augroup markdown_pandoc
  autocmd!
  autocmd BufWritePre *.md call s:auto_mkdir(expand('<afile>:p:h'))
  function! s:auto_mkdir(dir)
    if !isdirectory(a:dir)
      call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
  endfunction
  autocmd BufWritePost,FileWritePost *.md :QuickRun -type markdown/update
augroup END

