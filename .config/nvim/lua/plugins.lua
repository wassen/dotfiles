return require("lazy").setup({
	-- snacks.nvim（checkhealth警告対応: lazy=false, priority=1000が必要）
	{
		"folke/snacks.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},

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
			{ "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
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
		--
		-- 		opts.desc = "Show line diagnostics"
		-- 		vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, opts)
		--
		-- 		opts.desc = "Show documentation for what is under cursor"
		-- 		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		-- 	end
		--
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
	--
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
	--
	-- 			-- require("luasnip.loaders.from_vscode").lazy_load()
	--
	-- 			cmp.setup({
	-- 				snippet = {
	-- 					expand = function(args)
	-- 						-- luasnip.lsp_expand(args.body)
	-- 					end,
	-- 				},
	--
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
	--
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
	--
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

	-- treesitter (main branch - Neovim 0.11+)
	-- 参考: https://blog.atusy.net/2025/08/10/nvim-treesitter-main-branch/
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").setup({})

			-- 自動ハイライトの有効化
			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("nvim-treesitter-start", {}),
				callback = function()
					pcall(vim.treesitter.start)
					-- インデントの有効化
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
		end,
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
	-- { "MagicDuck/grug-far.nvim" },

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

	-- oil.nvim（ファイルマネージャー）
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("oil").setup({
				default_file_explorer = true,
				view_options = {
					show_hidden = true,
				},
				keymaps = {
					["g?"] = "actions.show_help",
					["<CR>"] = "actions.select",
					["-"] = "actions.parent",
					["_"] = "actions.open_cwd",
					["`"] = "actions.cd",
					["~"] = "actions.tcd",
					["gs"] = "actions.change_sort",
					["gx"] = "actions.open_external",
					["g."] = "actions.toggle_hidden",
				},
			})
			vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
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
	{
		"lewis6991/gitsigns.nvim",
		version = "*",
		-- claudecode.nvimとの相性が悪い。
		-- そして、claudecodeと関係なく、ファイルを開いたり保存したりする度にエラーになる。（100％ではない）
		-- filetypeを限定することで回避できる
		ft = { "swift", "dart", "lua" },
		config = function()
			require("gitsigns").setup({
				on_attach = function(bufnr)
					local gitsigns = require("gitsigns")

					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						-- 右側に hover 専用ウインドウを作る handler
						vim.lsp.handlers["textDocument/hover"] = function(err, result, ctx, config)
							if err then
								return
							end
							if not (result and result.contents) then
								return
							end

							-- すでに開いている場合は reuse
							local win = vim.g.hover_win
							local buf = vim.g.hover_buf

							if not (win and vim.api.nvim_win_is_valid(win)) then
								-- 新しいバッファ・ウインドウを作成
								buf = vim.api.nvim_create_buf(false, true)
								vim.g.hover_buf = buf

								vim.cmd("vsplit")
								win = vim.api.nvim_get_current_win()
								vim.g.hover_win = win
							end

							-- hover 内容を書き込む
							local markdown_lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
							markdown_lines = vim.lsp.util.trim_empty_lines(markdown_lines)
							vim.api.nvim_buf_set_lines(buf, 0, -1, false, markdown_lines)

							-- buffer を右側ウインドウに設定
							vim.api.nvim_win_set_buf(win, buf)
							vim.api.nvim_win_set_option(win, "wrap", true)
						end
						vim.keymap.set(mode, l, r, opts)
					end

					-- Navigation
					map("n", "]c", function()
						if vim.wo.diff then
							vim.cmd.normal({ "]c", bang = true })
						else
							gitsigns.nav_hunk("next")
						end
					end)

					map("n", "[c", function()
						if vim.wo.diff then
							vim.cmd.normal({ "[c", bang = true })
						else
							gitsigns.nav_hunk("prev")
						end
					end)

					-- Actions
					map("n", "<leader>hs", gitsigns.stage_hunk)
					map("n", "<leader>hr", gitsigns.reset_hunk)
					map("v", "<leader>hs", function()
						gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end)
					map("v", "<leader>hr", function()
						gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end)
					map("n", "<leader>hS", gitsigns.stage_buffer)
					map("n", "<leader>hu", gitsigns.undo_stage_hunk)
					map("n", "<leader>hR", gitsigns.reset_buffer)
					map("n", "<leader>hp", gitsigns.preview_hunk)
					map("n", "<leader>hb", function()
						gitsigns.blame_line({ full = true })
					end)
					map("n", "<leader>tb", gitsigns.toggle_current_line_blame)
					map("n", "<leader>hd", gitsigns.diffthis)
					map("n", "<leader>hD", function()
						gitsigns.diffthis("~")
					end)
					map("n", "<leader>td", gitsigns.toggle_deleted)

					-- Text object
					map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
				end,
			})
		end,
	},

	-- neogit（Git操作）
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- 必須
			"sindrets/diffview.nvim", -- 差分表示の強化
			"nvim-telescope/telescope.nvim", -- Telescope統合
		},
		config = function()
			require("neogit").setup({
				integrations = {
					diffview = true, -- diffview.nvimと統合
					telescope = true, -- Telescopeと統合
				},
			})
			-- キーマップ
			vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<CR>", { desc = "Neogit" })
			vim.keymap.set("n", "<leader>gc", "<cmd>Neogit commit<CR>", { desc = "Git commit" })
			vim.keymap.set("n", "<leader>gp", "<cmd>Neogit push<CR>", { desc = "Git push" })
			vim.keymap.set("n", "<leader>gl", "<cmd>Neogit pull<CR>", { desc = "Git pull" })
		end,
	},

	-- nvim-notify（通知UI）
	{
		"rcarriga/nvim-notify",
		config = function()
			require("notify").setup({
				background_colour = "#000000", -- 背景色を指定（透明非対応のため黒を使用）
			})
		end,
	},

	-- noice.nvim（コマンドライン・メッセージUIの改善）
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		opts = {
			lsp = {
				-- LSPのUIをnoiceで上書き
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			presets = {
				bottom_search = false, -- 検索を下部に表示
				command_palette = true, -- コマンドパレットスタイル
				long_message_to_split = false, -- 長いメッセージを分割表示
				inc_rename = false, -- inc-rename.nvim用（未使用）
				lsp_doc_border = true, -- LSPドキュメントにボーダーを付ける
			},
		},
	},

	-- which-key（キーバインドのヘルプ表示）
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			-- which-keyの設定
		},
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)
			-- グループ名の設定
			wk.add({
				{ "<leader>x", group = "Xcodebuild" },
				{ "<leader>a", group = "AI/Claude" },
				{ "<leader>g", group = "Git" },
				{ "<leader>h", group = "Git Hunk" },
				{ "<leader>l", group = "Telescope" },
				{ "<leader>b", group = "Buffer" },
				{ "<leader>k", group = "Highlighter" },
				{ "<leader>t", group = "Toggle/Test" },
				{ "<leader>d", group = "Debug" },
			})
		end,
	},

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
				integrations = {
					pymobiledevice = {
						enabled = true,
					},
				},
			})

			vim.keymap.set("n", "<leader>xl", "<cmd>XcodebuildToggleLogs<cr>", { desc = "Toggle Xcodebuild Logs" })
			vim.keymap.set("n", "<leader>xb", "<cmd>XcodebuildBuild<cr>", { desc = "Build Project" })
			vim.keymap.set("n", "<leader>xr", "<cmd>XcodebuildBuildRun<cr>", { desc = "Build & Run Project" })
			vim.keymap.set("n", "<leader>xt", "<cmd>XcodebuildTest<cr>", { desc = "Run Tests" })
			vim.keymap.set("n", "<leader>xT", "<cmd>XcodebuildTestClass<cr>", { desc = "Run This Test Class" })
			vim.keymap.set("n", "<leader>X", "<cmd>XcodebuildPicker<cr>", { desc = "Show All Xcodebuild Actions" })
			vim.keymap.set("n", "<leader>xd", "<cmd>XcodebuildSelectDevice<cr>", { desc = "Select Device" })
			vim.keymap.set("n", "<leader>xs", "<cmd>XcodebuildSelectScheme<cr>", { desc = "Select Scheme" })
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

	-- nvim-dap (デバッガ)
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"wojciech-kulik/xcodebuild.nvim",
		},
		config = function()
			local xcodebuild = require("xcodebuild.integrations.dap")
			local dap = require("dap")

			xcodebuild.setup()

			-- デバッグ関連キーバインド
			vim.keymap.set("n", "<leader>dd", xcodebuild.build_and_debug, { desc = "Build & Debug" })
			vim.keymap.set("n", "<leader>dr", xcodebuild.debug_without_build, { desc = "Debug Without Building" })
			vim.keymap.set("n", "<leader>dt", xcodebuild.debug_tests, { desc = "Debug Tests" })
			vim.keymap.set("n", "<leader>dT", xcodebuild.debug_class_tests, { desc = "Debug Class Tests" })
			vim.keymap.set("n", "<leader>db", xcodebuild.toggle_breakpoint, { desc = "Toggle Breakpoint" })
			vim.keymap.set(
				"n",
				"<leader>dB",
				xcodebuild.toggle_message_breakpoint,
				{ desc = "Toggle Message Breakpoint" }
			)
			vim.keymap.set("n", "<leader>dx", xcodebuild.terminate_session, { desc = "Terminate Debugger" })

			-- 標準のDAPキーバインド
			vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue" })
			vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step Over" })
			vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step Into" })
			vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "Step Out" })
		end,
	},

	-- nvim-dap-ui (デバッグUI)
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			dapui.setup()

			-- デバッグセッション開始時に自動でUIを開く
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			-- DAP UIトグルキーバインド
			vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle DAP UI" })
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
--
