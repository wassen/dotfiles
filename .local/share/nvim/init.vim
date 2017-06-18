if has('vim_starting')
    " Changing encoding in Vim at runtime is undefined behavior.
    set encoding=utf-8
    set fileencodings=utf-8,sjis,cp932,euc-jp
    set fileformats=unix,mac,dos
endif

set laststatus=2
set showtabline=2
"set showmode

" {{{ dein
if &compatible
  set nocompatible
endif
set runtimepath+=$XDG_CONFIG_HOME/nvim/dein/repos/github.com/Shougo/dein.vim
" set runtimepath+=$XDG_CONFIG_HOME/nvim/.vim/

if dein#load_state(expand($XDG_CONFIG_HOME.'/nvim/dein'))
	call dein#begin(expand($XDG_CONFIG_HOME.'/nvim/dein'))

	"" basic plugin
	call dein#add('Shougo/dein.vim')
	call dein#add('Shougo/neocomplete.vim')
	" file tree
	call dein#add('scrooloose/nerdtree')
	call dein#add('scrooloose/nerdtree')
	" md plugin
	call dein#add('plasticboy/vim-markdown')
	" color theme
	call dein#add('chriskempson/vim-tomorrow-theme')
	call dein#add('w0ng/vim-hybrid')
	call dein#add('tamelion/neovim-molokai')
	call dein#add('vim-airline/vim-airline')
	call dein#add('vim-airline/vim-airline-themes')
	call dein#add('thinca/vim-zenspace')
	call dein#add('tpope/vim-surround')
  

	" wakatime omoi
	" call dein#add('wakatime/vim-wakatime.git')
	call dein#add('kana/vim-submode')
	"call dein#add('kannokanno/previm')
	" Calendar plugin
	"call dein#add('itchyny/calendar.vim')
	"
	" call dein#add('')

	call dein#end()
	call dein#save_state()
endif

filetype plugin indent on
syntax enable
" if dein#check_install()
" 	call dein#install()
" endif
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

" autocmd ColorScheme * highlight Comment ctermfg=22 guifg=#008800
autocmd ColorScheme * highlight NonText ctermfg=043
autocmd ColorScheme * highlight SpecialKey ctermfg=043

"set background=dark
" color scheme   
colorscheme Tomorrow-Night-Bright

" alias
:command Cal Calendar

" airline
let g:airline_powerline_fonts = 1
let g:airline_theme='powerlineish'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
" let g:airline#extensions#tabline#buffer_idx_mode = 0

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
inoremap <silent> jj <Right><ESC>
" Enterで行の挿入
nnoremap <silent> <Return> :<C-u>call append(line('.'), '')<Cr>j
" nnoremap <silent> , :<C-u>call append(line('.')-1, '')<Cr>k
nnoremap <ESC><ESC> :noh<CR>:set nopaste<CR>:<CR>
" デクリメント
nnoremap <C-e> <C-x>

" termianl
tnoremap <silent> jj <C-\><C-n>

nnoremap <C-c> :ToggleCopy<CR>

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

"}}}
" 行区切り

" setting
" 折り返しに文字を割り当てる
set showbreak=↪
set list
set listchars=tab:▸\ ,trail:·
" set listchars=tab:»\ ,trail:•
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
set dictionary+=/usr/share/dict/words

let g:neocomplcache_enable_at_startup = 1

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
set encoding=utf-8
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

" set clipboard+=unnamed

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

" function
function ToggleCopyFunc()
    set invnumber
    set invlist
endfunction
command ToggleCopy :call ToggleCopyFunc()

function TodoFunc()
	e ~/TODO
endfunction
command Todo :call TodoFunc()