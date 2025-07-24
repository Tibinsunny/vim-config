return {
  "akinsho/git-conflict.nvim",
  version = "*",
  config = function()
    require("git-conflict").setup({
      default_mappings = {
        ours = 'o',
        theirs = 't',
        none = '0',
        both = 'b',
        next = 'n',
        prev = 'p',
      },
      default_commands = true,
      disable_diagnostics = false,
      list_opener = 'copen',
      highlights = {
        incoming = 'DiffAdd',
        current = 'DiffText',
      },
    })
  end,
}
