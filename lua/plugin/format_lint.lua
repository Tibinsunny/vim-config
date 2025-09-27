
return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          python = { "black", "isort" },
          javascript = { "prettier" },
          typescript = { "prettier" },
          go = { "gofmt", "goimports" },
          json = { "prettier" },
          yaml = { "prettier" },
          markdown = { "prettier" },
          typescriptreact = { "prettier" },
          javascriptreact = { "prettier" },
        },
      })

      -- Enable format on save
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function(args)
          require("conform").format({
            bufnr = args.buf
          })
        end,
      })
    end,
  },
}
