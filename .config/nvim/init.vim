" {{{ file encoding

if has('vim_starting')
    set encoding=utf-8
    scriptencoding utf-8
    set fileencodings=utf-8,sjis,cp932,euc-jp
    set fileformats=unix,mac,dos
endif

" }}} file encoding

" {{{ plugin
set runtimepath+=$XDG_CONFIG_HOME/nvim/dein/repos/github.com/Shougo/dein.vim

if dein#load_state(expand($XDG_CONFIG_HOME.'/nvim/dein'))
    call dein#begin(expand($XDG_CONFIG_HOME.'/nvim/dein'))
    call dein#add('vim-jp/vimdoc-ja')
    call dein#add('Shougo/dein.vim')
    " Colortheme
    call dein#add('chriskempson/vim-tomorrow-theme')
    call dein#add('w0ng/vim-hybrid')
    " View
    call dein#add('vim-airline/vim-airline')
    call dein#add('vim-airline/vim-airline-themes')
    call dein#add('nathanaelkane/vim-indent-guides')
    " call dein#add('dodie/vim-fibo-indent')

    call dein#add('kana/vim-submode')
    call dein#add('machakann/vim-sandwich')

    " Text object
    call dein#add('michaeljsmith/vim-indent-object')

    " Utility
    call dein#add('justinmk/vim-dirvish')
    call dein#add('Shougo/junkfile.vim')
    call dein#add('junegunn/fzf.vim')
    " call dein#add('junegunn/fzf', { 'build': './install --bin', 'merged': 0 })
    call dein#local('/usr/local/opt/', {}, ['fzf'])
    call dein#add('Shougo/neosnippet.vim')
    call dein#add('Shougo/neosnippet-snippets')
    call dein#add('junegunn/vim-easy-align')
    call dein#add('lfv89/vim-interestingwords')
    " call dein#add('Shougo/deoplete.nvim')
    " call dein#add('roxma/nvim-yarp')
    " call dein#add('roxma/vim-hug-neovim-rpc')
    call dein#add('Shougo/unite.vim')
    " call dein#add('Shougo/neomru.vim')
    call dein#add('Vimjas/vim-python-pep8-indent')
    call dein#add('wassen/nippo.vim')

    " call dein#add('scrooloose/nerdtree')
    " call dein#add('gabrielelana/vim-markdown')
    " call dein#add('szw/vim-maximizer')
    " call dein#add('tamelion/neovim-molokai')
    " call dein#add('thinca/vim-zenspace')
    call dein#add('prabirshrestha/async.vim')
    call dein#add('prabirshrestha/vim-lsp')
    call dein#add('mattn/vim-lsp-settings')

    call dein#add('airblade/vim-gitgutter')

    " " Language supports
    call dein#add('mgedmin/coverage-highlight.vim')
    call dein#add('udalov/kotlin-vim')
    call dein#add('w0rp/ale', {'on_ft':'cs'})
    call dein#add('OmniSharp/omnisharp-vim', {'on_ft':'cs'})

    " "call dein#add('davidhalter/jedi-vim')
    " call dein#add('JuliaEditorSupport/julia-vim')
    " call dein#add('keith/swift.vim')
    call dein#add('leafgarland/typescript-vim.git')
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
nnoremap <Up> gk
noremap gR R
noremap R gR
noremap <S-h> ^
noremap <S-l> $
noremap <S-C-h> <S-h>
noremap <S-C-l> <S-l>
" インサートモードでも移動したい
" inoremap <C-j> <Down>
" inoremap <C-k> <Up>
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
nnoremap <silent> <C-j> :<C-u>call append(line('.'), '')<Cr>j
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
nnoremap <Leader>bh :bp<CR>
nnoremap <Leader>bl :bn<CR>

" {{{ 画面分割関連
"nnoremap s <Nop>
nnoremap <Leader>sj <C-w>j
nnoremap <Leader>sk <C-w>k
nnoremap <Leader>sl <C-w>l
nnoremap <Leader>sh <C-w>h
nnoremap <Leader>sJ <C-w>J
nnoremap <Leader>sK <C-w>K
nnoremap <Leader>sL <C-w>L
nnoremap <Leader>sH <C-w>H
nnoremap <Leader>sn gt
nnoremap <Leader>sp gT
" nnoremap sr <C-w>r
nnoremap <Leader>s= <C-w>=
nnoremap <Leader>sw <C-w>w
nnoremap <Leader>so <C-w>_<C-w>|
nnoremap <Leader>sO <C-w>=
nnoremap <Leader>sN :<C-u>bn<CR>
nnoremap <Leader>sP :<C-u>bp<CR>
nnoremap <Leader>st :<C-u>tabnew<CR>
nnoremap <Leader>sT :<C-u>Unite tab<CR>
nnoremap <Leader>ss :<C-u>sp<CR>
nnoremap <Leader>sv :<C-u>vs<CR>
nnoremap <Leader>sq :<C-u>q<CR>
nnoremap <Leader>sQ :<C-u>bd<CR>
nnoremap <Leader>sb :<C-u>Unite buffer_tab -buffer-name=file<CR>
nnoremap <Leader>sB :<C-u>Unite buffer -buffer-name=file<CR>

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
let g:nippo#home_directory = $HOME . "/workspace/github.o-in.dwango.co.jp/wassen/note"
let g:junkfile#directory = $HOME . "/workspace/github.o-in.dwango.co.jp/wassen/mdnote/junkfile"
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
nmap <Leader>ha <Plug>GitGutterStageHunk
nmap <Leader>hr <Plug>(GitGutterUndoHunk)

" fzf
let g:fzf_layout = { 'down': '~40%' }
nnoremap <Leader>fg :GFiles<CR>
nnoremap <Leader>fs :GFiles?<CR>
nnoremap <Leader>ff :GGrep<CR>
nnoremap <Leader>fb :Buffers<CR>
nnoremap <Leader>fh :History<CR>
imap <c-x><c-k> <plug>(fzf-complete-word)

" neocomplete
" let g:deoplete#enable_at_startup = 1
" ALE
" let g:ale_sign_column_always = 1
" let g:ale_lint_on_save = 1
" let g:ale_python_flake8_options = "--ignore=E203,E221,E251,E271,E272,E501"
" let g:ale_lint_on_text_changed = 0
let g:ale_linters = { 'cs': ['OmniSharp'] }

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
    set conceallevel=0 concealcursor=niv
endif
let g:neosnippet#snippets_directory='~/.vim/neosnippet/'
" }}} neosnippet
" align
xmap ga <Plug>(EasyAlign)<C-p>
" markdown
let g:markdown_enable_spell_checking = 0
" NERDTree
let NERDTreeShowHidden=1
" {{{ vim-lsp

" let g:lsp_diagnostics_enabled = 0

" let g:lsp_log_verbose = 1
" let g:lsp_log_file = expand('~/vim-lsp.log')

let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_signs_error = {'text': '🤔'}



augroup lsp
    let s:kotlin_language_server = $HOME . '/workspace/github.com/fwcd/KotlinLanguageServer/server/build/install/server/bin/kotlin-language-server'

    if executable(s:kotlin_language_server)
        autocmd User lsp_setup call lsp#register_server({
            \ 'name': 'kotlin',
            \ 'cmd': {server_info->[s:kotlin_language_server]},
            \ 'whitelist': ['kotlin'],
            \ })
    endif

    if executable('pyls')
        " Python用の設定を記載
        " workspace_configで以下の設定を記載
        " - pycodestyleの設定はALEと重複するので無効にする
        " - jediの定義ジャンプで一部無効になっている設定を有効化
        autocmd User lsp_setup call lsp#register_server({
            \ 'name': 'pyls',
            \ 'cmd': { server_info -> ['pyls'] },
            \ 'whitelist': ['python'],
            \ })
        autocmd FileType python call s:configure_lsp()
    endif
    autocmd FileType typescript call s:configure_lsp()
augroup END

function! s:configure_lsp() abort
  setlocal omnifunc=lsp#complete
  " LSP用にマッピング
  nnoremap <C-]> :LspDefinition<CR>
  " nnoremap <buffer> gd :<C-u>LspDefinition<CR>
  " nnoremap <buffer> gD :<C-u>LspReferences<CR>
  " nnoremap <buffer> gs :<C-u>LspDocumentSymbol<CR>
  " nnoremap <buffer> gS :<C-u>LspWorkspaceSymbol<CR>
  " nnoremap <buffer> gQ :<C-u>LspDocumentFormat<CR>
  " vnoremap <buffer> gQ :LspDocumentRangeFormat<CR>
  " nnoremap <buffer> K :<C-u>LspHover<CR>
  " nnoremap <buffer> <F1> :<C-u>LspImplementation<CR>
  " nnoremap <buffer> <F2> :<C-u>LspRename<CR>
endfunction

" }}}
"
" others
let g:indent_guides_enable_on_vim_startup = 1
set listchars=tab:\|\

" OmniSharp
let g:OmniSharp_server_use_mono = 1
let g:OmniSharp_selector_ui = 'fzf'
augroup omnisharp_commands
    autocmd!
    " Show type information automatically when the cursor stops moving
    " autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

    " The following commands are contextual, based on the cursor position.
    autocmd FileType cs nnoremap <buffer> <C-]> :OmniSharpGotoDefinition<CR>
    " autocmd FileType cs nnoremap <buffer> <Leader>fi :OmniSharpFindImplementations<CR>
    " autocmd FileType cs nnoremap <buffer> <Leader>fs :OmniSharpFindSymbol<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>ou :OmniSharpFindUsages<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>or :OmniSharpRename<CR>

    " Finds members in the current buffer
    " autocmd FileType cs nnoremap <buffer> <Leader>fm :OmniSharpFindMembers<CR>
    " autocmd FileType cs nnoremap <buffer> <Leader>fx :OmniSharpFixUsings<CR>
    " autocmd FileType cs nnoremap <buffer> <Leader>tt :OmniSharpTypeLookup<CR>
    " autocmd FileType cs nnoremap <buffer> <Leader>dc :OmniSharpDocumentation<CR>
    " autocmd FileType cs nnoremap <buffer> <C-\> :OmniSharpSignatureHelp<CR>
    " autocmd FileType cs inoremap <buffer> <C-\> <C-o>:OmniSharpSignatureHelp<CR>

    " Navigate up and down by method/property/field
    " autocmd FileType cs nnoremap <buffer> <C-k> :OmniSharpNavigateUp<CR>
    " autocmd FileType cs nnoremap <buffer> <C-j> :OmniSharpNavigateDown<CR>

    " Find all code errors/warnings for the current solution and populate the quickfix window
    " autocmd FileType cs nnoremap <buffer> <Leader>cc :OmniSharpGlobalCodeCheck<CR>
    autocmd FileType cs nnoremap <buffer> <Leader><Space> :OmniSharpGetCodeActions<CR>
augroup END


" }}}

" {{{ View
" {{{ transparent
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
" }}} transparent

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
" set gcr=n-v-c-sm:hor1000-blinkwait300-blinkon200-blinkoff150,i-ci-ve:ver25,r-cr-o:hor20
" lCursorの意味がわからん
" いろいろ意味わからん
" set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175
" autocmd VimLeave * set guicursor=a:block-blinkon0
if has('nvim')
    set gcr=n-v-c-sm:hor20,i-ci-ve:ver25,r-cr-o:hor20
endif
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

set helplang=ja
set virtualedit=block

" size of command history
set history=256

set ruler

set iskeyword+=-

" set cindent

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
" 検索が徐々にハイライト
set incsearch

" レジスタへのyankをclipboardへ
set clipboard+=unnamed

set cmdheight=2

" Omni Completionでプレビューを出さない
set completeopt-=preview

if has('nvim')
    let g:python3_host_prog='/usr/local/bin/python3'
endif

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
    autocmd BufRead,BufNewFile *.sh,.zshrc,.zprofile setlocal noexpandtab "tabstop=2 softtabstop=0 shiftwidth=2
    autocmd FileType make setlocal noexpandtab
    autocmd FileType python setlocal autoindent
    " autocmd FileType python setlocal smartindent
    autocmd FileType python setlocal cinwords=if,elif,else,for,while,try,except,finally,def,class
    autocmd FileType python setlocal tabstop=8 expandtab shiftwidth=4 softtabstop=4
    autocmd FileType kotlin setlocal tabstop=8 expandtab shiftwidth=4 softtabstop=4
    autocmd FileType cs setlocal tabstop=8 expandtab shiftwidth=4 softtabstop=4
    autocmd FileType xml setlocal tabstop=8 expandtab shiftwidth=4 softtabstop=4
augroup END
"
" augroup zentab
"     autocmd!
"     autocmd BufNewFile,BufRead "delete oldest buffers"
" augroup END

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
function! FindNippoFunc()
    call fzf#run({'sink': 'e', 'source': 'NIPPO_HOME_DIRECTORY=' . g:nippo#home_directory . 'cd $NIPPO_HOME_DIRECTORY; find $PWD | grep ".md$"'})
endfunction
function! FindRepositoryFunc()
    call fzf#run({'sink': 'cd', 'source': 'ghq list | xargs -I {} echo $(ghq root)/{}'})
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
command! -bang -nargs=* FindNippo :call FindNippoFunc()
command! Yasashiku :setlocal norelativenumber nocursorline
command! Kibishiku :setlocal relativenumber cursorline
command! FindRepository :call FindRepositoryFunc()
" }}} commands

filetype indent plugin on
