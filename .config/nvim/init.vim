
" {{{ plugin
set runtimepath+=$XDG_CONFIG_HOME/nvim/dein/repos/github.com/Shougo/dein.vim

if dein#load_state(expand($XDG_CONFIG_HOME.'/nvim/dein'))
	call dein#begin(expand($XDG_CONFIG_HOME.'/nvim/dein'))
	call dein#add('Shougo/dein.vim')
	call dein#add('Shougo/neocomplete.vim')
	call dein#add('Shougo/unite.vim')
	call dein#add('Shougo/junkfile.vim')
	call dein#add('kana/vim-submode')
  call dein#add('scrooloose/nerdtree')
  " call dein#add('plasticboy/vim-markdown')
	call dein#add('szw/vim-maximizer')
	call dein#add('chriskempson/vim-tomorrow-theme')
	call dein#add('w0ng/vim-hybrid')
	call dein#add('tamelion/neovim-molokai')
	call dein#add('vim-airline/vim-airline')
	call dein#add('vim-airline/vim-airline-themes')
	call dein#add('thinca/vim-zenspace')
	call dein#add('tpope/vim-surround')
	call dein#add('JuliaEditorSupport/julia-vim')
	call dein#add('mtth/scratch.vim')
	call dein#add('scrooloose/syntastic')
	" call dein#add('Shougo/vimfiler')
	" call dein#add('wakatime/vim-wakatime.git')
	" call dein#add('kannokanno/previm')
	call dein#end()
	call dein#save_state()
endif

filetype plugin indent on
syntax enable
" }}}

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
" }}}

" {{{ plugin settings
" nippo
set runtimepath+=$HOME/workspace/github.com/wassen/nippo.vim
let g:nippo#home_directory = $HOME . "/workspace/tmp"
let g:junkfile#directory = $HOME . "/workspace/github.com/wassen/mdnote/junkfile"
nnoremap <silent> ,e  :<C-u>Unite junkfile/new junkfile -start-insert<CR>
let g:syntastic_python_flake8_args = '--ignore="E203,E221,E402,E501"'
" scrooloose/syntastic
let g:syntastic_python_checkers = ["flake8"]
" }}}

" View
" color scheme
set background=dark
" colorscheme設定時に上書き
autocmd ColorScheme * highlight Comment ctermfg=243 guifg=#008799
autocmd ColorScheme * highlight NonText ctermfg=043
autocmd ColorScheme * highlight SpecialKey ctermfg=043
colorscheme hybrid

" ステータスバーとタブバーの表示
set laststatus=2
set showtabline=2

" airline
let g:airline_powerline_fonts = 1
let g:airline_theme='powerlineish'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
" let g:airline#extensions#tabline#buffer_idx_mode = 0

" 折り返しに文字を割り当てる
set showbreak=↪
set list
set listchars=tab:▸\ ,trail:·
" set listchars=tab:»\ ,trail:•


set guicursor=n-v-c:hor20-Cursor/lCursor,i-ci:ver25-Cursor/lCursor " ,r-cr:hor20-Cursor/lCursor
" lCursorの意味がわからん
" いろいろ意味わからん
" set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175
" au VimLeave * set guicursor=a:block-blinkon0


" key bind
"{{{
noremap  
noremap!  
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;
" 矢印キーでなら行内を動けるように
nnoremap <Down> gj
nnoremap <Up>   gk
" インサートモードでも移動したい
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>
inoremap <C-g> <C-h>
inoremap <C-d> <Del>
" 検索で常に中央に
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
" 
noremap <S-C-h> <S-h>
noremap <S-C-l> <S-l>
noremap <S-h>   ^
" noremap <S-j>   }
" noremap <S-k>   {
noremap <S-l>   $
" jj->ESC
inoremap <silent> jj <ESC>
" Enterで行の挿入
nnoremap <silent> <Return> :<C-u>call append(line('.'), '')<Cr>j
" nnoremap <silent> , :<C-u>call append(line('.')-1, '')<Cr>k
nnoremap <ESC><ESC> :noh<CR>:set nopaste<CR>:<CR>

" termianl
if has('nvim')
  tnoremap <silent> jj <C-\><C-n>
endif

" 画面分割関連
"{{{
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
nnoremap sr <C-w>r
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
"

"}}}
" 行区切り

" setting

" neovimからエラーが出るので、うまくやってくれるプラグインで対応
" augroup highlightIdegraphicSpace
"   autocmd!
"   autocmd Colorscheme * highlight IdeographicSpace term=underline ctermbg=DarkGreen guibg=DarkGreen
"   autocmd VimEnter,WinEnter * match IdeographicSpace /　/
" augroup END
" 
" highlight ZSpace cterm=underline ctermfg=7 guifg=7
" au BufRead,BufNew * match ZSpace /　/

set cursorline
set scrolloff=4
set backspace=indent,eol,start

set undofile
" BufNewFile, BufReadPre, StdinReadPreなどは効かなかった, BufWrite, BufEnterならいけた
autocmd BufEnter,BufWrite /dev/null set noundofile
set dictionary+=/usr/share/dict/words
set hidden

let g:neocomplcache_enable_at_startup = 1

set hidden


" detect marker{*3 }*3
set foldmethod=marker

set t_Co=256

" show line
set number
set relativenumber
" size of command history
set history=256
filetype plugin indent on
set ruler
set cindent
let loaded_matchparen = 1

set ignorecase
set smartcase

set autoindent
" タブを表示するときの幅
set tabstop=2
" タブを挿入するときの幅
set shiftwidth=2
" タブをタブとして扱う(スペースに展開しない)
" set noexpandtab
" 展開する
set expandtab
" 
set softtabstop=0
" ハイライト
set hlsearch

" レジスタへのyankをclipboardへ
set clipboard+=unnamed

" Google Calendar
let g:calendar_google_calendar = 1
let g:calendar_google_task = 1

" template
au BufNewFile *.py :0r ~/.vim/snippet/utf8.py
au BufNewFile *.sh :0r ~/.vim/snippet/template.sh
au BufNewFile *.html :0r ~/.vim/snippet/template.html

" augroup filetypedetect
au BufRead,BufNewFile *.php nested setfiletype php
au BufRead,BufNewFile *.swift nested setfiletype swift
au BufRead,BufNewFile *.html setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
au BufRead,BufNewFile *.css setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
au BufRead,BufNewFile *.js setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
au BufRead,BufNewFile *.rb setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
" augroup END

if has('vim_starting')
    " Changing encoding in Vim at runtime is undefined behavior.
    set encoding=utf-8
    set fileencodings=utf-8,sjis,cp932,euc-jp
    set fileformats=unix,mac,dos
endif

" function
function ToggleCopyFunc()
    set invnumber
    set invlist
    set invrelativenumber
endfunction

function TodoFunc()
	e ~/TODO
endfunction

command ToggleCopy :call ToggleCopyFunc()

command Todo :call TodoFunc()

command DiffOrig vert new | set buftype=nofile | read ++edit # | 0d_
                \ | diffthis | wincmd p | diffthis

" function NippoFunc()
"   let now = localtime()
"   let month = strftime("%B", now)
"   let day = strftime("%d", now)
"   echo month
"   " 変数をうまい具合に展開したい
"   " workspace/アタリが重複している
"   " eval???
"   execute "!mkdir -p ~/workspace/github.o-in.dwango.co.jp/wassen/working-note/" . month
"   execute 'edit' "~/workspace/github.o-in.dwango.co.jp/wassen/working-note/" . month. "/" . day . ".md"
" endfunction
" command Nippo :call NippoFunc()
