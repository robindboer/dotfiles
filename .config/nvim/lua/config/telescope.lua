local keymap = vim.keymap

require('telescope').setup {
  pickers = {
    live_grep = {
      find_command = { "rg", "--hidden" }
    }
  }
}

require('telescope').load_extension('fzf')

local builtin = require('telescope.builtin')

keymap.set('n', '<C-p>', builtin.git_files, {})
keymap.set('n', '<leader>pf', builtin.find_files, {})
keymap.set('n', '<leader>ps', builtin.live_grep, {})
keymap.set('n', '<leader>vr', builtin.lsp_references, {})
keymap.set('n', '<leader>pg', builtin.git_status, {})
