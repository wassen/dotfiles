" unenable vi compatible
set nocompatible
" neocomplcache seems better
set backspace=indent,eol,start
noremap  
noremap!  

" let g:neocomplcache_enable_at_startup = 1

syntax enable

colorscheme molokai
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
nnoremap ; :
nnoremap : ;

:set autoindent
" タブを表示するときの幅
set tabstop=4
" タブを挿入するときの幅
set shiftwidth=4
" タブをタブとして扱う(スペースに展開しない)
set noexpandtab
" 
set softtabstop=0
