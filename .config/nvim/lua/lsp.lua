local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
	require'completion'.on_attach()

	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

	-- Mappings.
	local opts = { noremap=true, silent=true }
	buf_set_keymap('n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
	buf_set_keymap('n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	buf_set_keymap('n', '<leader>vrn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	buf_set_keymap('n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

	-- Set autocommands conditional on server_capabilities
	if client.resolved_capabilities.document_highlight then
		vim.api.nvim_exec([[
			augroup lsp_document_highlight
			autocmd! * <buffer>
			autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
			autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
			augroup END
		]], false)
	end
end

-- Use a loop to conveniently both setup defined servers 
-- and map buffer local keybindings when the language server attaches
local servers = { "pyright", "dockerls", "gopls", "html", "jsonls", "sqlls", "yamlls" }
for _, lsp in ipairs(servers) do
	nvim_lsp[lsp].setup { on_attach = on_attach }
end
