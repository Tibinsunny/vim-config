return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'mfussenegger/nvim-dap' },
  opts = {
    sections = {
      lualine_c = {
        {
          'filename',
          path = 1, -- 👈 THIS shows full path
        },
        function()
          local dap = require('dap')
          if dap.session() then
            return ' Debugging'
          else
            return ''
          end
        end,
      },
    },
  },
}
