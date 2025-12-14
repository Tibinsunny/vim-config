

-- File: lua/llm.lua
-- Converted to: return { lazy plugin }

return {
  {
    "monkoose/neocodeium",
    event = "VeryLazy",
    config = function()
      local neocodeium = require("neocodeium")
      neocodeium.setup()

      -- Accept suggestion with Shift-Tab
      
vim.keymap.set("i", "<C-Space>", function()
  require("neocodeium").accept()
end, { silent = true })
    end,
  },
}



