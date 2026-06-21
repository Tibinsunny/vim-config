vim.g.mapleader = " "
vim.g.maplocalleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
require("theme"),
require("plugins.lsp"),
require("plugins.treesitter-manager"),
require("plugins.autocmp"),
require("plugins.autopair"),
require("plugins.autotag"),
require("plugins.diffview"),
require("plugins.blamer"),
require("plugins.harpoon"),
require("plugins.codediff"),
require("plugins.lualine"),
require("plugins.visual-multi"),
require("plugins.telescope"),
--require("plugins.neotree"),
require("plugins.oil")
})
require("keymaps")
require("config")

