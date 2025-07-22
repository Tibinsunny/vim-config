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
        enable = true,              -- enable syntax highlighting
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true,              -- better indentation
      },
      autotag = {
        enable = true,              -- auto-close tags (needs nvim-ts-autotag)
      },
    })
  end,
}
