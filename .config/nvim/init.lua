require "plugins"
require "plugin/lualine"
require "keybinds"
require "view"

-- filetypeの指定をしたい
vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]

-- 1. LSP Sever management
require('mason').setup()
require('mason-lspconfig').setup_handlers({ function(server)
	local opt = {
		{
			{
				{
					-- a

				}
			}
		}

		-- -- Function executed when the LSP server startup
		-- on_attach = function(client, bufnr)
		--   local opts = { noremap=true, silent=true }
		--   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
		--   vim.cmd 'autocmd BufWritePre * lua vim.lsp.buf.formatting_sync(nil, 1000)'
		-- end,
		-- capabilities = require('cmp_nvim_lsp').update_capabilities(
		-- vim.lsp.protocol.make_client_capabilities()
		-- )
	}
	require('lspconfig')[server].setup(opt)
end })

require('bufferline').setup {
	options = {
		numbers = "both",
		indicator = {
			style = 'underline',
		},
	},
}

require("ibl").setup()

-- setlocal omnifunc=lsp#complete
-- -- LSP用にマッピング
-- nnoremap <C-]> :LspDefinition<CR>

-- lspの設定を分けたい
-- vim.opt_local.omnifunc = 'v:lua.vim.lsp.omnifunc'

-- デフォルトのレジスタをクリップボードにする
vim.opt_local.clipboard:append { 'unnamedplus' }
-- set clipboard&
-- set clipboard^=unnamedplus

-- *, +のレジスタをWSLのclipboardと繋ぐ (:help clipboard-wsl)
local output = vim.fn.system('uname -a | grep microsoft')
if output ~= '' then
	vim.g.clipboard = {
		name = 'WslClipboard',
		copy = {
			['+'] = 'clip.exe',
			['*'] = 'clip.exe',
		},
		paste = {
			['+'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
			['*'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
		},
		cache_enabled = 0,
	}
end

-- setting
-- 閉じてもundoを出来るようにファイルに保存する
vim.opt.undofile = true
-- タブの幅
-- typescriptとかの個別設定
-- vim.opt.tabstop = 4
-- vim.opt.shiftwidth = 4
-- vim.opt.expandtab = false
-- ハイフンを区切り文字としない
vim.opt.iskeyword:append { '-' }

vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.cursorline = true
vim.opt.list = true
vim.opt.listchars = { tab = '▸ ' }
-- set termguicolors

-- 2. build-in LSP function
-- keyboard shortcut
-- vim.keymap.set('n', 'K',  '<cmd>lua vim.lsp.buf.hover()<CR>')
-- vim.keymap.set('n', 'gf', '<cmd>lua vim.lsp.buf.formatting()<CR>')
-- vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
-- vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
-- vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
-- vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
-- vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
-- vim.keymap.set('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>')
-- vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
-- vim.keymap.set('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>')
-- vim.keymap.set('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<CR>')
-- vim.keymap.set('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
-- LSP handlers
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
-- vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }
-- )
-- Reference highlight
-- vim.cmd [[
-- set updatetime=500
-- highlight LspReferenceText  cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
-- highlight LspReferenceRead  cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
-- highlight LspReferenceWrite cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
-- augroup lsp_document_highlight
--   autocmd!
--   autocmd CursorHold,CursorHoldI * lua vim.lsp.buf.document_highlight()
--   autocmd CursorMoved,CursorMovedI * lua vim.lsp.buf.clear_references()
-- augroup END
-- ]]
-- vim.api.nvim_create_autocmd("BufWritePost", {
--   pattern = { "plugins.lua" },
--   command = "PackerCompile",
-- })


-- Ivim.g.ldf:??

-- vim.g.airline_powerline_fonts = 1
-- vim.g.airline_theme='powerlineish'
-- vim.g['airline#extensions#tabline#enabled'] = 1
-- vim.g['airline_extensions_tabline_buffer_nr_show'] = 1
-- vim.g['airline_extensions_tabline_fnamemod'] = ':t'
-- let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
-- let g:airline#extensions#tabline#buffer_idx_mode = 0


-- 背景透過
vim.api.nvim_set_hl(0, 'Normal', { ctermbg = 'none' })
vim.api.nvim_set_hl(0, 'NonText', { ctermbg = 'none' })
vim.api.nvim_set_hl(0, 'LineNr', { ctermbg = 'none' })
vim.api.nvim_set_hl(0, 'Folded', { ctermbg = 'none' })
vim.api.nvim_set_hl(0, 'EndOfBuffer', { ctermbg = 'none' })

-- Command
vim.api.nvim_create_user_command('Vimrc', function() vim.cmd('e ~/.config/nvim/init.lua') end, {})
