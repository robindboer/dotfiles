vim.api.nvim_set_keymap('n', '<C-p>', "<cmd>lua require('telescope.builtin').git_files()<cr>", {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>pf', "<cmd>lua require('telescope.builtin').find_files()<cr>", {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>ps', "<cmd>lua require('telescope.builtin').live_grep()<cr>", {noremap = true, silent = true})
