-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function(use)
		-- Packer can manage itself
		use "wbthomason/packer.nvim"

		-- fuzzy finder
		use {
				"nvim-telescope/telescope.nvim", tag = "0.1.1",
				-- or                            , branch = "0.1.x",
				requires = { {"nvim-lua/plenary.nvim"} }
		}

		-- treesitter
		use("nvim-treesitter/nvim-treesitter", {run = ":TSUpdate"})

		-- lsp
		use {
				'VonHeikemen/lsp-zero.nvim',
				branch = 'v1.x',
				requires = {
						-- LSP Support
						{'neovim/nvim-lspconfig'},             
						{'williamboman/mason.nvim'},           
						{'williamboman/mason-lspconfig.nvim'}, 

						-- Autocompletion
						{'hrsh7th/nvim-cmp'},         
						{'hrsh7th/cmp-nvim-lsp'},     
						{'hrsh7th/cmp-buffer'},       
						{'hrsh7th/cmp-path'},         
						{'saadparwaiz1/cmp_luasnip'},

						-- Snippets
						{'L3MON4D3/LuaSnip'},
						{'rafamadriz/friendly-snippets'},
				}
		}

		use 'nvim-tree/nvim-web-devicons'
  	use 'nvim-tree/nvim-tree.lua'
		use 'famiu/bufdelete.nvim'

		use {
			  'nvim-lualine/lualine.nvim',
			  requires = { 'nvim-tree/nvim-web-devicons', opt = true }
		}

		use 'noib3/nvim-cokeline'

		use 'jose-elias-alvarez/null-ls.nvim'

		use 'lewis6991/gitsigns.nvim'

		use { '~/.config/nvim/my-plugins/pywal.nvim', as = 'pywal' }

		use "lukas-reineke/indent-blankline.nvim"

  	use 'petertriho/nvim-scrollbar'

		use { 'nvim-telescope/telescope-ui-select.nvim' }
		use {
			'rafi/telescope-thesaurus.nvim',
			requires = { 'nvim-telescope/telescope.nvim' }
		}
		use {'stevearc/dressing.nvim'}

end)
