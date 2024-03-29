vim.g.mapleader = " "

vim.api.nvim_set_keymap('n', ';', ':', { noremap = true })
vim.api.nvim_set_keymap('n', ':', ';', { noremap = true })
vim.api.nvim_set_keymap('v', ';', ':', { noremap = true })
vim.api.nvim_set_keymap('v', ':', ';', { noremap = true })
vim.api.nvim_set_keymap('v', ':', ';', { noremap = true })

vim.api.nvim_set_keymap('', '<S-h>', '^', { noremap = false })
vim.api.nvim_set_keymap('', '<S-l>', '$', { noremap = false })

vim.api.nvim_set_keymap('i', 'jj', '<C-[>', { noremap = true })

-- lsp
-- lsp用のBindingはlspの設定に置くべきか
-- lsp対応かどうかの判別？
vim.api.nvim_set_keymap('n', '<C-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true })
-- これとの違いはなんだ
-- vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
vim.api.nvim_set_keymap('n', '<Leader>la', '<cmd>lua vim.lsp.buf.code_action()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>lr', '<cmd>lua vim.lsp.buf.rename()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>l<Leader>', '<cmd>Telescope<CR>', { noremap = true })

-- buffer
vim.api.nvim_set_keymap('n', '<Leader>bh', '<cmd>bprevious<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>bl', '<cmd>bnext<CR>', { noremap = true })
