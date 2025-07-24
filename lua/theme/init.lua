return {
  "EdenEast/nightfox.nvim",
  lazy = false,
  priority = 1000, -- Make sure it loads before other plugins
  config = function()
    -- Optional: you can configure variants here
    require("nightfox").setup({
      options = {
        transparent = true,
        terminal_colors = true,
        styles = {
          comments = "italic",
          keywords = "bold",
          types = "italic,bold",
        },
      },
    })

    -- Set colorscheme to carbonfox
    vim.cmd("colorscheme carbonfox")
  end,
}
