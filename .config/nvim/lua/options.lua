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
	completeopt = 'menuone,noselect',
	incsearch = true,
	showmode = false,
}
