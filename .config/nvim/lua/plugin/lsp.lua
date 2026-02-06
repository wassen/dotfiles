local function on_attach(_, bufnr)
	local opts = { silent = true, noremap = true }

	vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-]>", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	-- vim.lsp.buf.references()だとQuickfixListが開いてしまい、Telescopeの単一ジャンプの挙動と異なるためTelescopeを使用
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>lr", "<cmd>Telescope lsp_references<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>lR", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)

	-- Telescopeはファイル内全体を開く、こちらはカーソル下のみ
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ld", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)

	-- Telescopeで良い
	-- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

	-- 		opts.desc = "Show documentation for what is under cursor"
	-- 		vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
end

-- autotriggerがかなり突拍子なく発生する
-- vim.api.nvim_create_autocmd("LspAttach", {
-- 	callback = function(ev)
-- 		local client = vim.lsp.get_client_by_id(ev.data.client_id)
-- 		if client and client:supports_method("textDocument/completion") then
-- 			vim.lsp.completion.enable(
-- 				true,
-- 				client.id,
-- 				ev.buf,
-- 				{ autotrigger = true }
-- 			)
-- 		end
-- 	end,
-- })

vim.lsp.enable("lua_ls")
vim.lsp.config("lua_ls", {
	on_attach = on_attach,
})

vim.lsp.enable("dartls")
vim.lsp.config("dartls", {
	cmd = { "fvm", "dart", "language-server", "--protocol=lsp" },
	filetypes = { "dart" },
	init_options = {
		closingLabels = true,
		flutterOutline = true,
		onlyAnalyzeProjectsWithOpenFiles = true,
		outline = true,
		suggestFromUnimportedLibraries = true,
	},
	-- root_dir = root_pattern("pubspec.yaml"),
	settings = {
		dart = {
			completeFunctionCalls = true,
			showTodos = true,
			lineLength = 120,
		},
	},
	on_attach = on_attach,
})

vim.lsp.enable("sourcekit")
vim.lsp.config("sourcekit", {
	cmd = {
		"xcrun",
		"sourcekit-lsp",
		"-Xswiftc",
		"-sdk",
		"-Xswiftc",
		"/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator26.1.sdk",
		"-Xswiftc",
		"-target",
		"-Xswiftc",
		"x86_64-apple-ios17.5-simulator",
	},
	filetypes = { "swift" },
	on_attach = on_attach,
})

-- フォーマッターはconform.nvim
