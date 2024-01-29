
--set background=dark
--augroup color_scheme
--    autocmd!
--    autocmd ColorScheme * highlight Comment ctermfg=243 guifg=#008799
--    autocmd ColorScheme * highlight NonText ctermfg=043
--    " 70もよい
--    autocmd ColorScheme * highlight SpecialKey ctermfg=035
--augroup END
vim.o.background = "dark"
vim.cmd[[colorscheme hybrid]]

vim.opt.termguicolors = true
