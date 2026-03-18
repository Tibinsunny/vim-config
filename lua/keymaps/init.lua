--- Key Maps for Neo-Tree ---------------
-- Toggle Neo-tree and return to previous buffer if already focused--


-- Define keymap function and options first
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Replace arrow keys with a message
for _, key in pairs({
  { '<Up>', "Use 'k'" },
  { '<Down>', "Use 'j'" },
  { '<Left>', "Use 'h'" },
  { '<Right>', "Use 'l'" },
}) do
  for _, mode in ipairs({ 'n', 'i', 'v' }) do
    map(mode, key[1], function()
      vim.notify(key[2] .. ' instead of arrow keys!')
    end, opts)
  end
end

-- KeyMaps for Telescope --- 
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fw', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

--Keymaps for Treesitter --- 
-- vim.keymap.set("n", "<C-h>", "zc", { desc = "Fold (close)" })  -- collapse
--vim.keymap.set("n", "<C-l>", "zo", { desc = "Unfold (open)" }) -- expand

-- Bufferline remaps---
vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>x", "<cmd>bd<CR>", { desc = "Close buffer" })

vim.keymap.set("n", "<leader><Tab>", "<cmd>tabnew<CR>", { desc = "Open new tab" })
 vim.keymap.set("n", "<leader>dv", "<cmd>DiffviewOpen<CR>", { desc = "Open Diffview" })
vim.keymap.set("n", "<leader>dc", "<cmd>DiffviewClose<CR>", { desc = "Close Diffview" })

-- Normal mode: map L to go to end of line ($)
vim.keymap.set('n', 'L', '$', { noremap = true, silent = true })

-- Visual mode: map L to extend selection to end of line
vim.keymap.set('v', 'L', '$', { noremap = true, silent = true })

vim.keymap.set('v', 'H', '0', { noremap = true, silent = true })
vim.keymap.set('n', 'H', '0', { noremap = true, silent = true })


-- Visual mode: Move selection down with Ctrl + j
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down", silent = true })

-- Visual mode: Move selection up with Ctrl + k
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up", silent = true })

-- Keymap to gurg-far 
vim.keymap.set("n", "<leader>fr", "<cmd>GrugFar<cr>", { desc = "Find & Replace (GrugFAR)" })
-- Vim Keybinding for terminal mode
-- Map Ctrl-w in Terminal mode to escape and then act as Ctrl-w
vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], {noremap = true})

-- Specifically for cycling buffers/windows with 'w'
-- This allows: Ctrl-w (escapes) -> w (moves to next window)
vim.keymap.set('t', '<C-w>w', [[<C-\><C-n><C-w>w]], {noremap = true})

-- Support for the arrow keys you asked for earlier
vim.keymap.set('t', '<C-w><Left>', [[<C-\><C-n><C-w>h]], {noremap = true})
vim.keymap.set('t', '<C-w><Right>', [[<C-\><C-n><C-w>l]], {noremap = true})
vim.keymap.set('t', '<C-w><Up>', [[<C-\><C-n><C-w>k]], {noremap = true})
vim.keymap.set('t', '<C-w><Down>', [[<C-\><C-n><C-w>j]], {noremap = true})

-- Helper function to Toggle Oil
local toggle_oil = function()
  if vim.bo.filetype == "oil" then
    require("oil").close()
  else
    require("oil").open()
  end
end

-- 1. Map Leader + T to toggle Oil
-- Ensure your leader key is defined before this line (usually vim.g.mapleader = " ")
vim.keymap.set("n", "<leader>t", toggle_oil, { desc = "Toggle Oil File Explorer" })

-- 2. Create the :Ex command to toggle Oil
-- 'force = true' allows us to overwrite the built-in Netrw :Ex command
vim.api.nvim_create_user_command("Ex", toggle_oil, { 
  force = true, 
  desc = "Toggle Oil File Explorer" 
})
