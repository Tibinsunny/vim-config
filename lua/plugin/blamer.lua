
return {
  {
    "APZelos/blamer.nvim",
    config = function()
      -- enable blamer on startup
      vim.g.blamer_enabled = 1

      -- optional configs
      vim.g.blamer_delay = 500
      vim.g.blamer_show_in_insert_modes = 0
      vim.g.blamer_show_in_visual_modes = 0
      vim.g.blamer_prefix = ' > '
      vim.g.blamer_template = '<committer> <committer-mail> '
      vim.g.blamer_date_format = '%d/%m/%y'
      vim.g.blamer_relative_time = 1

      -- custom highlight (optional)
      --
      vim.cmd [[highlight Blamer guifg=#808080 gui=italic blend=30]]
    end
  }
}
