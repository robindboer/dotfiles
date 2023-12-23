local fn = vim.fn
local keymap = vim.keymap
local diagnostic = vim.diagnostic

local custom_attach = function(client, bufnr)
  local map = function(mode, l, r, opts)
    opts = opts or {}
    opts.silent = true
    opts.buffer = bufnr
    keymap.set(mode, l, r, opts)
  end

  map("n", "<leader>vd", vim.lsp.buf.definition, { desc = "go to definition" })
  map("n", "<leader>vrn", vim.lsp.buf.rename, { desc = "variable rename" })
  map("n", "<leader>vr", vim.lsp.buf.references, { desc = "show references" })
  map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP code action" })

  if client.server_capabilities.documentFormattingProvider then
    map("n", "<leader>f", vim.lsp.buf.format, { desc = "format code" })
  end
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local lspconfig = require("lspconfig")

local omnisharp_bin = "/usr/local/bin/omnisharp-roslyn/OmniSharp"
if fn.executable(omnisharp_bin) > 0 then
  lspconfig.omnisharp.setup {
    on_attach = custom_attach,
    capabilities = capabilities,
	cmd = { omnisharp_bin, "--languageserver", "--hostPID", tostring(fn.getpid()) },
  }
end

if fn.executable("typescript-language-server") > 0 then
  lspconfig.tsserver.setup {
    on_attach = custom_attach,
    capabilities = capabilities,
  }
end

fn.sign_define("DiagnosticSignError", { text = '🆇', texthl = "DiagnosticSignError" })
fn.sign_define("DiagnosticSignWarn", { text = '⚠️', texthl = "DiagnosticSignWarn" })
fn.sign_define("DiagnosticSignInfo", { text = 'ℹ️', texthl = "DiagnosticSignInfo" })
fn.sign_define("DiagnosticSignHint", { text = '', texthl = "DiagnosticSignHint" })

diagnostic.config {
  underline = false,
  virtual_text = false,
  signs = true,
  severity_sort = true,
}
