python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup
set laststatus=2
set showtabline=2
set noshowmode

" package manager
" {{{
if &compatible
  set nocompatible
endif
set runtimepath^=~/.vim/dein/repos/github.com/Shougo/dein.vim

call dein#begin(expand('~/.vim/dein'))

" basic plugin
call dein#add('Shougo/dein.vim')
call dein#add('Shougo/neocomplete.vim')
" md plugin
call dein#add('plasticboy/vim-markdown')
" call dein#add('kannokanno/previm')
" Calendar plugin
" call dein#add('itchyny/calendar.vim')
" call dein#add('')
call dein#end()
filetype plugin indent on
if dein#check_install()
	call dein#install()
endif
" }}}

" color scheme
colorscheme molokai

" alias
:command Cal Calendar

" key bind
"{{{
noremap  
noremap!  
nnoremap ; :
nnoremap : ;
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
" jj->ESC
inoremap <silent> jj <Right><ESC>
" Enterで行の挿入
nnoremap <silent> <Return> :<C-u>call append(line('.'), '')<Cr>j
nnoremap <silent> , :<C-u>call append(line('.')-1, '')<Cr>k

"}}}
" 行区切り
" set showbreak=↪

set backspace=indent,eol,start

" let g:neocomplcache_enable_at_startup = 1

" detect marker{*3 }*3
set foldmethod=marker

syntax enable

set t_Co=256

" show line
set number
" size of command history
set history=256
filetype plugin indent on
set ruler
set encoding=utf-8
set cindent
set list
set listchars=tab:>-,trail:.
let loaded_matchparen = 1

:set autoindent
" タブを表示するときの幅
set tabstop=4
" タブを挿入するときの幅
set shiftwidth=4
" タブをタブとして扱う(スペースに展開しない)
set noexpandtab
" 
set softtabstop=0


" Google Calendar
let g:calendar_google_calendar = 1
let g:calendar_google_task = 1
