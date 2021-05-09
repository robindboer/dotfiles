local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
	use 'gruvbox-community/gruvbox'
	use 'airblade/vim-gitgutter'
    use 'christoomey/vim-tmux-navigator'
    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
    }
    use {
        'hoob3rt/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }
	use 'neovim/nvim-lspconfig'
	use {
		'nvim-treesitter/nvim-treesitter',
		requires = { 'neovim/nvim-lspconfig' },
		run = ":TSUpdate"
	}
	use {
		'hrsh7th/nvim-compe',
		requires = { 'neovim/nvim-lspconfig' }
    }
	use 'nvim-lua/completion-nvim'
end)

