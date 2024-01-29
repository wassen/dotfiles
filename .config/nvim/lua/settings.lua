vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.cursorline = true

-- bufferline等
vim.opt.termguicolors = true

-- blanklineが壊れるため一旦コメントアウト。trailは有用なのでこっちだけ反映させたい
-- vim.wo.list = true
-- vim.opt.listchars = {
--     -- tab = '▸ ',
--     trail = '·',
-- }

-- タブの幅
vim.opt.tabstop = 4
vim.opt.tabstop = 4      -- タブ文字を表示する際の幅を4スペースに設定
vim.opt.shiftwidth = 4   -- 自動インデントや<<、>>コマンドでの移動幅を4スペースに設定
vim.opt.expandtab = true -- タブをスペースに展開する設定

vim.api.nvim_create_autocmd("FileType", {
	pattern = "lua",
	callback = function()
		vim.bo.tabstop = 4
		vim.bo.shiftwidth = 4
		vim.bo.expandtab = false
	end,
})
