local conform = require("conform")

conform.setup({
	formatters_by_ft = {
		swift = { "swiftformat" },
		lua = { "stylua" },
		dart = { "dart_format" },
	},
	formatters = {
		swiftformat = {
			command = function()
				local custom_path = "Player/.build/swiftformat"
				if vim.fn.executable(custom_path) == 1 then
					return custom_path
				end
				return "swiftformat"
			end,
		},
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
})