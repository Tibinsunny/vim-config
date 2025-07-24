return{
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewFileHistory" },
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("diffview").setup({})
  end,
}
