-- File: e.g., lua/plugins/editing.lua or wherever you group your plugins

return {
  -- Your existing nvim-treesitter configuration
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "javascript",
          "typescript",
          "tsx",
          "python",
          "rust",
          "go",
          "lua",
          "bash",
          "json",
          "yaml",
          "html",
          "css",
          "markdown",
          "markdown_inline",
          "vim",
          "query",
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
        },
      })
    end,
  },

  -- ADD THIS NEW BLOCK for nvim-matchup
{
  'andymass/vim-matchup',
  event = "BufReadPost",
  config = function()
 vim.api.nvim_set_hl(0, "MatchParen", { bg = "#590000", fg = "#FFFFFF", bold = true })
    -- Optional: set matchup options via vim.g
    vim.g.matchup_enabled = 1
    vim.g.matchup_surround_enabled = 1
  end,
},
}
