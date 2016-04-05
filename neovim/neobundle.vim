" NeoBundle:                                                                {{{
"------------------------------------------------------------------------------

if has('vim_starting')
  ">>> if &compatible
  ">>>   set nocompatible
  ">>> endif

  " Required:
  set runtimepath+=~/.config/nvim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.config/nvim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!

" surround.vim                                                              {{{
NeoBundle 'surround.vim'
"                                                                           }}}
" tpope/vim-commentary                                                      {{{
NeoBundle 'tpope/vim-commentary'
"                                                                           }}}
" Shougo/unite.vim                                                          {{{
NeoBundleLazy 'Shougo/unite.vim', {
      \ 'autoload': {
      \     'commands': ['Unite'],
      \     'function_prefix': 'Unite'
      \     },
      \ }

let s:hooks = neobundle#get_hooks('unite.vim')
function! s:hooks.on_source(bundle)
  let g:unite_enable_start_insert=1
  let g:unite_source_history_yank_enable =1
  let g:unite_source_file_mru_limit = 200
endfunction
unlet s:hooks

nnoremap <silent> <Leader>uy :<C-u>Unite history/yank<CR>
nnoremap <silent> <Leader>ub :<C-u>Unite buffer<CR>
nnoremap <silent> <Leader>uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> <Leader>ur :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> <Leader>uu :<C-u>Unite file_mru buffer<CR>
"                                                                           }}}
" Shougo/vimfiler.vim                                                       {{{
NeoBundleLazy 'Shougo/vimfiler.vim', {
\   'depends': ["Shougo/unite.vim"],
\   'autoload': {
\       'commands': [ "VimFilerTab", "VimFiler", "VimFilerExplorer", "VimFilerBufferDir" ],
\       'mappings': ['<Plug>(vimfiler_switch)'],
\       'explorer': 1
\   }
\}
nnoremap <silent> <Leader>e :VimFilerBufferDir -buffer-name=explorer -split
      \ -simple -winwidth=35 -toggle -no-quit<CR>
"                                                                           }}}
" Shougo/vimproc                                                            {{{
NeoBundle 'Shougo/vimproc', {
      \ 'build': {
      \     'windows': 'tools\\update-dll-mingw',
      \     'cygwin': 'make -f make_cygwin.mak',
      \     'mac': 'make -f make_mac.mak',
      \     'linux': 'make',
      \     'unix': 'gmake',
      \    },
      \ }
"                                                                           }}}
" lambdalisue/vim-gita                                                      {{{
NeoBundleLazy 'lambdalisue/vim-gita', {
      \ 'autoload': {
      \   'commands': ['Gita'],
      \    },
      \ }
"                                                                           }}}
" rking/ag                                                                  {{{
if executable('ag')
  NeoBundle 'rking/ag.vim'
endif
"                                                                           }}}
" ctrlpvim/ctrlp.vim                                                        {{{
NeoBundle 'ctrlpvim/ctrlp.vim'
if executable('ag')
  let g:ctrlp_user_command='ag %s -i --nocolor --nogroup -g ""'
endif
nnoremap <Leader>oo :CtrlP<CR>
nnoremap <Leader>om :CtrlPMixed<CR>
nnoremap <Leader>or :CtrlPMRUFiles<CR>
" Once CtrlP is open:
" * Press `<F5>` to purge the cache for the current directory to get new  
"   files, remove deleted files and apply new ignore options.
" * Press `<c-f>` and `<c-b>` to cycle between modes.
" * Press `<c-d>` to switch to filename only search instead of full path.
" * Press `<c-r>` to switch to regexp mode.
" * Use `<c-j>`, `<c-k>` or the arrow keys to navigate the result list.
" * Use `<c-t>` or `<c-v>`, `<c-x>` to open the selected entry in a new  
"   tab or in a new split.
" * Use `<c-n>`, `<c-p>` to select the next/previous string in the  
"   prompt's history.
" * Use `<c-y>` to create a new file and its parent directories.
" * Use `<c-z>` to mark/unmark multiple files and `<c-o>` to open them.
"                                                                           }}}
" ervandew/supertab                                                         {{{
NeoBundle 'ervandew/supertab'
"                                                                           }}}
" ujihisa/neco-look                                                         {{{
" NeoBundle 'ujihisa/neco-look', {
"       \ 'depends': ['Shougo/neocomplcache.vim']
"       \ }
"                                                                           }}}
" tacroe/unite-mark                                                         {{{
NeoBundleLazy 'tacroe/unite-mark', {
      \ 'autoload': {'commands': ['Unite']},
      \ }

let s:hooks = neobundle#get_hooks("unite-mark")
function! s:hooks.on_source(bundle)
  let g:unite_source_mark_marks =
        \   "abcdefghijklmnopqrstuvwxyz"
        \ . "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        \ . "0123456789.'`^<>[]{}()\""
endfunction
unlet s:hooks

" key bind: `` or ''
nnoremap <silent> `` :Unite mark<CR>
nnoremap <silent> '' :Unite mark<CR>
"                                                                           }}}
" kshenoy/vim-signature                                                     {{{
NeoBundle 'kshenoy/vim-signature'
" Highlight signs of marks dynamically based upon state indicated by
" vim-gitgutter or vim-signify
let g:SignatureMartTextHLDynamic = 1
let g:SignatureMarkTextHL = "'SignColumn'"
"                                                                           }}}
" LeafCage/FoldCC                                                           {{{
NeoBundle 'LeafCage/foldCC'
set foldtext=FoldCCtext()
"                                                                           }}}
" Yggdroot/indentLine                                                       {{{
" NeoBundle 'Yggdroot/indentLine'
" let g:indentLine_color_term = 239
" let g:indentLine_char = '│'
"                                                                           }}}
" lilydjwg/colorizer                                                        {{{
NeoBundle 'lilydjwg/colorizer'
"                                                                           }}}
" tyru/open-browser                                                         {{{
NeoBundleLazy 'tyru/open-browser.vim', {
      \ 'autoload': {
      \     'functions': 'OpenBrowser',
      \     'commands': ['OpenBrowser', 'OpenBrowserSearch'],
      \     'mappings': '<Plug>(openbrowser-smart-search)'
      \     },
      \ }

"                                                                           }}}
" itchyny/lightline.vim                                                     {{{
NeoBundle 'itchyny/lightline.vim'
" my color scheme for lightline
NeoBundle 'ssh0/easyreading.vim'
" Project directory:
" ($HOME/.vim/bundle/easyreading.vim/autoload/lightline/colorscheme/easyreading.vim)
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

"                                                                           }}}
" thinca/vim-quickrun                                                       {{{
NeoBundle 'thinca/vim-quickrun'

let g:quickrun_config = {}
let g:quickrun_no_default_key_mapping = 0

if $USER == "ssh0"
  let g:quickrun_user_tex_autorun = 0
else
  let g:quickrun_user_tex_autorun = 1
endif

"                                                                           }}}
" thinca/vim-template                                                       {{{
NeoBundle 'thinca/vim-template'
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
"                                                                           }}}
" thinca/vim-splash                                                         {{{
NeoBundle 'thinca/vim-splash'
let g:splash#path = expand('~/.splash-vim.txt')
"                                                                           }}}
" tpope/vim-markdown                                                        {{{
NeoBundle 'tpope/vim-markdown'
"                                                                           }}}
" tyru/markdown-codehl-onthefly.vim                                         {{{
NeoBundle 'tyru/markdown-codehl-onthefly.vim'
"                                                                           }}}
" rcmdnk/vim-markdown                                                       {{{
" NeoBundle 'rcmdnk/vim-markdown', {
"       \ 'depends': ['godlygeek/tabular'],
"       \ }

" " Enable folding
" let g:vim_markdown_folding_disabled = 0
" " Disable Default Key Mapping
" let g:vim_markdown_no_default_key_mappings = 1
" " LaTeX math
" let g:vim_markdown_math = 1
"                                                                           }}}
" joker1007/vim-markdown-quote-syntax                                       {{{
">>> NeoBundle 'joker1007/vim-markdown-quote-syntax'
">>> Don't work with markdown
"                                                                           }}}
" lervag/vimtex                                                             {{{
NeoBundle 'lervag/vimtex'
let g:vimtex_fold_envs = 1
let g:vimtex_view_general_viewer = 'mupdf'
"                                                                           }}}
" davidhalter/jedi-vim                                                      {{{
" for python
NeoBundle 'davidhalter/jedi-vim'
" jedi complete
let g:jedi#popup_on_dot = 1
let g:jedi#popup_select_first = 1
"                                                                           }}}
" SimpylFold.vim                                                            {{{
NeoBundle 'tmhedberg/SimpylFold'
"                                                                           }}}
" nvie/vim-flake8                                                           {{{
" Press <F7> to run flake8
NeoBundle 'nvie/vim-flake8'
"                                                                           }}}
" hynek/vim-python-pep8-indent                                              {{{
NeoBundleLazy 'hynek/vim-python-pep8-indent', {
      \ 'autoload': {
      \     'insert': 1,
      \     'filetype': ['python', 'python3', 'djangohtml']
      \     }
      \ }
"                                                                           }}}
" lambdalisue/vim-gista                                                     {{{
" easily sent a gista
NeoBundle 'lambdalisue/vim-gista', {
      \ 'depends': [
      \     'Shougo/unite.vim',
      \     'tyru/open-browser.vim',
      \     ]
      \ }
let g:gista#github_user = 'ssh0'
let g:gista#update_on_write = 1
"                                                                           }}}
" moznion/hateblo                                                           {{{
" provide some funtions of Hatena Blog by using AtomPub API
NeoBundle 'moznion/hateblo.vim', {
      \ 'depends': ['mattn/webapi-vim', 'Shougo/unite.vim'],
      \ }
" config file is in ~/.hateblo.vim
" (You should create manually. See the project's README.)
"                                                                           }}}
" googlesuggest-complete-vim                                                {{{
" set complete function from googlesuggest
" Require:
"   set completefunc=googlesuggest#Complete
NeoBundle 'mattn/googlesuggest-complete-vim'
"                                                                           }}}
" Lolaltog/powerline-fontpatcher                                            {{{
NeoBundle 'Lokaltog/powerline-fontpatcher'
"                                                                           }}}
" ssh0/easy-reading.vim                                                     {{{
NeoBundle 'ssh0/easy-reading.vim'
" It's my vim's whole color theme.
" Project directory:
" ($HOME/.vim/bundle/easy-reading.vim/colors/easy-reading.vim)
"                                                                           }}}

call neobundle#end()

" If there are uninstalled bundles dfound on startup,
" this will conveiently prompt you to install them.
NeoBundleCheck

" Required:
filetype plugin indent on
syntax on
colorscheme easy-reading

"---------------------------------------------------------------------------}}}
