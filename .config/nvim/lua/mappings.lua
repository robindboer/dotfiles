local function map(mode, lhs, rhs, opts)
  local options = {noremap = true, silent = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map('n', '<C-p>', '<CMD>Telescope git_files<CR>')
map('n', '<Leader>pf', '<CMD>Telescope find_files<CR>')
map('n', '<Leader>ps', '<CMD>Telescope grep_string<CR>')
