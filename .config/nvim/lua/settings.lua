-- 行番号の表示
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.cursorline = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

-- bufferline等
vim.opt.termguicolors = true

-- blanklineが壊れる。trailは有用なのでこっちだけ反映させたいがむずかしそうか
vim.opt.list = true
vim.opt.listchars = {
	tab = '▸ ',
	multispace = '·',
}

-- タブの幅
vim.opt.tabstop = 4
vim.opt.tabstop = 4		 -- タブ文字を表示する際の幅を4スペースに設定
vim.opt.shiftwidth = 4	 -- 自動インデントや<<、>>コマンドでの移動幅を4スペースに設定
vim.opt.expandtab = true -- タブをスペースに展開する設定

-- cursor
vim.o.guicursor = "n:hor25,i:ver25,v:block"

vim.api.nvim_create_autocmd("FileType", {
	pattern = "lua",
	callback = function()
		vim.bo.tabstop = 4
		vim.bo.shiftwidth = 4
		vim.bo.expandtab = false
	end,
})

vim.api.nvim_create_augroup("gitcommit", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	group = "gitcommit",
	pattern = "gitcommit",
	callback = function()
		vim.opt_local.textwidth = 0
		vim.opt_local.expandtab = true
		vim.opt_local.tabstop = 2
		vim.opt_local.softtabstop = 2
		vim.opt_local.shiftwidth = 2
	end
})
