local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)

local plugin_specs = {
  {
    "hrsh7th/nvim-cmp",
    event = "VeryLazy",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "onsails/lspkind-nvim",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
    },
    config = function()
      require("config.nvim-cmp")
    end,
  },

  {
    "neovim/nvim-lspconfig",
    event = { "BufRead", "BufNewFile" },
    config = function()
      require("config.lsp")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    build = ":TSUpdate",
    config = function()
      require("config.treesitter")
    end,
  },

  "nvim-lua/plenary.nvim",

  {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    cmd = "Telescope",
    dependencies = {
      "nvim-telescope/telescope-symbols.nvim",
	  "nvim-lua/popup.nvim",
    },
    config = function()
      require("config.telescope")
    end,
  },

  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      require("config.statusline")
    end,
  },

  {
    "nvimdev/dashboard-nvim",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require("config.dashboard-nvim")
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("config.gitsigns")
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    keys = { "<space>s" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("config.nvim-tree")
    end
  },

  {
    "tmux-plugins/vim-tmux",
    ft = { "tmux" },
  },

  { "christoomey/vim-tmux-navigator" },

  { "itchyny/vim-highlighturl", event = "VeryLazy" },
  
  { "Raimondi/delimitMate", event = "InsertEnter" },

  { "tpope/vim-commentary", event = "VeryLazy" },

  { "907th/vim-auto-save", event = "InsertEnter" },
  
  { "nvim-zh/better-escape.vim", event = { "InsertEnter" } },

  { "sbdchd/neoformat", cmd = { "Neoformat" } },

  { "tpope/vim-commentary", event = "VeryLazy" },

  { 
    "rose-pine/neovim",
	name = "rose-pine",
	config = function()
		vim.cmd([[colorscheme rose-pine]])
	end,
  },
}

local opts = {
  ui = {
    border = "rounded",
    title = "Plugin Manager",
    title_pos = "center",
  },
}

require("lazy").setup(plugin_specs, opts)
