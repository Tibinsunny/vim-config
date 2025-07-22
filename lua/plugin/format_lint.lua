
-- ~/.config/nvim/lua/plugins/conform.lua
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
        },
      })
    end,
  },
}
