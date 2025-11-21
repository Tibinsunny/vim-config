
return {
  "APZelos/blamer.nvim",
  init = function()
    -- 👇 set before plugin loads
    vim.g.blamer_enabled = 0
    vim.g.blamer_prefix = '  '
    vim.g.blamer_template = '<author>, <author-time> • <summary> • <commit-short>'
    vim.g.blamer_date_format = '%d/%m/%y'
    vim.g.blamer_relative_time = 0
  end,
  config = function()
    -- highlight can be set after load
    vim.cmd [[highlight Blamer guifg=#666666 gui=italic]]
  end
}
