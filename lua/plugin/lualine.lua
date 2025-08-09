return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'mfussenegger/nvim-dap' }, -- Ensure nvim-dap is a dependency
  opts = {
    sections = {
      lualine_c = {
        function()
          local dap = require('dap')
          if dap.session() then
            return ' Debugging'
          else
            return ''
          end
        end,
      },
      -- add your other sections here
    },
  },
}
