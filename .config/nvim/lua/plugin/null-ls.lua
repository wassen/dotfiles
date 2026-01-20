local function executable(cmd)
	return vim.fn.executable(cmd) == 1
end

local null_ls = require("null-ls")
local helpers = require("null-ls.helpers")

local function make_custom()
	return helpers.make_builtin({
		name = "swiftformat_custom",
		method = null_ls.methods.FORMATTING,
		filetypes = { "swift" },
		generator_opts = {
			command = "Player/.build/swiftformat",
			args = {
				"--stdinpath", "$FILENAME",
				"--config", "$ROOT/.swiftformat",
			},
			to_stdin = true,
		},
		factory = helpers.formatter_factory,
	})
end

local function make_builtin()
	return null_ls.builtins.formatting.swiftformat.with({
		extra_args = function(params)
			return {
				"--stdinpath", params.bufname,
				"--config", params.root .. "/.swiftformat",
			}
		end
	})
end


-- undoや変更履歴を壊す？
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*.swift",
	callback = function(args)
		-- local null_ls = require("null-ls")

		-- null_ls.setup({
		-- 	sources = {
		-- 		null_ls.builtins.formatting.swiftformat.with({
		-- 			extra_args = function(params)
		-- 				return {
		-- 					"--stdinpath", params.bufname, -- 必須：stdin の時にファイルパスを伝える
		-- 					"--config", params.root .. "/.swiftformat", -- 必須：設定ファイルを明示
		-- 				}
		-- 			end,
		-- 		}),
		-- 	},
		-- })
		local bufnr = args.buf
		local custom_swiftformatter = "Player/.build/swiftformat"

		local source
		if executable(custom_swiftformatter) then
			source = make_custom()
		else
			source = make_builtin()
		end

		print("Using formatter: " .. source.name)
		-- null_ls.register({ source = source }) -- , bufnr = bufnr })
		null_ls.setup({
			sources = { source },
		})
	end,
})

-- local null_ls = require("null-ls")
--
-- null_ls.setup({
-- 	sources = {
-- 		null_ls.formatter({
-- 			name = "swiftformat_custom",
-- 			command = "./Player/.build/swiftformat",
-- 			args = function(params)
-- 				return {
-- 					"--stdinpath", params.bufname,
-- 					"--config", params.root .. "/.swiftformat",
-- 					"-"
-- 				}
-- 			end,
-- 			to_stdin = true,
-- 			filetypes = { "swift" },
-- 		}),
-- 	},
-- })
--


-- korekore
-- local null_ls = require("null-ls")
-- local helpers = require("null-ls.helpers")
--
-- local swiftformat_custom = helpers.make_builtin({
-- 	name = "swiftformat_custom",
-- 	method = null_ls.methods.FORMATTING,
-- 	filetypes = { "swift" },
--
-- 	generator_opts = {
-- 		command = "Player/.build/swiftformat",
-- 		args = {
-- 			"--stdinpath", "$FILENAME",
-- 			"--config", "$ROOT/.swiftformat",
-- 		},
-- 		to_stdin = true,
-- 	},
-- 	factory = helpers.formatter_factory,
-- })
--
-- null_ls.setup({
-- 	sources = {
-- 		swiftformat_custom,
-- 	},
-- })

-- null_ls.setup({
-- 	sources = {
-- 		{
-- 			name = "swiftformat_custom",
-- 			method = null_ls.methods.FORMATTING,
-- 			filetypes = { "swift" },
-- 			generator = null_ls.generator({
-- 				command = "Player/.build/swiftformat", -- ← 完全にあなたの好きなコマンド
-- 				args = {
-- 					"--config", ".swiftformat",
-- 					"--stdinpath", "$FILENAME",
-- 					"-",
-- 				},
-- 				to_stdin = true,
-- 			}),
-- 		},
-- 	},
-- })

-- local null_ls = require("null-ls")
--
-- null_ls.setup({
-- 	debug = true, -- 問題の切り分け用にログ出るように
-- 	sources = {
-- 		{
-- 			name = "swiftformat_custom",
-- 			method = null_ls.methods.FORMATTING,
-- 			filetypes = { "swift" },
-- 			generator = null_ls.generator({
-- 				command = "./Player/.build/swiftformat",
-- 				args = {
-- 					"--config", ".swiftformat",
-- 					"--stdinpath", "$FILENAME",
-- 					"-",
-- 				},
-- 				to_stdin = true,
-- 			}),
-- 		},
-- 	},
-- })

-- local null_ls = require("null-ls")

-- null_ls.setup({
--
-- 	debug = true, -- 問題の切り分け用にログ出るように
--
-- 	sources = {
-- 		name =
-- 		null_ls.builtins.formatting.swiftformat.with({
-- 			extra_args = function(params)
-- 				return {
-- 					"--config", params.root .. "/.swiftformat",
-- 					"--stdinpath", params.bufname,
-- 				}
-- 			end,
-- 		}),
-- 	},
-- })
-- null_ls.setup({
-- 	sources = {
--
-- 		null_ls.builtins.formatting.swiftformat.with({
-- 			command = "./Player/.build/swiftformatiiiii",
-- 			args = { "--stdinpath", "$FILENAME", "--config", ".swiftformat", "-" },
-- 			cwd = function(params)
-- 				return params.root
-- 			end,
-- 		}),
-- 	},
-- })
