vim.opt.number = true           -- keep absolute number for current line
vim.opt.relativenumber = true   -- show relative numbers
vim.opt.splitright = true  
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
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false

vim.opt.clipboard = "unnamedplus"
