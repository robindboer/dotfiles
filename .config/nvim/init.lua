vim.g.mapleader = ' '

require('plugins')
require('options')
require('mappings')

vim.cmd[[colorscheme tokyonight]]

require('lualine').setup {
  options = {
    theme = 'tokyonight',
	section_separators = '',
	component_separators = '',
  }
}
