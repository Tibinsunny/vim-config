
-- ~/.config/nvim/init.lua

-- Set leader key BEFORE loading plugins
vim.g.mapleader = ' '  -- Set space as leader key
vim.g.maplocalleader = ' '

-- Setup lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

-- Basic options BEFORE loading plugins
vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true

-- Load plugins
require("lazy").setup({
    require("theme"),
    require("plugin.neo-tree"),
    require("plugin.telescope"),
    require("plugin.treesitter"),
    require("plugin.bufferline"),
    require("plugin.lsp"),
    require("plugin.format_lint"),
    require("plugin.autocomplete"),
    require("plugin.autopair"),
    require("plugin.dap"),
    require("plugin.git-conflict"),
    require("plugin.diffview"),
    require("plugin.lualine"),
    require("plugin.blamer"),
    require("plugin.autotag"),
    require("plugin.indent-object")
})

-- === Apply options AFTER plugins are loaded ===

-- Basic editor options
vim.opt.nu = true                -- Line numbers
vim.opt.relativenumber = true    -- Relative line numbers
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true         -- Use spaces instead of tabs
vim.opt.smartindent = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = true        -- Don't auto-fold on file open
vim.opt.foldlevel = 99           -- Show all folds by default

-- Load keymaps AFTER plugins to avoid conflicts
require("keymaps")

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch", -- You can choose other groups like 'Visual' or define your own
            timeout = 200           -- Highlight lasts 200ms
        })
    end
})
