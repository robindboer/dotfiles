require("nvim-treesitter.configs").setup {
  ensure_installed = { "python", "rust", "lua", "vim", "json", "toml", "yaml" },
  ignore_install = {},
  highlight = {
    enable = true,
    disable = { 'help' },
  },
}
