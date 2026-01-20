vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.api.nvim_set_keymap('n', ';', ':', { noremap = true })
vim.api.nvim_set_keymap('n', ':', ';', { noremap = true })
vim.api.nvim_set_keymap('v', ';', ':', { noremap = true })
vim.api.nvim_set_keymap('v', ':', ';', { noremap = true })
vim.api.nvim_set_keymap('v', ':', ';', { noremap = true })

vim.api.nvim_set_keymap('', '<S-h>', '^', { noremap = false })
vim.api.nvim_set_keymap('', '<S-l>', '$', { noremap = false })

vim.api.nvim_set_keymap('i', 'jj', '<C-[>', { noremap = true })
vim.api.nvim_set_keymap('t', 'jj', '<C-\\><C-n>', { noremap = true })

-- Telescopeで邪魔になるため一旦変形
-- vim.api.nvim_set_keymap('n', '<ESC><ESC>', '<cmd>nohlsearch<CR><cmd>set nopaste<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Backspace><Backspace>', '<cmd>nohlsearch<CR><cmd>set nopaste<CR>', { noremap = true })

-- vim-highlighter
vim.api.nvim_set_keymap('n', '<Leader>kn', '<Cmd>Hi<<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>kj', '<Cmd>Hi><CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>kc', '<Cmd>Hi!<CR>', { noremap = true })

-- buffer
vim.api.nvim_set_keymap('n', '<Leader>bh', '<cmd>bprevious<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>bl', '<cmd>bnext<CR>', { noremap = true })

-- Telescope
vim.api.nvim_set_keymap('n', '<Leader>l<Leader>', '<cmd>Telescope<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>lg', '<cmd>Telescope git_files<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>ls', '<cmd>Telescope git_status<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>lf', '<cmd>Telescope live_grep<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>lb', '<cmd>Telescope buffers<CR>', { noremap = true })

-- ウィンドウ切り替え
vim.api.nvim_set_keymap('n', 'sl', '<C-w>l', { noremap = true })
vim.api.nvim_set_keymap('n', 'sh', '<C-w>h', { noremap = true })
vim.api.nvim_set_keymap('n', 'sj', '<C-w>j', { noremap = true })
vim.api.nvim_set_keymap('n', 'sk', '<C-w>k', { noremap = true })

-- ウィンドウリサイズ（連続入力可能）
-- _も-も同じキーを指しているつもりなのだが、<C-->、および<C-S-_>では認識されず、以下の書き方なら認識される。
vim.api.nvim_set_keymap('n', '<C-=>', '<cmd>vertical resize +2<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-_>', '<cmd>vertical resize -2<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-S-=>', '<cmd>resize +2<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-S-->', '<cmd>resize -2<CR>', { noremap = true })
