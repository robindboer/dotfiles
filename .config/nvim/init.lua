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

vim.g.completion_matching_strategy_list = { 'exact', 'substring', 'fuzzy' }

local check_back_space = function()
  local col = vim.fn.col('.') - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s')
end

local cmp = require('cmp')
cmp.setup {
	snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
	mapping = {
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
        }),
		['<Tab>'] = function(fallback)
            if vim.fn.pumvisible() == 1 then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
            elseif check_back_space() then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Tab>', true, true, true), 'n')
			elseif vim.fn['vsnip#available']() == 1 then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>(vsnip-expand-or-jump)', true, true, true), '')
            else
                fallback()
            end
        end,
		['<S-Tab>'] = function(fallback)
            if vim.fn.pumvisible() == 1 then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-p>', true, true, true), 'n')
            else
                fallback()
            end
        end,
	},
    sources = {
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'calc' },
        { name = 'buffer' },
        { name = 'path' },
        { name = 'vsnip' },
    },
}
