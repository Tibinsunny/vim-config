local M = {}

function M.setup()
  -- C / C++
  vim.lsp.config('clangd', {
    cmd = { 'clangd', '--background-index' },
    root_markers = { 'compile_commands.json', 'compile_flags.txt', '.git' },
  })

  -- Python
  vim.lsp.config('pyright', {
    cmd = { 'pyright-langserver', '--stdio' },
    root_markers = { 'pyproject.toml', 'setup.py', 'requirements.txt', '.git' },
  })


  -- TypeScript / JavaScript
  vim.lsp.config('vtsls', {
    cmd = { 'vtsls', '--stdio' },
    root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' },
  })

  -- Go (gopls)
  vim.lsp.config('gopls', {
    cmd = { 'gopls' },
    root_markers = { 'go.work', 'go.mod', '.git' },
  })

  -- Bulk enable all configurations
  local servers = { 'clangd', 'pyright', 'vtsls', 'gopls' }
  for _, server in ipairs(servers) do
    vim.lsp.enable(server)
  end

  -- Centralized Keymaps via Autocmd
  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
      local opts = { buffer = args.buf }
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    end,
  })
end

return {
  "neovim/nvim-lspconfig",
  config = function()
    M.setup()
  end
}
