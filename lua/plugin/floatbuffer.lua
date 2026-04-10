_G.float_term_win = nil
_G.float_term_buf = nil

function FloatTermToggle()
  -- if already open → close it
  if _G.float_term_win and vim.api.nvim_win_is_valid(_G.float_term_win) then
    vim.api.nvim_win_close(_G.float_term_win, true)
    _G.float_term_win = nil
    return
  end

  -- create buffer if not exists
  if not _G.float_term_buf or not vim.api.nvim_buf_is_valid(_G.float_term_buf) then
    _G.float_term_buf = vim.api.nvim_create_buf(false, true)
  end

  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)

  local opts = {
    relative = "editor",
    width = width,
    height = height,
    row = math.floor((vim.o.lines - height) / 2),
    col = math.floor((vim.o.columns - width) / 2),
    style = "minimal",
    border = "rounded",
  }

  _G.float_term_win = vim.api.nvim_open_win(_G.float_term_buf, true, opts)

  if vim.bo[_G.float_term_buf].buftype ~= "terminal" then
    vim.fn.termopen(vim.o.shell)
  end

  vim.cmd("startinsert")

  vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { buffer = _G.float_term_buf })

  vim.keymap.set("n", "q", function()
    if _G.float_term_win and vim.api.nvim_win_is_valid(_G.float_term_win) then
      vim.api.nvim_win_close(_G.float_term_win, true)
      _G.float_term_win = nil
    end
  end, { buffer = _G.float_term_buf })
end

vim.keymap.set("n", "<leader>ft", FloatTermToggle)


local float_buf = nil
local float_win = nil

local data_path = vim.fn.stdpath("data")
local file_path = data_path .. "/floatbuff.md"
local state_path = data_path .. "/floatbuff_state.json"

local function load_position()
  local ok, data = pcall(vim.fn.readfile, state_path)
  if not ok or not data[1] then
    return nil, nil
  end

  local decoded = vim.fn.json_decode(table.concat(data, "\n"))
  return decoded.row, decoded.col
end

local function save_position(row, col)
  local data = vim.fn.json_encode({ row = row, col = col })
  vim.fn.writefile({ data }, state_path)
end

local float_buf = nil
local float_win = nil

local base_path = vim.fn.stdpath("data") .. "/floatbuff/"
vim.fn.mkdir(base_path, "p")

-- get project name from cwd
local function get_project_name()
  local cwd = vim.fn.getcwd()
  return cwd:gsub("/", "_") -- simple safe name
end

local function get_paths()
  local name = get_project_name()
  return base_path .. name .. ".md", base_path .. name .. ".json"
end

local function load_position(state_path)
  local ok, data = pcall(vim.fn.readfile, state_path)
  if not ok or not data[1] then
    return nil, nil
  end

  local decoded = vim.fn.json_decode(table.concat(data, "\n"))
  return decoded.row, decoded.col
end

local function save_position(state_path, row, col)
  local data = vim.fn.json_encode({ row = row, col = col })
  vim.fn.writefile({ data }, state_path)
end

function FloatBuff()
  local file_path, state_path = get_paths()

  -- create/load buffer
  if not float_buf or not vim.api.nvim_buf_is_valid(float_buf) then
    float_buf = vim.fn.bufadd(file_path)
    vim.fn.bufload(float_buf)
  end

  -- toggle
  if float_win and vim.api.nvim_win_is_valid(float_win) then
    local pos = vim.api.nvim_win_get_position(float_win)
    save_position(state_path, pos[1], pos[2])
    vim.api.nvim_win_close(float_win, true)
    float_win = nil
    return
  end

  local width = 50
  local height = 15

  local row, col = load_position(state_path)
  row = row or math.floor((vim.o.lines - height) / 2)
  col = col or math.floor((vim.o.columns - width) / 2)

  float_win = vim.api.nvim_open_win(float_buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
  })

  -- autosave
  vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
    buffer = float_buf,
    callback = function()
      vim.cmd("silent write")
    end,
  })

  vim.cmd("startinsert")

  -- movement
  local function move(dx, dy)
    if float_win and vim.api.nvim_win_is_valid(float_win) then
      local pos = vim.api.nvim_win_get_position(float_win)
      local new_row = pos[1] + dy
      local new_col = pos[2] + dx

      save_position(state_path, new_row, new_col)

      vim.api.nvim_win_set_config(float_win, {
        relative = "editor",
        row = new_row,
        col = new_col,
      })
    end
  end

  vim.keymap.set("n", "<C-h>", function() move(-2, 0) end, { buffer = float_buf })
  vim.keymap.set("n", "<C-l>", function() move(2, 0) end, { buffer = float_buf })
  vim.keymap.set("n", "<C-k>", function() move(0, -1) end, { buffer = float_buf })
  vim.keymap.set("n", "<C-j>", function() move(0, 1) end, { buffer = float_buf })

  -- close
  vim.keymap.set("n", "q", function()
    if float_win then
      local pos = vim.api.nvim_win_get_position(float_win)
      save_position(state_path, pos[1], pos[2])
      vim.api.nvim_win_close(float_win, true)
      float_win = nil
    end
  end, { buffer = float_buf })
end

vim.cmd([[
  cabbrev floatBuff lua FloatBuff()
]])
