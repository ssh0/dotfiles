"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                _                                            "
"                         __   _(_)_ __ ___  _ __ ___                         "
"                         \ \ / / | '_ ` _ \| '__/ __|                        "
"                          \ V /| | | | | | | | | (__                         "
"                           \_/ |_|_| |_| |_|_|  \___|                        "
"                                                                             "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NOTE: NeoVim
" The config if NeoVim set it to default or don't work with nvim,
" comment out with '">>> '
"
" See :h vim_diff
"
" written by Shotaro Fujimoto (https://github.com/ssh0)
"------------------------------------------------------------------------------
" Initial Setting:                                                          {{{
"------------------------------------------------------------------------------

" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

" use <Space> for mapleader & localleader
let mapleader = "\<Space>"
let localleader = "\<Space>"

" encoding
scriptencoding utf8
set fileencoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis

"---------------------------------------------------------------------------}}}
" Load plugins:                                                             {{{
"------------------------------------------------------------------------------

source ~/.config/nvim/plug.vim

"---------------------------------------------------------------------------}}}
" Autocmd:                                                                  {{{
"------------------------------------------------------------------------------

" set title for currently viewing
" [tmux tabs with name of file open in vim - Stack Overflow]
" http://stackoverflow.com/questions/15123477/tmux-tabs-with-name-of-file-open-in-vim
if $TMUX != ""
  augroup titlesettings
    autocmd!
    autocmd BufEnter,InsertEnter * call system("tmux rename-window '(vim)" . expand("%:t") . "'")
    autocmd VimLeave * call system("tmux rename-window zsh")
    autocmd BufEnter * let &titlestring = ' ' . expand("%:t")
  augroup END
endif

augroup filetype
  autocmd!
  " markdown
  autocmd BufRead,BufNewFile *.{mkd,md} set filetype=markdown
  autocmd! FileType markdown hi! def link markdownItalic Normal
  autocmd FileType markdown set commentstring=<\!--\ %s\ -->
  " tex file (I always use latex)
  autocmd BufRead,BufNewFile *.tex set filetype=tex
  " bib file
  autocmd BufRead,BufNewFile *.bib set filetype=bib
  autocmd Filetype bib let &formatprg="bibclean"
  " python
  autocmd Filetype python let &formatprg="autopep8 -"
  autocmd FileType python setlocal completeopt-=preview
  " html
  let html_to_html  = "pandoc --from=html --to=markdown"
  let html_to_html .= " | pandoc --from=markdown --to=html"
  autocmd Filetype html let &formatprg=html_to_html
augroup END

augroup set_K_help
  autocmd!
  autocmd FileType vim setlocal keywordprg=:help
augroup END

augroup texmath
  autocmd!
  autocmd FileType texmath setlocal syntax=tex
augroup END

" Update shada file manually
augroup write_shada
  autocmd!
  autocmd VimLeavePre * wshada!
augroup END

"---------------------------------------------------------------------------}}}
" Set Options:                                                              {{{
"------------------------------------------------------------------------------
" System                                                                    {{{
" ------

" don't use backup or swap files
set nowritebackup nobackup noswapfile

" how many stock command history
set history=1000

" save information to ~/.viminfo
set viminfo='1000,<3000,f50,c,h

" use unnamed register (for outer programs)
set clipboard+=unnamedplus

" less timeoutlen
set timeout timeoutlen=400 ttimeoutlen=75

" disable 8-bit num
set nrformats-=octal

" use mouse
">>> if has('mouse')
">>>   set mouse=a
">>> endif

" set completion popup's height
set pumheight=10

" always split vertically when using vimdiff
set diffopt=vertical

" Indicates a fast terminal connection
">>> set ttyfast

set whichwrap=b,s,[,],<,>

" help language
set helplang=ja,en

" try to open under the cursor with `gx`
let g:netrw_browsex_viewer="xdg-open"

"                                                                           }}}
" Search                                                                    {{{
" ------

" case sensitive for search
set noignorecase nosmartcase
" Show matches while typing
">>> set incsearch
" highlighted search index
">>> set hlsearch
" wrapscan
set wrapscan

"                                                                           }}}
" Apearance                                                                 {{{
" ---------

" don't give the intro message
">>> set shortmess+=I

" don't redraw screen during macros
set lazyredraw

" no number line
set nonumber norelativenumber numberwidth=3

" autoindent
">>> set autoindent

" insert space instead of TAB
set expandtab shiftround
">>> set smarttab

" default tab width
set softtabstop=4 shiftwidth=4

" don't break a long line
set textwidth=0

" wrapped by 80 characters(PEP8)
set colorcolumn=80

" status line
set title noshowcmd

" highlight cursorline
set cursorline

" height of commandline
set cmdheight=1

" the last window will have a status line always
">>> set laststatus=2

" show wildmenu
set wildmenu

" show Tab and Space at end of the line
set list listchars=tab:▸\ ,trail:~

" showbreaks
set showbreak=\ ↪

" highlight mathched parenthesis
set showmatch matchtime=1

" folding
set foldmethod=marker foldcolumn=0

" characters to vertical separator
set fillchars=vert:\|

" modeline
set modeline

" disable the conceal function
let g:tex_conceal=''

set conceallevel=2

"                                                                           }}}
"---------------------------------------------------------------------------}}}
" Indent:                                                                   {{{
"------------------------------------------------------------------------------

autocmd FileType sh         setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab
autocmd FileType apache     setlocal shiftwidth=4 softtabstop=4 tabstop=4 expandtab
autocmd FileType css        setlocal shiftwidth=4 softtabstop=4 tabstop=4 noexpandtab
autocmd FileType diff       setlocal shiftwidth=4 softtabstop=4 tabstop=4 noexpandtab
autocmd FileType html       setlocal shiftwidth=4 softtabstop=4 tabstop=4 noexpandtab
autocmd FileType java       setlocal shiftwidth=4 softtabstop=4 tabstop=4 expandtab
autocmd FileType javascript setlocal shiftwidth=4 softtabstop=4 tabstop=4 noexpandtab
autocmd FileType ruby       setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab
autocmd FileType eruby      setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab
autocmd FileType sql        setlocal shiftwidth=4 softtabstop=4 tabstop=4 expandtab
autocmd FileType tex        setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab
autocmd FileType vim        setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab
autocmd FileType xml        setlocal shiftwidth=4 softtabstop=4 tabstop=4 noexpandtab
autocmd FileType yaml       setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab
autocmd FileType zsh        setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab
autocmd FileType coffee     setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab

"---------------------------------------------------------------------------}}}
" My function:                                                              {{{
"------------------------------------------------------------------------------

function! Markdown_h1()
  normal! V"ly"lpVr=
endfunction

function! Markdown_h2()
  normal! V"ly"lpVr-
endfunction

function! Markdown_h3()
  normal! I### 
endfunction

"---------------------------------------------------------------------------}}}
" Key Bindings:                                                             {{{
"------------------------------------------------------------------------------

" Escape by jj, kk
inoremap <silent> jj <ESC>
inoremap <silent> kk <ESC>

" Toggle relative number by <Space> + l
nnoremap <silent> <Leader>l :setlocal relativenumber! number!<CR>

" execute shell command written in a line
nnoremap Q !!$SHELL<CR>

" move in wrapped line by arrow key
nnoremap <Down> gj
nnoremap <Up> gk

" move from line head to line end
nnoremap h <Left>zv

" move from line end to line head
nnoremap l <Right>zv

" yank to line end
nnoremap Y y$

" cursor moved in insert mode
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

" move between windows by easy key mapping
nnoremap <silent> <C-h> :wincmd h<CR>
nnoremap <silent> <C-j> :wincmd j<CR>
nnoremap <silent> <C-k> :wincmd k<CR>
nnoremap <silent> <C-l> :wincmd l<CR>

" clear highlight by pressing Esc twice
nnoremap <silent> <ESC><ESC> :nohlsearch<CR>

" open the file in new tab
nnoremap gf <C-w>gf
" create the file and open in new tab
nnoremap gF :tabedit <C-r><C-f><CR>

" multi tab jamp
nnoremap <C-]> g<C-]>

" for Japanese IME mode"{{{
nnoremap あ a
nnoremap い i
nnoremap う u
nnoremap え e
nnoremap お o
nnoremap っd dd
nnoremap っy yy
nnoremap し” ci"
nnoremap し’ ci'
nnoremap せ ce
nnoremap で de
inoremap <silent> っj <ESC>

nnoremap っz zz
nnoremap ・ /
"}}}

" quote and bracket
inoremap {} {}<Left>
inoremap [] []<Left>
inoremap () ()<Left>
inoremap "" ""<Left>
inoremap ”” ””<Left>
inoremap '' ''<Left>
inoremap ’’ ’’<Left>
inoremap <> <><Left>
inoremap $$ $$<Left>

vnoremap < <gv
vnoremap > >gv

" source vimrc
map <Leader>so :source ~/.config/nvim/init.vim

" my functions
nnoremap <silent> <Leader>h1 :call Markdown_h1()<CR>
nnoremap <silent> <Leader>h2 :call Markdown_h2()<CR>
nnoremap <silent> <Leader>h3 :call Markdown_h3()<CR>

"---------------------------------------------------------------------------}}}
