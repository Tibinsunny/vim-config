return {
    "neovim/nvim-lspconfig",
    dependencies = {{
        "williamboman/mason.nvim",
        config = true
    }, {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {"pyright", "ts_ls", "gopls", "html", "cssls", "jsonls", "yamlls", "clangd"},
            automatic_installation = true,
            automatic_setup = true 
        }
    }},
    config = function()
          vim.lsp.config("pyright", {})
          vim.lsp.config("ts_ls", {})
          vim.lsp.config("gopls", {})
          vim.lsp.config("html", {})
          vim.lsp.config("cssls", {})
          vim.lsp.config("jsonls", {})
          vim.lsp.config("yamlls", {})
          vim.lsp.config("clangd", {})

          -- Enable them
          vim.lsp.enable({
            "pyright",
            "ts_ls",
            "gopls",
            "html",
            "cssls",
            "jsonls",
            "yamlls",
            "clangd",
          })

        local map = vim.keymap.set
        local opts = {
            noremap = true,
            silent = true
        }

        map("n", "K", vim.lsp.buf.hover, opts)
        map("n", "gd", vim.lsp.buf.definition, opts)
        map("n", "gr", vim.lsp.buf.references, opts)
    end
}
