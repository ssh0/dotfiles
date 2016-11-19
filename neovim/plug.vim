let s:plug_dir = expand('~/.config/nvim/plugged')
let s:plug_source = expand('~/.config/nvim/autoload/plug.vim')

if !filereadable(s:plug_source)
  execute '! curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin(s:plug_dir)

Plug 'surround.vim'
Plug 'tpope/vim-commentary'
Plug 'Shougo/unite.vim'
nnoremap <silent> <Leader>uy :<C-u>Unite history/yank<CR>
nnoremap <silent> <Leader>ub :<C-u>Unite buffer<CR>
nnoremap <silent> <Leader>uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> <Leader>ur :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> <Leader>uu :<C-u>Unite file_mru buffer<CR>

Plug 'Shougo/vimfiler.vim'
nnoremap <silent> <Leader>e :VimFilerBufferDir -buffer-name=explorer -split<CR>

Plug 'Shougo/vimproc', {'do': 'make'}
Plug 'lambdalisue/vim-gita'
Plug 'ctrlpvim/ctrlp.vim'
if executable('ag')
  let g:ctrlp_user_command='ag %s -i --nocolor --nogroup -g ""'
endif
nnoremap <Leader>oo :CtrlP<CR>
nnoremap <Leader>om :CtrlPMixed<CR>
nnoremap <Leader>or :CtrlPMRUFiles<CR>

Plug 'ervandew/supertab'
Plug 'tacroe/unite-mark'
Plug 'kshenoy/vim-signature'
let g:unite_source_mark_marks =
      \   "abcdefghijklmnopqrstuvwxyz"
      \ . "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
      \ . "0123456789.'`^<>[]{}()\""

nnoremap <silent> `` :Unite mark<CR>
nnoremap <silent> '' :Unite mark<CR>

let g:SignatureMarkTextHLDynamic = 1
let g:SignatureMarkTextHL = "SignColumn"

Plug 'LeafCage/foldCC'
set foldtext=FoldCCtext()

Plug 'lilydjwg/colorizer'
Plug 'tyru/open-browser.vim'
" {{{
Plug 'itchyny/lightline.vim'
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
  return winwidth(0) > 80 ? (
        \ fname == 'ControlP' ? g:lightline.ctrlp_item :
        \ fname == '__Tagbar__' ? g:lightline.fname :
        \ fname =~ '__Gundo\|NERD_tree' ? '' :
        \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
        \ &ft == 'unite' ? unite#get_status_string() :
        \ &ft == 'vimshell' ? vimshell#get_status_string() :
        \ ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ ('' != fname ? (strlen(fname) < 40 ? fname : '') : '[No Name]') .
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
"}}}

Plug 'ssh0/easyreading.vim'
Plug 'thinca/vim-quickrun'
let g:quickrun_config = {}
let g:quickrun_no_default_key_mapping = 0

if $USER == "ssh0"
  let g:quickrun_user_tex_autorun = 0
else
  let g:quickrun_user_tex_autorun = 1
endif

Plug 'thinca/vim-template'
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

Plug 'thinca/vim-splash'
let g:splash#path = expand('~/.splash-vim.txt')

Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toc_autofit = 1
let g:vim_markdown_folding_level = 2
" let g:vim_markdown_folding_style_pythonic = 1

" Plug 'tpope/vim-markdown', {'for': 'markdown'}
" Plug 'tyru/markdown-codehl-onthefly.vim', {'for': 'markdown'}
" Plug 'drmingdrmer/vim-syntax-markdown', {'for': 'markdown'}

Plug 'lervag/vimtex', {'for': 'tex'}
let g:vimtex_fold_envs = 1
let g:vimtex_view_general_viewer = 'mupdf'

Plug 'davidhalter/jedi-vim', {'for': 'python'}
let g:jedi#use_splits_not_buffers = "top"
let g:jedi#popup_on_dot = 1
let g:jedi#popup_select_first = 1

Plug 'bpearson/vim-phpcs', {'for': ['php', 'javascript', 'css']}

Plug 'mattn/emmet-vim', {'for': ['html', 'css']}
let g:user_emmet_mode='inv'

Plug 'tmhedberg/SimpylFold', {'for': 'python'}
Plug 'nvie/vim-flake8', {'for': 'python'}
Plug 'hynek/vim-python-pep8-indent', {'for': 'python'}
Plug 'lambdalisue/vim-gista'
let g:gista#github_user = 'ssh0'
let g:gista#update_on_write = 1

Plug 'mattn/webapi-vim'
Plug 'moznion/hateblo.vim'
Plug 'mattn/googlesuggest-complete-vim'
" Plug 'Lokaltog/powerline-fontpatcher'
Plug 'ssh0/easy-reading.vim'
Plug 'rking/ag.vim'

call plug#end()


" Required:
filetype plugin indent on
syntax on
colorscheme easy-reading

"---------------------------------------------------------------------------}}}
