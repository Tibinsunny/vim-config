return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" }, -- lazy-load on file open
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "javascript",
        "typescript", -- needed for Node.js & React
        "tsx",        -- for React (JSX/TSX)
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
        enable = true, -- enable syntax highlighting
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true, -- better indentation
      },
      -- The 'autotag' section has been removed from here.
      -- It is now handled by the separate 'nvim-ts-autotag' plugin file.
    })
  end,
}
