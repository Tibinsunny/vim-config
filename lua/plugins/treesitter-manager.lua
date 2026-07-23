return {
  "romus204/tree-sitter-manager.nvim",
  config = function()
    require("tree-sitter-manager").setup({
      ensure_installed = {},
      auto_install = false,
      border = "rounded",
      nerdfont = true,
    })
  end,
}
