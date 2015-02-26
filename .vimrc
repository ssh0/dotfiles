" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

if has('vim_starting')
    if &compatible
        set nocompatible
    endif

    " Required:
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: Yout don't set neobundle setting in .gvimrc!
NeoBundle 'Shougo/unite.vim'
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'kannokanno/previm'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'alpaca-tc/alpaca_powertabline'
NeoBundle 'Lokaltog/powerline', { 'rtp' : 'powerline/bindings/vim'}
NeoBundle 'Lokaltog/powerline-fontpatcher'
NeoBundle 'LaTeX-Box-Team/LaTeX-Box'
NeoBundle 'lambdalisue/vim-gista', {
    \ 'depends': [
    \   'Shougo/unite.vim',
    \   'tyru/open-browser.vim',
    \]}
" NeoBundle 'klen/python-mode'
NeoBundleLazy 'hynek/vim-python-pep8-indent', {
    \ "autoload": {"insert": 1, "filetype": ["python", "python3", "djangohtml"]}}


call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles dfound on startup,
" this will conveiently prompt you to install them.
NeoBundleCheck

" 行番号を表示
set number

" マウスを有効にする
if has('mouse')
    set mouse=a
endif

"カーソルキーで行末／行頭の移動可能に設定
set whichwrap=b,s,[,],<,>

"タブを設定
set tabstop=4
set shiftwidth=0
set expandtab

"自動的にインデントする
set autoindent
set smartindent

" 入力されているテキストの最大幅
set textwidth=0

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

" ハイライトを有効にする
if &t_Co > 2 || has('gui_running')
    syntax on
endif

set nowritebackup
set nobackup
set noswapfile

set clipboard=unnamed,autoselect
set colorcolumn=80

" set hilight color
" To show current color scheme by
" ':so $VIMRUNTIME/syntax/hitest.vim'
highlight NonText ctermfg=0 guifg=Bg
highlight Normal ctermbg=None
highlight LineNr ctermbg=0 ctermfg=8
highlight ColorColumn ctermbg=0
highlight CursorLine cterm=None
highlight CursorLineNr ctermbg=6 ctermfg=0
highlight MatchParen ctermbg=7
highlight Statement ctermfg=3 ctermbg=None

nnoremap <Down> gj
nnoremap <Up>   gk
nnoremap h <Left>zv
" nnoremap j gj
" nnoremap k gk
nnoremap l <Right>zv

" Gista
let g:gista#github_user = 'ssh0'
let g:gista#update_on_write = 1

""" markdown {{{
set syntax=markdown
autocmd BufRead,BufNewFile *.mkd set filetype=markdown
autocmd BufRead,BufNewFile *.md set filetype=markdown
" Disable folding
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
" }}}

" Add ranger as a file chooser in vim
"
" If you add this code to the .vimrc, ranger can be started using the command
" ":RagerChooser" or the keybinding "<leader>r".  Once you select one or more
" files, press enter and ranger will quit again and vim will open the selected
" files.

function! RangeChooser()
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
endfunction
command! -bar RangerChooser call RangeChooser()
nnoremap <Space>r :<C-U>RangerChooser<CR>

autocmd BufNewFile *.py 0r $HOME/Templates/Python.py
autocmd BufNewFile *.sh 0r $HOME/Templates/shell_script.sh
