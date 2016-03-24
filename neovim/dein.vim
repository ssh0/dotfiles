" dein.vim:                                                                 {{{
"------------------------------------------------------------------------------

let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if !isdirectory(s:dein_repo_dir)
  execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
endif

execute 'set runtimepath^=' . s:dein_repo_dir

" Required:
call dein#begin(s:dein_dir)

let s:toml = '~/.config/nvim/dein.toml'
let s:lazy_toml = '~/.config/nvim/dein_lazy.toml'

if dein#load_cache([expand('<sfile>', s:toml, s:lazy_toml)])
  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})
  call dein#save_cache()
endif

call dein#end()

if dein#check_install(['vimproc'])
  call dein#install(['vimproc'])
endif

if dein#check_install()
  call dein#install()
endif

nnoremap <silent> <Leader>uy :<C-u>Unite history/yank<CR>
nnoremap <silent> <Leader>ub :<C-u>Unite buffer<CR>
nnoremap <silent> <Leader>uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> <Leader>ur :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> <Leader>uu :<C-u>Unite file_mru buffer<CR>

nnoremap <silent> <Leader>e :VimFilerBufferDir -buffer-name=explorer -split
"
if executable('ag')
  let g:ctrlp_user_command='ag %s -i --nocolor --nogroup -g ""'
endif
nnoremap <Leader>oo :CtrlP<CR>
nnoremap <Leader>om :CtrlPMixed<CR>
nnoremap <Leader>or :CtrlPMRUFiles<CR>

let g:unite_source_mark_marks =
      \   "abcdefghijklmnopqrstuvwxyz"
      \ . "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
      \ . "0123456789.'`^<>[]{}()\""

nnoremap <silent> `` :Unite mark<CR>
nnoremap <silent> '' :Unite mark<CR>

let g:SignatureMartTextHLDynamic = 1
let g:SignatureMarkTextHL = "'SignColumn'"

set foldtext=FoldCCtext()

let g:lightline = {
      \ 'colorscheme': 'easyreading',
      \ 'mode_map': { 'c': 'NORMAL' },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'filename' ], ['ctrlpmark'] ],
      \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'tabline': {
      \   'left': [
      \     [ 'tabs' ],
      \   ],
      \   'right': [
      \     [ 'close' ],
      \     [ 'git_branch', 'git_traffic', 'git_status', 'cwd' ],
      \   ],
      \ },
      \ 'component_function': {
      \   'modified': 'MyModified',
      \   'readonly': 'MyReadonly',
      \   'git_branch': 'g:lightline.my.git_branch',
      \   'git_traffic': 'g:lightline.my.git_traffic',
      \   'git_status': 'g:lightline.my.git_status',
      \   'filename': 'MyFilename',
      \   'fileformat': 'MyFileformat',
      \   'filetype': 'MyFiletype',
      \   'fileencoding': 'MyFileencoding',
      \   'mode': 'MyMode',
      \   'ctrlpmark': 'CtrlPMark',
      \ },
      \ 'component_expand': {
      \   'syntastic': 'SyntasticStatuslineFlag',
      \ },
      \ 'component_type': {
      \   'syntastic': 'error',
      \ },
      \ 'separator': { 'left': '▒', 'right': '▒' },
      \ 'subseparator': { 'left': '│', 'right': '│' },
      \ 'tabline_separator': { 'left': '', 'right': '▒' },
      \ 'tabline_subseparator': { 'left': '│', 'right': '│' },
      \ }

function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '' : ''
endfunction

function! MyFilename()
  let fname = expand('%:t')
  return winwidth(0) > 40 ? (
        \ fname == 'ControlP' ? g:lightline.ctrlp_item :
        \ fname == '__Tagbar__' ? g:lightline.fname :
        \ fname =~ '__Gundo\|NERD_tree' ? '' :
        \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
        \ &ft == 'unite' ? unite#get_status_string() :
        \ &ft == 'vimshell' ? vimshell#get_status_string() :
        \ ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ ('' != fname ? (strlen(fname) < 20 ? fname : '') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
        \ ) : ''
endfunction

" gita (steal from vimgita README)
let g:lightline.my = {}
function! g:lightline.my.git_branch() " 
  return winwidth(0) > 70 ? gita#statusline#preset('branch') : ''
endfunction

function! g:lightline.my.git_traffic() " 
  return winwidth(0) > 70 ? gita#statusline#preset('traffic') : ''
endfunction

function! g:lightline.my.git_status() " 
  return winwidth(0) > 70 ? gita#statusline#preset('status') : ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == 'ControlP' ? 'CtrlP' :
        \ fname == '__Gundo__' ? 'Gundo' :
        \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ &ft == 'unite' ? 'Unite' :
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ &ft == 'vimshell' ? 'VimShell' :
        \ winwidth(0) > 30 ? lightline#mode() : ''
endfunction

function! CtrlPMark()
  if expand('%:t') =~ 'ControlP'
    call lightline#link('iR'[g:lightline.ctrlp_regex])
    return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
          \ , g:lightline.ctrlp_next], 0)
  else
    return ''
  endif
endfunction

let g:ctrlp_status_func = {
      \ 'main': 'CtrlPStatusFunc_1',
      \ 'prog': 'CtrlPStatusFunc_2',
      \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_regex = a:regex
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
  return lightline#statusline(0)
endfunction

augroup AutoSyntastic
  autocmd!
  autocmd BufWritePost *.c,*.cpp call s:syntastic()
augroup END
function! s:syntastic()
  SyntasticCheck
  call lightline#update()
endfunction

let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0


let g:quickrun_config = {}
let g:quickrun_no_default_key_mapping = 0

if $USER == "ssh0"
  let g:quickrun_user_tex_autorun = 0
else
  let g:quickrun_user_tex_autorun = 1
endif

augroup template
  autocmd!
  " inside <%= %> is estimated by vim and expanded automatically
  autocmd User plugin-template-loaded
        \ silent %s/<%=\(.\{-}\)%>/\=eval(submatch(1))/ge
  " if you write like below, the string is expanded to date.
  " <%= strftime('%Y-%m-%d') %>

  " move the cursor to <+CURSOR+>
  autocmd User plugin-template-loaded
        \    if search('<+CURSOR+>')
        \  |   execute 'normal! "_da>'
        \  | endif
augroup END

let g:splash#path = expand('~/.splash-vim.txt')

let g:vimtex_fold_envs = 1
let g:vimtex_view_general_viewer = 'mupdf'

" jedi complete
" let g:jedi#popup_on_dot = 1
" let g:jedi#popup_select_first = 1
"
let g:gista#github_user = 'ssh0'
let g:gista#update_on_write = 1

" Required:
filetype plugin indent on
syntax on
colorscheme easy-reading

"---------------------------------------------------------------------------}}}
