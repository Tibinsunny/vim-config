

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
      vim.keymap.set("i", "<S-Tab>", function()
        neocodeium.accept()
      end, { silent = true })
    end,
  },
}





