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
-- see also :help 'tabstop'
-- 5. Always set 'tabstop' and 'shiftwidth' to the same value, and
--    'noexpandtab'.  This should then work (for initial indents only)
--    for any tabstop setting that people use.  It might be nice to have
--    tabs after the first non-blank inserted as spaces if you do this
--    though.  Otherwise aligned comments will be wrong when 'tabstop' is
--    changed.
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false
-- vim.bo.softtabstop = 4

-- 3. Set 'tabstop' and 'shiftwidth' to whatever you prefer and use
--    'expandtab'.  This way you will always insert spaces.  The
--    formatting will never be messed up when 'tabstop' is changed.
--    You do need to check if no Tabs exist in the file, just like in the
--    item just above.
-- vim.opt.tabstop = 4      -- タブ文字を表示する際の幅を4スペースに設定
-- vim.opt.shiftwidth = 4   -- 自動インデントや<<、>>コマンドでの移動幅を4スペースに設定
-- vim.opt.expandtab = true -- タブをスペースに展開する設定


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

-- cursor
vim.o.guicursor = "n:hor25,i:ver25,v:block"

-- dictionary (C-x C-k)
-- Mac
local dict_path = "/usr/share/dict/words"
if vim.fn.filereadable(dict_path) == 1 then
	vim.opt.dictionary:append(dict_path)
end
