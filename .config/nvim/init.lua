vim.g.mapleader = ' '

require('plugins')
require('options')
require('mappings')
require('lsp')

vim.cmd[[colorscheme gruvbox]]

require('lualine').setup {
  options = {
    theme = 'gruvbox',
	section_separators = '',
	component_separators = '',
  }
}
