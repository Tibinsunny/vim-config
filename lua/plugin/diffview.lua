return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewFileHistory" },
  dependencies = { "nvim-lua/plenary.nvim" },

  config = function()
    require("diffview").setup({})

    vim.opt.termguicolors = true

    -- Force deletion visibility (theme-proof)
    vim.cmd([[
      highlight DiffDelete guifg=#e06c75 gui=strikethrough
      highlight DiffviewDiffDelete guifg=#e06c75 gui=strikethrough
      highlight DiffAddAsDelete guifg=#e06c75 gui=strikethrough
    ]])
  end,
}
