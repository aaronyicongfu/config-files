-- Set up the package manager for LSP servers
require("mason").setup()


-- Ensure servers are there, if not, install them using mason
require("mason-lspconfig").setup({
  -- install language servers
  ensure_installed = {"lua_ls", "pyright", "clangd"},
})

-- Ensure formatters are there, if not, install them using mason
-- Set up formatters
require("mason-null-ls").setup({
    ensure_installed = {"black", "clang-format"}
})

-- Set up language servers
local lspconfig = require("lspconfig")
lspconfig.lua_ls.setup{}
lspconfig.pyright.setup{}
lspconfig.clangd.setup{}


-- Create an autocmd group for (fos) formatting-on-save
-- ref: https://www.youtube.com/watch?v=4BnVeOUeZxc
local fos_augroup = vim.api.nvim_create_augroup("LspFormatting", {}) local fos_on_attach = function(client, bufnr)
  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({
      group = fos_augroup,
      buffer = bufnr,
    })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = fos_augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({bufnr = bufnr})
      end
    })
  end
end

-- Set up formatters
local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.clang_format.with({extra_args={"-style=Google"}}),
  },
  on_attach = fos_on_attach
})

-- Set up autocompletion
-- ref: https://www.youtube.com/watch?v=_DnmphIwnjo
local cmp = require("cmp")
cmp.setup({
  -- order is the automatic ranking for sources to show up!
  -- you can configure: 
  --   max_item_count
  --   priority
  sources = {
    {name = "nvim_lua"},
    {name = "nvim_lsp"},
    {name = "path"},
    {name = "buffer", keyword_length = 5},
  },
})
