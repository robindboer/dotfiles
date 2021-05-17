local function map(mode, lhs, rhs, opts)
  local options = {noremap = true, silent = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map('n', '<C-p>',"<cmd>lua require('telescope.builtin').git_files()<cr>")
map('n', '<Leader>pf',"<cmd>lua require('telescope.builtin').find_files()<cr>")
map('n', '<Leader>ps',"<cmd>lua require('telescope.builtin').grep_string()<cr>")
