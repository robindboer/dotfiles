vim.loader.enable()

-- Load globals
require("globals")

-- Load options
local options_conf = vim.fn.stdpath("config") .. "/options.vim"
vim.cmd("source " .. options_conf)

-- Load mappings
require("mappings")

-- Set up Lazy and all plugins
require("plugin_specs")

