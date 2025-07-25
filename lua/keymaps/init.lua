--- Key Maps for Neo-Tree ---------------
-- Toggle Neo-tree and return to previous buffer if already focused--
vim.keymap.set("n", "<leader>t", ":Neotree toggle<CR>", { desc = "Toggle Neo-tree" })
vim.keymap.set("n", "<leader>e", function()
  local neotree_win = nil
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(win))
    if bufname:match("neo%-tree") then
      neotree_win = win
      break
    end
  end

  if neotree_win and vim.api.nvim_get_current_win() == neotree_win then
    vim.cmd("wincmd p") -- Go to previous window
  else
    vim.cmd("Neotree focus")
  end
end, { desc = "Toggle focus to Neo-tree" })

-- KeyMaps for Telescope --- 
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fw', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

--Keymaps for Treesitter --- 
vim.keymap.set("n", "<C-h>", "zc", { desc = "Fold (close)" })  -- collapse
vim.keymap.set("n", "<C-l>", "zo", { desc = "Unfold (open)" }) -- expand

-- Bufferline remaps---
vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>x", "<cmd>bd<CR>", { desc = "Close buffer" })
vim.keymap.set("n", "Q", [["_dd]], { desc = "Delete line without yanking" })

vim.keymap.set("v", "Q", [["_dd]], { desc = "Delete line without yanking" })

vim.keymap.set("n", "<leader><Tab>", "<cmd>tabnew<CR>", { desc = "Open new tab" })
 vim.keymap.set("n", "<leader>dv", "<cmd>DiffviewOpen<CR>", { desc = "Open Diffview" })
vim.keymap.set("n", "<leader>dc", "<cmd>DiffviewClose<CR>", { desc = "Close Diffview" })

-- Normal mode: map L to go to end of line ($)
vim.keymap.set('n', 'L', '$', { noremap = true, silent = true })

-- Visual mode: map L to extend selection to end of line
vim.keymap.set('v', 'L', '$', { noremap = true, silent = true })

vim.keymap.set('v', 'H', '0', { noremap = true, silent = true })
vim.keymap.set('n', 'H', '0', { noremap = true, silent = true })
