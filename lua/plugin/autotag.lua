-- ~/.config/nvim/lua/plugins/autotag.lua
return {
  "windwp/nvim-ts-autotag",
  -- This plugin has a dependency on nvim-treesitter
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("nvim-ts-autotag").setup({
      -- You can leave this empty to use the defaults
      -- Or check the plugin's documentation for options
    })
  end,
}
