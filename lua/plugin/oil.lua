return {
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    lazy = false,
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    opts = {
      -- Replace Netrw
      default_file_explorer = true,
      -- Internal Keymaps for Oil's buffer
      keymaps = {
        -- Fix: Disable Oil's internal "close" action for Ctrl-C
        -- Setting to an empty string prevents it from closing the buffer
        ["<C-c>"] = "", 
      },
    },
    config = function(_, opts)
      require("oil").setup(opts)
    end,
  }
}
