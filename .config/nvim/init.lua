vim.g.mapleader = ' '

local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

require('packer').startup(function(use)
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

  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip' -- Snippets plugin
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

vim.cmd[[colorscheme gruvbox]]

-- lualine setup
local lualine = require('lualine')

lualine.setup {
  options = {
    theme = 'gruvbox',
	section_separators = '',
	component_separators = '',
  }
}

-- Telescope key mappings 
vim.api.nvim_set_keymap("n", "<C-p>", "<cmd>lua require('telescope.builtin').git_files()<cr>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<Leader>pf", "<cmd>lua require('telescope.builtin').find_files()<cr>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<Leader>ps", "<cmd>lua require('telescope.builtin').live_grep()<cr>", {noremap = true, silent = true})

-- Set options
local function set_opts(opts_table)
    for k, v in pairs(opts_table) do
	vim.o[k] = v
    end
end

set_opts {
    autoindent = true,
    cursorline = true,
    guicursor = '',
    hidden = true,
    hlsearch = false,
    number = true,
    relativenumber = true,
    scrolloff = 8,
    shiftwidth = 4,
    tabstop = 4,
    softtabstop = 4,
    incsearch = true,
    showmode = false,
    signcolumn = 'yes',
    smartindent = true,
}

-- Setup LSP
local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
	
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

	-- Mappings.
	local opts = { noremap=true, silent=true }
	buf_set_keymap('n', '<leader>vd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
	buf_set_keymap('n', '<leader>vi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	buf_set_keymap('n', '<leader>vrn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	buf_set_keymap('n', '<leader>vr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

	vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

-- nvim-cmp adds some capabilities to lsp server
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Enable the following language servers
local servers = { "jedi_language_server", "dockerls", "gopls", "html", "jsonls", "sqlls", "yamlls" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'cmdline' },
  },
}
