-- ~/.config/nvim/init.lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
                   lazypath})
end
vim.opt.rtp:prepend(lazypath)

vim.opt.clipboard = "unnamedplus"
require("lazy").setup({require("theme"), require("plugin.neo-tree"), require("plugin.telescope"),
                       require("plugin.treesitter"), require("plugin.bufferline"), require("plugin.lsp"), require("plugin.format_lint"),require("plugin.autocomplete"),require("plugin.autopair")})

-- === Apply the colorscheme and set options AFTER plugins are loaded ===

-- Enable true colors for modern themes
vim.opt.termguicolors = true

-- Set the colorscheme
-- This should happen after the plugin manager has loaded the theme.
-- vim.cmd("colorscheme nightfox")

-- Optional: Basic options (you'll expand on this in user/options.lua later)
vim.opt.nu = true -- Line numbers
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.smartindent = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false -- don’t auto-fold on file open
vim.opt.foldlevel = 99 -- show all folds by default
require("keymaps")

-- Add yank Color---
vim.api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch", -- You can choose other groups like 'Visual' or define your own
            timeout = 200 -- Highlight lasts 200ms
        })
    end
})
