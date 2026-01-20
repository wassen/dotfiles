local function git_relative_path()
	local filepath = vim.fn.expand('%:p')
	if filepath == '' then
		return '[No Name]'
	end

	local git_root = vim.fn.systemlist('git -C ' .. vim.fn.shellescape(vim.fn.expand('%:p:h')) .. ' rev-parse --show-toplevel')[1]
	if vim.v.shell_error ~= 0 or git_root == nil or git_root == '' then
		return vim.fn.expand('%:t')
	end

	local git_root_name = vim.fn.fnamemodify(git_root, ':t')

	if vim.startswith(filepath, git_root) then
		local path_from_root = filepath:sub(#git_root + 2)
		return git_root_name .. '/' .. path_from_root
	else
		return vim.fn.expand('%:t')
	end
end

require('lualine').setup {
	options = {
		icons_enabled = true,
		theme = 'auto',
		component_separators = { left = '', right = '' },
		section_separators = { left = '', right = '' },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		globalstatus = false,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		}
	},
	sections = {
		lualine_a = { 'mode' },
		lualine_b = { 'branch', 'diff', 'diagnostics' },
		lualine_c = { { git_relative_path } },
		lualine_x = { 'encoding', 'fileformat', 'filetype' },
		lualine_y = { 'progress' },
		lualine_z = { 'location' },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { { git_relative_path } },
		lualine_x = { 'location' },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {},
}