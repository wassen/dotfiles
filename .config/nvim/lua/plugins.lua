return require("lazy").setup({
	-- copilot
	{
		"github/copilot.vim",
		config = function()
			vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("\\<CR>")', {
				expr = true,
				replace_keycodes = false,
			})

			-- copilot-accept-line もお好みで
			vim.keymap.set("i", "<C-L>", "<Plug>(copilot-accept-word)")
			vim.keymap.set("i", "<C-]>", "<Plug>(copilot-dismiss)")
			vim.api.nvim_set_keymap("i", "M-[", '<cmd>lua require("copilot").next()<CR>', {
				noremap = true,
			})
			vim.api.nvim_set_keymap("i", "M-]", '<cmd>lua require("copilot").previous()<CR>', {
				noremap = true,
			})
			vim.g.copilot_no_tab_map = true
		end,
	},

	-- claudecode (coder/claudecode.nvim)
	-- 画面分割の問題: vertical_split=falseにするとファイル、diff-prev、diff-afterが全て縦に並んでしまう
	-- 理想の配置（ファイル・diff-prevが横並び、diff-afterがその下）が実現できないが、
	-- diff編集機能が必要なため、このプラグインを使用する
	{
		"coder/claudecode.nvim",
		dependencies = { "folke/snacks.nvim" },
		opts = {
			terminal = {
				split_width_percentage = 0.30, -- ターミナルの幅（デフォルト: 0.30）
			},
			diff_opts = {
				vertical_split = true, -- 横並び（デフォルト）
				open_in_current_tab = false, -- 別タブでdiffを開く
			},
		},
		keys = {
			{ "<leader>ac", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" }, -- 常にresumeで起動
			{ "<leader>aC", "<cmd>ClaudeCode<cr>", desc = "New Claude session" }, -- 新規セッション
			{ "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
		},
	},

	-- claude-code (greggh/claude-code.nvim)
	-- diff編集機能がないため不採用
	-- {
	-- 	"greggh/claude-code.nvim",
	-- 	dependencies = { "nvim-lua/plenary.nvim" },
	-- 	config = function()
	-- 		require("claude-code").setup({
	-- 			-- デフォルトキーマップを使用
	-- 		})
	-- 	end,
	-- },

	-- conform.nvim (フォーマッター)
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
	},

	-- lualine
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	-- LSP 周辺
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			-- "hrsh7th/cmp-nvim-lsp",
			{ "antosha417/nvim-lsp-file-operations", config = true },
		},
		-- config = function()
		-- 	-- local cmp_nvim_lsp = require("cmp_nvim_lsp")
		-- 	-- local capabilities = cmp_nvim_lsp.default_capabilities()
		-- 	local opts = { noremap = true, silent = true }
		-- 	local on_attach = function(_, bufnr)
		-- 		opts.buffer = bufnr

		-- 		opts.desc = "Show line diagnostics"
		-- 		vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, opts)

		-- 		opts.desc = "Show documentation for what is under cursor"
		-- 		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		-- 	end

		-- 	vim.lsp.config("sourcekit", {
		-- 		-- capabilities = capabilities,
		-- 		on_attach = on_attach,
		-- 	})
		-- end,
	},
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
	},
	{ "williamboman/mason-lspconfig.nvim" },
	-- {
	-- 	{

	-- 		"hrsh7th/nvim-cmp",
	-- 		event = "InsertEnter",
	-- 		dependencies = {
	-- 			-- "hrsh7th/cmp-nvim-lsp",
	-- 			-- "hrsh7th/cmp-buffer",
	-- 			-- "hrsh7th/cmp-path",
	-- 			-- "hrsh7th/cmp-nvim-lua",
	-- 			-- "L3MON4D3/LuaSnip",
	-- 			-- "saadparwaiz1/cmp_luasnip",
	-- 			-- "rafamadriz/friendly-snippets",
	-- 		},
	-- 		config = function()
	-- 			local cmp = require("cmp")
	-- 			-- local luasnip = require("luasnip")

	-- 			-- require("luasnip.loaders.from_vscode").lazy_load()

	-- 			cmp.setup({
	-- 				snippet = {
	-- 					expand = function(args)
	-- 						-- luasnip.lsp_expand(args.body)
	-- 					end,
	-- 				},

	-- 				-- c-n, c-pを汚染する。行儀が悪すぎる
	-- 				mapping = cmp.mapping.preset.insert({
	-- 					["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
	-- 					["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
	-- 					-- ["<C-Space>"] = cmp.mapping.complete(),
	-- 					-- ["<CR>"] = cmp.mapping.confirm({ select = false }),
	-- 					-- ["<Tab>"] = cmp.mapping(function(fallback)
	-- 					-- 	if cmp.visible() then
	-- 					-- 		cmp.select_next_item()
	-- 					-- 		-- elseif luasnip.expand_or_jumpable() then
	-- 					-- 		-- luasnip.expand_or_jump()
	-- 					-- 	else
	-- 					-- 		fallback()
	-- 					-- 	end
	-- 					-- end, { "i", "s" }),

	-- 					-- ["<S-Tab>"] = cmp.mapping(function(fallback)
	-- 					-- 	if cmp.visible() then
	-- 					-- 		cmp.select_prev_item()
	-- 					-- 		-- elseif luasnip.jumpable(-1) then
	-- 					-- 		-- luasnip.jump(-1)
	-- 					-- 	else
	-- 					-- 		fallback()
	-- 					-- 	end
	-- 					-- end, { "i", "s" }),
	-- 				}),

	-- 				sources = cmp.config.sources({
	-- 					{ name = "nvim_lsp" },
	-- 					-- { name = "luasnip" },
	-- 					-- { name = "nvim_lua" },
	-- 					-- { name = "path" },
	-- 				}, {
	-- 					-- { name = "buffer" },
	-- 				}),
	-- 			})
	-- 		end,
	-- 	},
	-- },
	{
		"nvimtools/none-ls.nvim",
		-- lsp 非互換のフォーマッタやリンターをLSPとして扱うためのプラグイン
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	-- bufferline
	{
		"akinsho/nvim-bufferline.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	-- indent-blankline
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		opts = {},
	},

	-- treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},

	-- vim-sandwich
	{ "machakann/vim-sandwich" },

	-- colorschemes
	{
		"w0ng/vim-hybrid",
		lazy = true,
	},
	{
		"ellisonleao/gruvbox.nvim",
		lazy = true,
	},
	{
		"morhetz/gruvbox",
		lazy = true,
	},
	{
		"folke/tokyonight.nvim",
		lazy = true,
	},

	-- grug-far
	{ "MagicDuck/grug-far.nvim" },

	-- fzf-lua
	{
		"ibhagwan/fzf-lua",
		dependencies = { "kyazdani42/nvim-web-devicons" },
	},

	-- fern
	{
		"lambdalisue/fern.vim",
		config = function()
			vim.g["fern#default_hidden"] = 1
		end,
	},

	-- telescope
	{
		"nvim-telescope/telescope.nvim",
		version = "0.1.9",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup({
				defaults = {
					sorting_strategy = "ascending",
					layout_config = { prompt_position = "top" },
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},

	{ "nvim-telescope/telescope-ui-select.nvim" },

	-- highlighter
	{ "azabiong/vim-highlighter" },

	-- trouble
	{ "folke/trouble.nvim" },

	-- dart
	{
		"dart-lang/dart-vim-plugin",
		ft = "dart",
	},

	-- gitsigns
	-- { "lewis6991/gitsigns.nvim" },

	-- sourcekit-lsp
	{ "swiftlang/sourcekit-lsp" },
	{
		"wojciech-kulik/xcodebuild.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("xcodebuild").setup({
				logs = {
					logs_formatter = nil,
				},
				code_coverage = {
					enabled = true,
				},
			})

			vim.keymap.set("n", "<leader>xl", "<cmd>XcodebuildToggleLogs<cr>", { desc = "Toggle Xcodebuild Logs" })
			vim.keymap.set("n", "<leader>xb", "<cmd>XcodebuildBuild<cr>", { desc = "Build Project" })
			vim.keymap.set("n", "<leader>xr", "<cmd>XcodebuildBuildRun<cr>", { desc = "Build & Run Project" })
			vim.keymap.set("n", "<leader>xt", "<cmd>XcodebuildTest<cr>", { desc = "Run Tests" })
			vim.keymap.set("n", "<leader>xT", "<cmd>XcodebuildTestClass<cr>", { desc = "Run This Test Class" })
			vim.keymap.set("n", "<leader>X", "<cmd>XcodebuildPicker<cr>", { desc = "Show All Xcodebuild Actions" })
			vim.keymap.set("n", "<leader>xd", "<cmd>XcodebuildSelectDevice<cr>", { desc = "Select Device" })
			vim.keymap.set("n", "<leader>xp", "<cmd>XcodebuildSelectTestPlan<cr>", { desc = "Select Test Plan" })
			vim.keymap.set(
				"n",
				"<leader>xc",
				"<cmd>XcodebuildToggleCodeCoverage<cr>",
				{ desc = "Toggle Code Coverage" }
			)
			vim.keymap.set(
				"n",
				"<leader>xC",
				"<cmd>XcodebuildShowCodeCoverageReport<cr>",
				{ desc = "Show Code Coverage Report" }
			)
			vim.keymap.set("n", "<leader>xq", "<cmd>Telescope quickfix<cr>", { desc = "Show QuickFix List" })
		end,
	},
})

-- require("packer").startup(function(use)
-- 	use { "wbthomason/packer.nvim" }
-- 	use {
-- 		"github/copilot.vim",
-- 		-- insertモードでのキーマッピングを設定する
-- 		config = function()
-- 			-- 必要に応じて設定を記載
-- 			-- vim.g.copilot_no_tab_map = true
-- 			vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
-- 		end
-- 	}
--
-- 	use {
-- 		'nvim-lualine/lualine.nvim',
-- 		requires = { 'nvim-tree/nvim-web-devicons' },
-- 	}
-- 	use 'neovim/nvim-lspconfig'
-- 	use 'williamboman/mason.nvim'
-- 	use 'williamboman/mason-lspconfig.nvim'
--
-- 	use { 'akinsho/nvim-bufferline.lua', requires = 'nvim-tree/nvim-web-devicons' }
-- 	-- require nerd font. see https://github.com/ryanoasis/nerd-fonts#patched-fonts
--
-- 	-- vim.opt.list = trueでハードタブの表示がおかしくなる問題がある
-- 	use { 'lukas-reineke/indent-blankline.nvim' }
-- 	use { 'nvim-treesitter/nvim-treesitter' }
-- 	use { 'machakann/vim-sandwich' }
--
-- 	use { "w0ng/vim-hybrid" }
-- 	use { "ellisonleao/gruvbox.nvim", opt = true }
-- 	-- config = function() vim.cmd.colorscheme("gruvbox") end,
-- 	use { 'morhetz/gruvbox', opt = true }
-- 	use { 'folke/tokyonight.nvim', opt = true }
--
-- 	use { 'MagicDuck/grug-far.nvim' }
--
-- 	use {
-- 		'ibhagwan/fzf-lua',
-- 		-- optional for icon support
-- 		requires = { 'kyazdani42/nvim-web-devicons' }
-- 	}
-- 	use { 'lambdalisue/fern.vim' }
-- 	use {
-- 		'nvim-telescope/telescope.nvim',
-- 		tag = 'v0.1.9',
-- 		requires = {
-- 			{ 'nvim-lua/plenary.nvim' },
-- 		},
-- 	}
--
-- 	use { 'azabiong/vim-highlighter' }
-- 	use { 'nvim-telescope/telescope-ui-select.nvim' }
-- 	use { 'folke/trouble.nvim' }
-- 	use {
-- 		'dart-lang/dart-vim-plugin',
-- 		ft = 'dart'
-- 	}
-- 	use { 'lewis6991/gitsigns.nvim' }
--
-- 	-- sourcekit-lsp
-- 	use { 'swiftlang/sourcekit-lsp' }
-- end)
--
-- -- PackerSyncを24時間に1回自動実行する関数
-- local function should_sync()
-- 	local cache_file = vim.fn.stdpath("cache") .. "/last_packer_update"
-- 	local last = vim.fn.getftime(cache_file)
-- 	local now = os.time()
--
-- 	if 24 * 60 * 60 <= now - last then
-- 		vim.fn.writefile({ os.date() }, cache_file)
-- 		return true
-- 	end
-- 	return false
-- end
--
-- local function is_git_commit_edit()
-- 	for _, arg in ipairs(vim.fn.argv()) do
-- 		if arg:match("COMMIT_EDITMSG$") then
-- 			return true
-- 		end
-- 	end
-- 	return false
-- end
--
-- vim.api.nvim_create_autocmd("VimEnter", {
-- 	callback = function()
-- 		if is_git_commit_edit() then
-- 			return
-- 		end
--
-- 		if should_sync() then
-- 			-- print("Running PackerSync...")
-- 			-- local current_win = vim.api.nvim_get_current_win()
--
-- 			-- sync後にウィンドウを戻すためのautocmdを登録
-- 			-- local group = vim.api.nvim_create_augroup("PackerSyncWinRestore", { clear = true })
--
-- 			-- vim.api.nvim_create_autocmd("User", {
-- 			-- 	group = group,
-- 			-- 	pattern = "PackerComplete",
-- 			-- 	callback = function()
-- 			-- 		-- packerウィンドウが開かれていても、元のウィンドウへ戻す
-- 			-- 		if vim.api.nvim_win_is_valid(current_win) then
-- 			-- 			vim.api.nvim_set_current_win(current_win)
-- 			-- 		end
-- 			-- 		vim.api.nvim_del_augroup_by_id(group)
-- 			-- 	end
-- 			-- })
-- 			-- syncと悩み中
-- 			require('packer').update()
-- 		end
-- 	end
-- })
--
--
-- require("telescope").setup {
-- 	defaults = {
-- 		sorting_strategy = "ascending", -- 上→下に並ぶ
-- 		layout_config = {
-- 			prompt_position = "top", -- 検索窓を上に
-- 		},
-- 	},
-- 	extensions = {
-- 		["ui-select"] = {
-- 			require("telescope.themes").get_dropdown {
-- 				-- even more opts
-- 			}
--
-- 			-- pseudo code / specification for writing custom displays, like the one
-- 			-- for "codeactions"
-- 			-- specific_opts = {
-- 			--   [kind] = {
-- 			--     make_indexed = function(items) -> indexed_items, width,
-- 			--     make_displayer = function(widths) -> displayer
-- 			--     make_display = function(displayer) -> function(e)
-- 			--     make_ordinal = function(e) -> string
-- 			--   },
-- 			--   -- for example to disable the custom builtin "codeactions" display
-- 			--      do the following
-- 			--   codeactions = false,
-- 			-- }
-- 		}
-- 	}
-- }
-- -- To get ui-select loaded and working with telescope, you need to call
-- -- load_extension, somewhere after setup function:
-- require("telescope").load_extension("ui-select")
--
--
--
--
