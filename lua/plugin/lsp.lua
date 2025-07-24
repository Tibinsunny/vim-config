return {
    "neovim/nvim-lspconfig",
    dependencies = {{
        "williamboman/mason.nvim",
        config = true
    }, {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {"pyright", "ts_ls", "gopls", "html", "cssls", "jsonls", "yamlls"},
            automatic_installation = true,
            automatic_setup = true 
        }
    }},
    config = function()
        local lspconfig = require("lspconfig")

        lspconfig.pyright.setup({})
        lspconfig.ts_ls.setup({})
        lspconfig.gopls.setup({})
        lspconfig.html.setup({})
        lspconfig.cssls.setup({})
        lspconfig.jsonls.setup({})
        lspconfig.yamlls.setup({})

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
