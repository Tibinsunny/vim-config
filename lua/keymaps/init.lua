-- Define keymap function and options first
local map = vim.keymap.set
local opts = { noremap = true, silent = true }
for _, key in pairs({
  { '<Up>', "Use 'k'" },
  { '<Down>', "Use 'j'" },
  { '<Left>', "Use 'h'" },
  { '<Right>', "Use 'l'" },
}) do
  for _, mode in ipairs({ 'n', 'i', 'v' }) do
    map(mode, key[1], function()
      if vim.bo.filetype == "TelescopePrompt" then
        return key[1]
      end

      vim.notify(key[2] .. ' instead of arrow keys!')
    end, vim.tbl_extend("force", opts, { expr = true }))
  end
end

-- KeyMaps for Telescope --- 
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fw', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

--Keymaps for Treesitter --- 
vim.keymap.set("n", "<C-h>", "zc", { desc = "Fold (close)" })  -- collapse
vim.keymap.set("n", "<C-l>", "zo", { desc = "Unfold (open)" }) -- expand

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


-- Specifically for cycling buffers/windows with 'w'
-- This allows: Ctrl-w (escapes) -> w (moves to next window)
vim.keymap.set('t', '<C-w>w', [[<C-\><C-n><C-w>w]], {noremap = true})


-- Helper function to Toggle Oil
local toggle_oil = function()
  if vim.bo.filetype == "oil" then
    require("oil").close()
  else
    require("oil").open()
  end
end

vim.keymap.set("n", "<leader>t", toggle_oil, { desc = "Toggle Oil File Explorer" })

-- 2. Create the :Ex command to toggle Oil
-- 'force = true' allows us to overwrite the built-in Netrw :Ex command
vim.api.nvim_create_user_command("Ex", toggle_oil, { 
  force = true, 
  desc = "Toggle Oil File Explorer" 
})


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

vim.keymap.set("n", "gl", vim.diagnostic.open_float)
vim.opt.laststatus=3
