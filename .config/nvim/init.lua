-- TODO: nvim 0.11対応
local function safe_require(module, callback)
	local status, result = pcall(function()
		if callback then
			return callback()
		else
			return require(module)
		end
	end)
	if not status then
		vim.notify("Error loading " .. module .. ": " .. result, vim.log.levels.ERROR)
	end
	return status, result
end

safe_require("keybinds")

safe_require("lazy.nvim setup", function()
	local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
	if not vim.loop.fs_stat(lazypath) then
		vim.fn.system({
			"git",
			"clone",
			"--filter=blob:none",
			"https://github.com/folke/lazy.nvim.git",
			lazypath,
		})
	end
	vim.opt.rtp:prepend(lazypath)
	require("plugins")
end)

-- gfでファイルジャンプ可能
safe_require("settings")
safe_require("filetypes")
safe_require("plugin/lualine")
safe_require("plugin/bufferline")
safe_require("view")
safe_require("plugin/lsp")
-- safe_require("plugin/null-ls")
safe_require("plugin/conform")

vim.filetype.add({
	filename = {
		["Fastfile"] = "ruby",
	},
})

vim.cmd([[autocmd CompleteDone * pclose]])

-- 1. LSP Sever management
-- 言語固有は遅延したほうが良いか？

vim.diagnostic.config({ virtual_text = true })

require("mason").setup()
-- require('mason-lspconfig').setup_handlers({ function(server)
-- 	local opt = {
-- 		{
-- 			{
-- 				{
-- 					-- a
--
-- 				}
-- 			}
-- 		}
--
-- 		-- -- Function executed when the LSP server startup
-- 		-- on_attach = function(client, bufnr)
-- 		--   local opts = { noremap=true, silent=true }
-- 		--   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
-- 		--   vim.cmd 'autocmd BufWritePre * lua vim.lsp.buf.formatting_sync(nil, 1000)'
-- 		-- end,
-- 		-- capabilities = require('cmp_nvim_lsp').update_capabilities(
-- 		-- vim.lsp.protocol.make_client_capabilities()
-- 		-- )
-- 	}
-- 	require('lspconfig')[server].setup(opt)
-- end })

-- require("gitsigns").setup({
-- 	on_attach = function(bufnr)
-- 		local gitsigns = require("gitsigns")
--
-- 		-- local function map(mode, l, r, opts)
-- 		-- 	opts = opts or {}
-- 		-- 	opts.buffer = bufnr
-- 		-- 	-- 右側に hover 専用ウインドウを作る handler
-- 		-- 	vim.lsp.handlers["textDocument/hover"] = function(err, result, ctx, config)
-- 		-- 		if err then return end
-- 		-- 		if not (result and result.contents) then return end
--
-- 		-- 		-- すでに開いている場合は reuse
-- 		-- 		local win = vim.g.hover_win
-- 		-- 		local buf = vim.g.hover_buf
--
-- 		-- 		if not (win and vim.api.nvim_win_is_valid(win)) then
-- 		-- 			-- 新しいバッファ・ウインドウを作成
-- 		-- 			buf = vim.api.nvim_create_buf(false, true)
-- 		-- 			vim.g.hover_buf = buf
--
-- 		-- 			vim.cmd("vsplit")
-- 		-- 			win = vim.api.nvim_get_current_win()
-- 		-- 			vim.g.hover_win = win
-- 		-- 		end
--
-- 		-- 		-- hover 内容を書き込む
-- 		-- 		local markdown_lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
-- 		-- 		markdown_lines = vim.lsp.util.trim_empty_lines(markdown_lines)
-- 		-- 		vim.api.nvim_buf_set_lines(buf, 0, -1, false, markdown_lines)
--
-- 		-- 		-- buffer を右側ウインドウに設定
-- 		-- 		vim.api.nvim_win_set_buf(win, buf)
-- 		-- 		vim.api.nvim_win_set_option(win, "wrap", true)
-- 		-- 	end
-- 		-- 	vim.keymap.set(mode, l, r, opts)
-- 		-- end
--
-- 		-- -- Navigation
-- 		-- map('n', ']c', function()
-- 		-- 	if vim.wo.diff then
-- 		-- 		vim.cmd.normal({ ']c', bang = true })
-- 		-- 	else
-- 		-- 		gitsigns.nav_hunk('next')
-- 		-- 	end
-- 		-- end)
--
-- 		-- map('n', '[c', function()
-- 		-- 	if vim.wo.diff then
-- 		-- 		vim.cmd.normal({ '[c', bang = true })
-- 		-- 	else
-- 		-- 		gitsigns.nav_hunk('prev')
-- 		-- 	end
-- 		-- end)
--
-- 		-- Actions
-- 		-- map('n', '<leader>hs', gitsigns.stage_hunk)
-- 		-- map('n', '<leader>hr', gitsigns.reset_hunk)
-- 		-- map('v', '<leader>hs', function() gitsigns.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
-- 		-- map('v', '<leader>hr', function() gitsigns.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
-- 		-- map('n', '<leader>hS', gitsigns.stage_buffer)
-- 		-- map('n', '<leader>hu', gitsigns.undo_stage_hunk)
-- 		-- map('n', '<leader>hR', gitsigns.reset_buffer)
-- 		-- map('n', '<leader>hp', gitsigns.preview_hunk)
-- 		-- map('n', '<leader>hb', function() gitsigns.blame_line { full = true } end)
-- 		-- map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
-- 		-- map('n', '<leader>hd', gitsigns.diffthis)
-- 		-- map('n', '<leader>hD', function() gitsigns.diffthis('~') end)
-- 		-- map('n', '<leader>td', gitsigns.toggle_deleted)
--
-- 		-- -- Text object
-- 		-- map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
-- 	end,
-- })

-- TODO: bufferlineファイルへ
require("bufferline").setup({
	options = {
		numbers = "both",
		indicator = {
			style = "underline",
		},
	},
})

require("ibl").setup({
	scope = {
		enabled = true,
		show_start = true,
		show_end = true,
	},
})

-- setlocal omnifunc=lsp#complete
-- -- LSP用にマッピング
-- nnoremap <C-]> :LspDefinition<CR>

-- lspの設定を分けたい
-- vim.opt_local.omnifunc = 'v:lua.vim.lsp.omnifunc'

-- デフォルトのレジスタをクリップボードにする
vim.opt_local.clipboard:append({ "unnamedplus" })
-- set clipboard&
-- set clipboard^=unnamedplus

-- *, +のレジスタをWSLのclipboardと繋ぐ (:help clipboard-wsl)
-- local output = vim.fn.system('uname -a | grep microsoft')
-- if output ~= '' then
-- 	vim.g.clipboard = {
-- 		name = 'WslClipboard',
-- 		copy = {
-- 			['+'] = 'clip.exe',
-- 			['*'] = 'clip.exe',
-- 		},
-- 		paste = {
-- 			['+'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
-- 			['*'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
-- 		},
-- 		cache_enabled = 0,
-- 	}
-- end

-- setting
-- 閉じてもundoを出来るようにファイルに保存する
vim.opt.undofile = true
-- ハイフンを区切り文字としない
vim.opt.iskeyword:append({ "-" })
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

-- Winで背景透過がやりたかったがColorSchemeが壊れる
-- vim.api.nvim_set_hl(0, 'Normal', { ctermbg = 'none' })
-- vim.api.nvim_set_hl(0, 'NonText', { ctermbg = 'none' })
-- vim.api.nvim_set_hl(0, 'LineNr', { ctermbg = 'none' })
-- vim.api.nvim_set_hl(0, 'Folded', { ctermbg = 'none' })
-- vim.api.nvim_set_hl(0, 'EndOfBuffer', { ctermbg = 'none' })

-- Command
vim.api.nvim_create_user_command("Vimrc", function()
	vim.cmd("e ~/.config/nvim/init.lua")
end, {})

function MyFruitsPicker()
	local pickers = require("telescope.pickers")
	local finders = require("telescope.finders")
	local sorters = require("telescope.sorters")
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")

	pickers
		.new({}, {
			prompt_title = "Fruits",
			finder = finders.new_table({
				results = { "banana", "apple" },
			}),
			sorter = sorters.get_generic_fuzzy_sorter(),
			attach_mappings = function(prompt_bufnr, map)
				actions.select_default:replace(function()
					local selection = action_state.get_selected_entry()
					print(selection.value)
					actions.close(prompt_bufnr)
				end)
				return true
			end,
		})
		:find()
end

function MyCommandPicker()
	local pickers = require("telescope.pickers")
	local finders = require("telescope.finders")
	local sorters = require("telescope.sorters")
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")

	local commands = {
		{ name = "Edit init.lua", cmd = "e $MYVIMRC" },
		{ name = "Reload init.lua", cmd = "luafile $MYVIMRC" },
	}

	pickers
		.new({}, {
			prompt_title = "My Commands",
			finder = finders.new_table({
				results = commands,
				entry_maker = function(entry)
					return {
						value = entry.cmd,
						display = entry.name,
						ordinal = entry.name,
					}
				end,
			}),
			sorter = sorters.get_generic_fuzzy_sorter(),
			attach_mappings = function(prompt_bufnr, map)
				actions.select_default:replace(function()
					local selection = action_state.get_selected_entry()
					actions.close(prompt_bufnr)
					vim.cmd(selection.value) -- コマンドを実行
				end)
				return true
			end,
		})
		:find()
end

vim.keymap.set("n", "<leader>tt", MyCommandPicker, { noremap = true, silent = true })

local function blameFunc()
	local line_number = vim.fn.line(".")
	vim.cmd("!git log -L" .. line_number .. "," .. line_number .. ":" .. vim.fn.expand("%"))
end

local function blameFunc2()
	local line_number = vim.fn.line(".")
	local tmp_file = vim.fn.tempname()
	-- git logの結果を一時ファイルにリダイレクト
	vim.cmd(
		"silent !git log -p -L" .. line_number .. "," .. line_number .. ":" .. vim.fn.expand("%") .. " > " .. tmp_file
	)
	-- 新しい無名バッファを開く
	vim.cmd("new")
	-- バッファの内容を一時ファイルから読み込む
	vim.cmd("r " .. tmp_file)
	-- 一時ファイルを削除
	vim.cmd("silent !rm " .. tmp_file)
	-- バッファタイプを設定して、Neovimにdiffとして解釈させる
	vim.cmd("setlocal buftype=nofile")
	vim.cmd("setfiletype diff")
end

vim.api.nvim_create_user_command("BLAME", blameFunc2, {})

local function blameFunc3()
	local line_number = vim.fn.line(".")
	local current_file = vim.fn.expand("%")
	local cmd = "git log -L" .. line_number .. "," .. line_number .. ":" .. current_file

	-- 新しいターミナルバッファを開いて、そこでgitコマンドを実行する
	vim.cmd("new | setlocal buftype=nofile | setlocal bufhidden=hide | setlocal noswapfile")
	vim.api.nvim_buf_set_name(0, "git-diff")
	vim.fn.termopen(cmd, { detach = 1 })
end

vim.api.nvim_create_user_command("BLAMET", blameFunc3, {})

-- set dictionary+=/usr/share/dict/words

-- メモ
-- 再読み込み
-- :source $MYVIMRC
-- 変更リストの再読み込み
-- cbuffer←うまくいっていない
-- lua vim.diagnostic.open_float()
-- nvim --startuptime /tmp/nvim.log 起動速度
--

-- 透過設定
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
