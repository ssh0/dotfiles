" Initial Setting"{{{
" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

if has('vim_starting')
    if &compatible
        set nocompatible
    endif

    " Required:
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
"}}}

" Plugin Manager NeoBundle"{{{
" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: Yout don't set neobundle setting in .gvimrc!
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler.vim'
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'kannokanno/previm'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'tyru/caw.vim.git'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'alpaca-tc/alpaca_powertabline'
NeoBundle 'Lokaltog/powerline', { 'rtp' : 'powerline/bindings/vim'}
NeoBundle 'Lokaltog/powerline-fontpatcher'
NeoBundle 'LaTeX-Box-Team/LaTeX-Box'
NeoBundle 'davidhalter/jedi-vim'
NeoBundle 'ujihisa/neco-look', {
    \ 'depends': [
    \   'Shougo/neocomplcache.vim',
    \]}
NeoBundle 'lambdalisue/vim-gista', {
    \ 'depends': [
    \   'Shougo/unite.vim',
    \   'tyru/open-browser.vim',
    \]}
NeoBundle 'suan/vim-instant-markdown'
NeoBundle 'klen/python-mode'
NeoBundleLazy 'hynek/vim-python-pep8-indent', {
    \ "autoload": {"insert": 1, "filetype": ["python", "python3", "djangohtml"]}}

call neobundle#end()

" If there are uninstalled bundles dfound on startup,
" this will conveiently prompt you to install them.
NeoBundleCheck
"}}}

" Required:"{{{
filetype plugin indent on"}}}

" Set Options"{{{

" 行番号を表示
set number

" マウスを有効にする
if has('mouse')
    set mouse=a
endif

"カーソルキーで行末／行頭の移動可能に設定
set whichwrap=b,s,[,],<,>

"Tab幅を設定
set softtabstop=4
set shiftwidth=4
set expandtab

"自動的にインデントする
set autoindent
set smartindent

" 入力されているテキストの最大幅
set textwidth=0

" cursor line をハイライト
set cursorline

"タイトルを表示
set title

"コマンドラインの高さ (gvimはgvimrcで指定)
set cmdheight=1
set laststatus=2

"コマンドをステータス行に表示
set showcmd

"Tab、行末の半角スペースを明示的に表示する
set list
set listchars=tab:^\ ,trail:~

" 対応する括弧を表示
set showmatch
set matchtime=1

" ハイライトを有効にする
if &t_Co > 2 || has('gui_running')
    syntax on
endif

" 検索結果のハイライト
set hlsearch

" folding
set fdm=marker " zf(def) zd(delete) zo(open) zc(close)
set foldcolumn=1

" バックアップファイルを作成しない
set nowritebackup
set nobackup
set noswapfile

" 無名クリップボードを使う(他のアプリケーションと連動)
set clipboard=unnamedplus,autoselect

" 80文字で折り返すようにする(PEP8)
set colorcolumn=80

" 補完メニューの高さを指定する
set pumheight=10

" スクロール送りを開始する前後の行数を指定
set scrolloff=5

" Vimdiffで毎回左右分割する
set diffopt=vertical

"}}}

" Set highlight"{{{
" To show current color scheme by
" ':so $VIMRUNTIME/syntax/hitest.vim'
highlight ColorColumn ctermbg=233
highlight CursorColumn ctermbg=0
highlight CursorLine cterm=None
highlight CursorLineNr ctermbg=15 ctermfg=16
highlight Error ctermfg=0 ctermbg=1 guifg=White guibg=Red
highlight ErrorMsg ctermfg=0 ctermbg=1 guifg=White guibg=Red
highlight FoldColumn ctermbg=None ctermfg=12
highlight Folded ctermbg=237 ctermfg=12
highlight LineNr ctermbg=None ctermfg=256
highlight MatchParen term=None ctermfg=None ctermbg=239
highlight NonText ctermfg=0 guifg=Bg
highlight Normal ctermbg=None
highlight Search ctermfg=0 guifg=0
highlight Statement ctermfg=3 ctermbg=None
highlight VertSplit term=None cterm=None ctermfg=250 ctermbg=250
highlight Visual ctermbg=0

autocmd! FileType markdown hi! def link markdownItalic Normal
"}}}

" Key Bindings"{{{
" jjでエスケープ
inoremap <silent> jj <ESC>

" gj, gkの代わりに矢印キーでなら行内を動けるように
nnoremap <Down> gj
nnoremap <Up>   gk

" 行頭から前の行の最後に移動
nnoremap h <Left>zv

" 行末から次の行の先頭に移動
nnoremap l <Right>zv

" 行末までヤンク
nnoremap Y y$

" craeate new tab
nnoremap <silent> <C-t> :tabnew<CR>

" num increment :help CTRL-A, :help CTRL-X
nnoremap + <C-a>
nnoremap - <C-x>

" 入力モードで矢印キーでカーソル移動
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

" comment out / off
nmap <Leader>c <Plug>(caw:i:toggle)
vmap <Leader>c <Plug>(caw:i:toggle)

" ハイライトの取り消し ESC2回押し
nnoremap <ESC><ESC> :nohlsearch<CR>

"}}}

" Plugin option settings"{{{

" Gista
let g:gista#github_user = 'ssh0'
let g:gista#update_on_write = 1

""" markdown {{{
set syntax=markdown
autocmd BufRead,BufNewFile *.mkd set filetype=markdown
autocmd BufRead,BufNewFile *.md set filetype=markdown

" Disable instant markdown autostart
let g:instant_markdown_autostart = 0
" You can manually activate by cmd `:InstantMarkdownPreview`

" folding
let g:vim_markdown_folding_disabled=1
" Need: kannokanno/previm
" nnoremap <silent> <C-p> :PrevimOpen<CR>
"
" Need: vim-quickrun open-browser.vim, pandoc
let g:quickrun_config = {}
let g:quickrun_config['markdown'] = {
    \ 'outputter': 'browser',
    \ 'args': '--mathjax'
    \ }

"}}}

" jedi completeplt
let g:jedi#auto_vim_configuration = 0

" LaTeX Quickrun
let g:quickrun_config.tex = {'command' : 'mkpdf'}

" for open-browser plugin
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)
"}}}

" Add ranger as a file chooser in vim"{{{
"
" If you add this code to the .vimrc, ranger can be started using the command
" ":RangerChooser" or the keybinding "<leader>r".  Once you select one or more
" files, press enter and ranger will quit again and vim will open the selected
" files.
"
function! RangeChooser() "{{{
    let temp = tempname()
    " The option "--choosefiles" was added in ranger 1.5.1. Use the next line
    " with ranger 1.4.2 through 1.5.0 instead.
    "exec 'silent !ranger --choosefile=' . shellescape(temp)
    exec 'silent !ranger --choosefiles=' . shellescape(temp)
    if !filereadable(temp)
        redraw!
        " Nothing to read.
        return
    endif
    let names = readfile(temp)
    if empty(names)
        redraw!
        " Nothing to open.
        return
    endif
    " Edit the first item.
    exec 'edit ' . fnameescape(names[0])
    " Add any remaning items to the arg list/buffer list.
    for name in names[1:]
        exec 'argadd ' . fnameescape(name)
    endfor
    redraw!
endfunction "}}}
command! -bar RangerChooser call RangeChooser()
" Space + rでrangerを起動
nnoremap <Space>r :<C-U>RangerChooser<CR>
"}}}

" Load Template file"{{{
autocmd BufNewFile *.py 0r $HOME/Templates/Python.py
autocmd BufNewFile *.sh 0r $HOME/Templates/shell_script.sh
autocmd BufNewFile *.md 0r $HOME/Templates/markdown.mkd
autocmd BufNewFile *.mkd 0r $HOME/Templates/markdown.mkd
"}}}
