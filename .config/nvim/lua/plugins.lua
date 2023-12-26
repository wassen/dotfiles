vim.cmd.packadd "packer.nvim"

require("packer").startup(function(use)
	-- Hdwciwuse?kD {ldf(i lsr'"f"a ?kD}
	use { "wbthomason/packer.nvim" }

	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'nvim-tree/nvim-web-devicons' },
	}
	use 'neovim/nvim-lspconfig'
	use 'williamboman/mason.nvim'
	use 'williamboman/mason-lspconfig.nvim'
	use { 'akinsho/nvim-bufferline.lua', tag = "*", requires = 'nvim-tree/nvim-web-devicons' }
	-- require nerd font. see https://github.com/ryanoasis/nerd-fonts#patched-fonts
	use { 'lukas-reineke/indent-blankline.nvim' }
	use { 'nvim-treesitter/nvim-treesitter' }
	use { 'machakann/vim-sandwich' }

	use { "w0ng/vim-hybrid" }
	use { "ellisonleao/gruvbox.nvim", opt = true }
	use { 'folke/tokyonight.nvim', opt = true }

	use { 'ibhagwan/fzf-lua',
		-- optional for icon support
		requires = { 'kyazdani42/nvim-web-devicons' }
	}
	use { 'lambdalisue/fern.vim' }
end)
