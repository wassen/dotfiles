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

	-- bufferlineの選択状態が分かりづらいもんだい
	-- smartcase
	-- Escで検索ハイライトの削除
	-- omni funcでscreenが開かれるのがうざい。Telescopeで出してくれ
	use { 'akinsho/nvim-bufferline.lua', tag = "*", requires = 'nvim-tree/nvim-web-devicons' }
	-- require nerd font. see https://github.com/ryanoasis/nerd-fonts#patched-fonts
	use { 'lukas-reineke/indent-blankline.nvim' }
	use { 'nvim-treesitter/nvim-treesitter' }
	use { 'machakann/vim-sandwich' }

	use { "w0ng/vim-hybrid" }
	use { "ellisonleao/gruvbox.nvim", opt = true }
	use { 'folke/tokyonight.nvim', opt = true }

	use {
		'ibhagwan/fzf-lua',
		-- optional for icon support
		requires = { 'kyazdani42/nvim-web-devicons' }
	}
	use { 'lambdalisue/fern.vim' }
	use {
		'nvim-telescope/telescope.nvim',
		requires = {
			{ 'nvim-lua/plenary.nvim' },
		},
	}

	use { 'azabiong/vim-highlighter' }
	use { 'nvim-telescope/telescope-ui-select.nvim' }
	use {
		'dart-lang/dart-vim-plugin',
		ft = 'dart'
	}
end)
