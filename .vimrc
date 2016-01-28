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

:set tabstop=4
:set autoindent
:set expandtab
:set shiftwidth=4
