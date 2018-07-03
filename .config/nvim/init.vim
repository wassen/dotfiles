" {{{ file encoding
if has('vim_starting')
    set encoding=utf-8
    scriptencoding utf-8
    set fileencodings=utf-8,sjis,cp932,euc-jp
    set fileformats=unix,mac,dos
endif
" }}} file encoding

"set guicursor=

" {{{ plugin
set runtimepath+=$XDG_CONFIG_HOME/nvim/dein/repos/github.com/Shougo/dein.vim

if dein#load_state(expand($XDG_CONFIG_HOME.'/nvim/dein'))
    call dein#begin(expand($XDG_CONFIG_HOME.'/nvim/dein'))
    call dein#add('Shougo/dein.vim')
    " Colortheme
    call dein#add('chriskempson/vim-tomorrow-theme')
    call dein#add('w0ng/vim-hybrid')
    " View
    call dein#add('vim-airline/vim-airline')
    call dein#add('vim-airline/vim-airline-themes')

    call dein#add('kana/vim-submode')
    call dein#add('machakann/vim-sandwich')

    " Utility
    call dein#add('Shougo/junkfile.vim')
    call dein#add('junegunn/fzf.vim')
    call dein#add('junegunn/fzf', { 'build': './install --bin', 'merged': 0 })
    call dein#add('Shougo/neosnippet.vim')
    call dein#add('Shougo/neosnippet-snippets')
    call dein#add('junegunn/vim-easy-align')
    " call dein#add('Shougo/deoplete.nvim')
    " call dein#add('roxma/nvim-yarp')
    " call dein#add('roxma/vim-hug-neovim-rpc')
    call dein#add('Shougo/unite.vim')
    " call dein#add('Shougo/neomru.vim')

    " call dein#add('scrooloose/nerdtree')
    " call dein#add('gabrielelana/vim-markdown')
    " call dein#add('szw/vim-maximizer')
    " call dein#add('tamelion/neovim-molokai')
    " call dein#add('thinca/vim-zenspace')
    call dein#add('w0rp/ale')
    call dein#add('airblade/vim-gitgutter')
    " " Language supports
    " "call dein#add('davidhalter/jedi-vim')
    " call dein#add('JuliaEditorSupport/julia-vim')
    " call dein#add('keith/swift.vim')
    " call dein#add('leafgarland/typescript-vim.git')
    " call dein#add('unclechu/nim.vim')
    " call dein#add('dart-lang/dart-vim-plugin')
    " js
    " call dein#add('othree/yajs.vim')
    " call dein#add('othree/es.next.syntax.vim')
    " call dein#add('mxw/vim-jsx')

    " call dein#add('Shougo/vimfiler')
    " call dein#add('wakatime/vim-wakatime.git')
    " call dein#add('kannokanno/previm')
    " call dein#add('tpope/vim-surround')
    " call dein#add('mtth/scratch.vim')
    call dein#end()
    call dein#save_state()
endif

filetype plugin indent on
syntax enable
" }}}

" {{{ key bind
let mapleader = "\<Space>"
noremap  
noremap!  
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;
nnoremap <Down> gj
nnoremap <Up>     gk
noremap <S-h> ^
noremap <S-l> $
noremap <S-C-h> <S-h>
noremap <S-C-l> <S-l>
" インサートモードでも移動したい
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
inoremap <C-h> <Left>
inoremap <C-g> <C-h>
inoremap <C-d> <Del>
" inoremap <C-S-l> <C-o>$とかはむりっぽい(insertmodeではlとLが区別されてない？)
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
inoremap <silent> jj <ESC>
" Enterで行の挿入
nnoremap <silent> <Return> :<C-u>call append(line('.'), '')<Cr>j
" nnoremap <silent> , :<C-u>call append(line('.')-1, '')<Cr>k
nnoremap <ESC><ESC> :nohlsearch<CR>:set nopaste<CR>:<CR>

" register
" nnoremap pp ""p
" nnoremap p_ "_p
" nnoremap pa "ap
" nnoremap pb "bp
" nnoremap pc "cp

" nnoremap dd ""dd
" nnoremap d_ "_dd
" nnoremap da "add
" nnoremap db "bdd
" nnoremap dc "cdd

" termianl
if has('nvim')
    tnoremap <silent> jj <C-\><C-n>
endif

" buffer
nnoremap vh :bp<CR>
nnoremap vl :bn<CR>

" {{{ 画面分割関連
"nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
nnoremap sn gt
nnoremap sp gT
" nnoremap sr <C-w>r
nnoremap s= <C-w>=
nnoremap sw <C-w>w
nnoremap so <C-w>_<C-w>|
nnoremap sO <C-w>=
nnoremap sN :<C-u>bn<CR>
nnoremap sP :<C-u>bp<CR>
nnoremap st :<C-u>tabnew<CR>
nnoremap sT :<C-u>Unite tab<CR>
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sq :<C-u>q<CR>
nnoremap sQ :<C-u>bd<CR>
nnoremap sb :<C-u>Unite buffer_tab -buffer-name=file<CR>
nnoremap sB :<C-u>Unite buffer -buffer-name=file<CR>

call submode#enter_with('bufmove', 'n', '', 's>', '<C-w>>')
call submode#enter_with('bufmove', 'n', '', 's<', '<C-w><')
call submode#enter_with('bufmove', 'n', '', 's+', '<C-w>+')
call submode#enter_with('bufmove', 'n', '', 's-', '<C-w>-')
call submode#map('bufmove', 'n', '', '>', '<C-w>>')
call submode#map('bufmove', 'n', '', '<', '<C-w><')
call submode#map('bufmove', 'n', '', '+', '<C-w>+')
call submode#map('bufmove', 'n', '', '-', '<C-w>-')
"}}}

" }}} key bind

" {{{ plugin settings
set runtimepath+=$HOME/.vim/plugin/swift
" nippo
set runtimepath+=$HOME/workspace/github.com/wassen/nippo.vim
let g:nippo#home_directory = $HOME . "/workspace/github.o-in.dwango.co.jp/wassen/working-note"
let g:junkfile#directory = $HOME . "/workspace/github.com/wassen/mdnote/junkfile"
nnoremap <silent> ,e    :<C-u>Unite junkfile/new junkfile -start-insert<CR>
" airline
let g:airline_powerline_fonts = 1
let g:airline_theme='powerlineish'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#fnamemod = ':t'
" let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
" let g:airline#extensions#tabline#buffer_idx_mode = 0
" gitgutter

" fzf
let g:fzf_layout = { 'down': '~40%' }
nnoremap <Leader>g :GFiles<CR>
nnoremap <Leader>s :GFiles?<CR>
nnoremap <Leader>f :GGrep<CR>
nnoremap <Leader>b :Buffers<CR>

" neocomplete
" let g:deoplete#enable_at_startup = 1
" ALE
let g:ale_sign_column_always = 1
let g:ale_lint_on_save = 1
let g:ale_python_flake8_options = "--ignore=E203,E221,E251,E271,E272"
" let g:ale_lint_on_text_changed = 0
" {{{ neosnippet
" Plugin key-mappings.
" Note: It must be "imap" and "smap".    It uses <Plug> mappings.
imap <C-b>         <Plug>(neosnippet_expand_or_jump)
smap <C-b>         <Plug>(neosnippet_expand_or_jump)
xmap <C-b>         <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".    It uses <Plug> mappings.
imap <C-b>         <Plug>(neosnippet_expand_or_jump)
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \        "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
    set conceallevel=2 concealcursor=niv
endif
let g:neosnippet#snippets_directory='~/.vim/neosnippet/'
" }}} neosnippet
" align
xmap ga <Plug>(EasyAlign)<C-p>
" markdown
let g:markdown_enable_spell_checking = 0
" NERDTree
let NERDTreeShowHidden=1
" }}}

" {{{ View
" {{{ transeparent
if !has('gui_running')
    augroup seiya
        autocmd!
        autocmd VimEnter,ColorScheme * highlight Normal ctermbg=none
        autocmd VimEnter,ColorScheme * highlight LineNr ctermbg=none
        autocmd VimEnter,ColorScheme * highlight SignColumn ctermbg=none
        autocmd VimEnter,ColorScheme * highlight VertSplit ctermbg=none
        autocmd VimEnter,ColorScheme * highlight NonText ctermbg=none
    augroup END
endif
" }}} transeparent

" {{{ color scheme
set background=dark
    augroup color_scheme
        autocmd!
        autocmd ColorScheme * highlight Comment ctermfg=243 guifg=#008799
        autocmd ColorScheme * highlight NonText ctermfg=043
        " 70もよい
        autocmd ColorScheme * highlight SpecialKey ctermfg=035
    augroup END
colorscheme hybrid
" }}} color scheme

" show statusbar and tabbar
set laststatus=2
set showtabline=2
" 折り返し文字
set showbreak=↪
" show invisible
set list
set listchars=tab:▸\ ,trail:·
" set listchars=tab:»\ ,trail:•

" {{{ cursor of nvim
" set guicursor=n-v-c:hor20-Cursor/lCursor,i-ci:ver25-Cursor/lCursor " ,r-cr:hor20-Cursor/lCursor
" lCursorの意味がわからん
" いろいろ意味わからん
" set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175
" autocmd VimLeave * set guicursor=a:block-blinkon0
" }}} cursor of nvim

" }}} View

" {{{ other settings
" open other buffer without save
set hidden
" カーソル行のハイライト
set cursorline
" 画面のスクロールが開始される行数
set scrolloff=4

set backspace=indent,eol,start

set undofile
" BufNewFile, BufReadPre, StdinReadPreなどは効かなかった
autocmd BufEnter,BufWrite /dev/null set noundofile

set dictionary+=/usr/share/dict/words
" detect marker{*3 }*3
set foldmethod=marker

" シンタックスハイライトをする最大文字数
set synmaxcol=300

set t_Co=256
" show line
set number
set relativenumber

" size of command history
set history=256

set ruler

set cindent

" JSONで""を消したりする不便機能を削除
set conceallevel=0

" let g:loaded_matchparen = 1

set ignorecase
set smartcase

set autoindent
" タブを表示するときの幅
set tabstop=2
set softtabstop=0
" タブを挿入するときの幅
set shiftwidth=2
" タブをスペースに展開する
set expandtab

" 検索のハイライト
set hlsearch

" レジスタへのyankをclipboardへ
set clipboard+=unnamed
" }}} other settings

" {{{ augroup
augroup snippet
    autocmd!
    autocmd BufNewFile *.py :0r ~/.vim/snippet/utf8.py
    autocmd BufNewFile *.sh :0r ~/.vim/snippet/template.sh
    autocmd BufNewFile *.html :0r ~/.vim/snippet/template.html
augroup END

augroup user_filetypedetect
    autocmd!
    " source ~/.vimrcしたら、開き直さないとこちらの設定が反映されない
    autocmd BufRead,BufNewFile *.php setfiletype php
    autocmd BufRead,BufNewFile *.swift setlocal expandtab tabstop=4 softtabstop=4 shiftwidth=4
    autocmd BufRead,BufNewFile *.html setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufRead,BufNewFile *.css setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufRead,BufNewFile *.js setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufRead,BufNewFile *.rb setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufRead,BufNewFile *.ts setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufRead,BufNewFile *.tsx setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufRead,BufNewFile *.vimrc setlocal expandtab tabstop=4 softtabstop=4 shiftwidth=4
    autocmd BufRead,BufNewFile *.md setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufRead,BufNewFile *.plist setfiletype xml
    autocmd BufRead,BufNewFile *.yml setlocal indentkeys=<Return>
    " indentkeysがDockerfileで効かない
    " setすらも効かない。nosmartindent, comment=等
    autocmd BufRead,BufNewFile dockerfile setlocal expandtab tabstop=4 softtabstop=4 shiftwidth=4
    autocmd BufRead,BufNewFile *.sh,.zshrc setlocal noexpandtab "tabstop=2 softtabstop=0 shiftwidth=2
augroup END

augroup gitcommit
    autocmd!
    " Commit Messageで勝手に改行されないように
    autocmd FileType gitcommit set textwidth=0
augroup END

" }}} augroup

" {{{ functions
function! ToggleCopyFunc()
    set invnumber
    set invlist
    set invrelativenumber
endfunction
function! DiffOrigFunc()
    vert new | set buftype=nofile | read ++edit # | 0d_ | diffthis | wincmd p | diffthis
endfunction
function! BlameFunc()
    let line_number = line('.')
    execute '!git log -L' . line_number . ','  . line_number . ':' . expand("%")
endfunction
function! ExecFunc(...)
    w
    execute '! ./%' join(a:000, " ")
endfunction
" }}} functions

" {{{ commands
command! ToggleCopy :call ToggleCopyFunc()
command! DiffOrig :call DiffOrigFunc()
command! -nargs=* Exec :call ExecFunc(<f-args>)
command! CDCurrentFile :cd %:p:h
command! BLAME :call BlameFunc()
command! Vimrc edit ~/.vimrc
" fzf
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)
" }}} commands
