local dap = require('dap')
dap.set_log_level("DEBUG")
-- Node.js debugger adapter
dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = {os.getenv('HOME') .. '/.local/share/nvim/mason/packages/node-debug2-adapter/out/src/nodeDebug.js'},
}

-- Python debugger adapter
dap.adapters.python = function(cb, config)
    if config.request == 'attach' then
      ---@diagnostic disable-next-line: undefined-field
      local port = (config.connect or config).port
      ---@diagnostic disable-next-line: undefined-field
      local host = (config.connect or config).host or '127.0.0.1'
      cb({
        type = 'server',
        port = assert(port, '`connect.port` is required for a python `attach` configuration'),
        host = host,
        options = {
          source_filetype = 'python',
        },
      })
    else
      -- Try to find python executable in order of preference
      local python_path = nil
      local possible_paths = {'python3', 'python', '/usr/bin/python3', '/usr/local/bin/python3'}
      
      for _, path in ipairs(possible_paths) do
        if vim.fn.executable(path) == 1 then
          python_path = path
          break
        end
      end
      
      if not python_path then
        error("No Python executable found. Please install Python or update the path.")
      end
      
      cb({
        type = 'executable',
        command = python_path,
        args = { '-m', 'debugpy.adapter' },
        options = {
          source_filetype = 'python',
        },
      })
    end
  end

-- JavaScript configurations
dap.configurations.javascript = {
  {
    name = 'Launch Node.js',
    type = 'node2',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
  {
  name = 'Attach to Node.js without DAPUI',
  type = 'node2',
  request = 'attach',
  port = 9229,
  address = '127.0.0.1',
  restart = true,
  cwd = vim.fn.getcwd(),
  openUI=false,
}  
  ,{
  name = 'Attach to Node.js with UI',
  type = 'node2',
  request = 'attach',
  port = 9229,
  address = '127.0.0.1',
  restart = true,
  cwd = vim.fn.getcwd(),
  openUI=true,
 },
  {
    name = 'Launch Node.js with arguments',
    type = 'node2',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    args = function()
      local args = vim.fn.input('Arguments: ')
      return vim.split(args, ' ')
    end,
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
}

-- Python configurations
dap.configurations.python = {
    {
      type = 'python',
      request = 'launch',
      name = 'Launch file',
      program = '${file}',
      pythonPath = function()
        -- Check for virtual environment first
        local cwd = vim.fn.getcwd()
        if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
          return cwd .. '/venv/bin/python'
        elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
          return cwd .. '/.venv/bin/python'
        elseif vim.fn.executable(cwd .. '/venv/bin/python3') == 1 then
          return cwd .. '/venv/bin/python3'
        elseif vim.fn.executable(cwd .. '/.venv/bin/python3') == 1 then
          return cwd .. '/.venv/bin/python3'
        elseif vim.fn.executable('python3') == 1 then
          return 'python3'
        elseif vim.fn.executable('python') == 1 then
          return 'python'
        else
          return '/usr/bin/python3'
        end
      end,
    },
    {
      type = 'python',
      request = 'launch',
      name = 'Launch file with arguments',
      program = '${file}',
      args = function()
        local args = vim.fn.input('Arguments: ')
        return vim.split(args, ' ')
      end,
      pythonPath = function()
        local cwd = vim.fn.getcwd()
        if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
          return cwd .. '/venv/bin/python'
        elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
          return cwd .. '/.venv/bin/python'
        elseif vim.fn.executable(cwd .. '/venv/bin/python3') == 1 then
          return cwd .. '/venv/bin/python3'
        elseif vim.fn.executable(cwd .. '/.venv/bin/python3') == 1 then
          return cwd .. '/.venv/bin/python3'
        elseif vim.fn.executable('python3') == 1 then
          return 'python3'
        elseif vim.fn.executable('python') == 1 then
          return 'python'
        else
          return '/usr/bin/python3'
        end
      end,
    },
    {
      type = 'python',
      request = 'launch',
      name = 'Launch Django',
      program = '${workspaceFolder}/manage.py',
      args = {
        'runserver',
      },
      django = true,
      pythonPath = function()
        local cwd = vim.fn.getcwd()
        if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
          return cwd .. '/venv/bin/python'
        elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
          return cwd .. '/.venv/bin/python'
        elseif vim.fn.executable(cwd .. '/venv/bin/python3') == 1 then
          return cwd .. '/venv/bin/python3'
        elseif vim.fn.executable(cwd .. '/.venv/bin/python3') == 1 then
          return cwd .. '/.venv/bin/python3'
        elseif vim.fn.executable('python3') == 1 then
          return 'python3'
        elseif vim.fn.executable('python') == 1 then
          return 'python'
        else
          return '/usr/bin/python3'
        end
      end,
    },
    {
      type = 'python',
      request = 'launch',
      name = 'Python: Flask',
      module = 'flask',
      env = {
        FLASK_APP = '${workspaceFolder}/app.py',
        FLASK_ENV = 'development',
      },
      args = {
        'run',
        '--no-debugger',
        '--no-reload',
      },
      jinja = true,
      pythonPath = function()
        local cwd = vim.fn.getcwd()
        if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
          return cwd .. '/venv/bin/python'
        elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
          return cwd .. '/.venv/bin/python'
        elseif vim.fn.executable(cwd .. '/venv/bin/python3') == 1 then
          return cwd .. '/venv/bin/python3'
        elseif vim.fn.executable(cwd .. '/.venv/bin/python3') == 1 then
          return cwd .. '/.venv/bin/python3'
        elseif vim.fn.executable('python3') == 1 then
          return 'python3'
        elseif vim.fn.executable('python') == 1 then
          return 'python'
        else
          return '/usr/bin/python3'
        end
      end,
    },
    {
      type = 'python',
      request = 'launch',
      name = 'Python: pytest',
      module = 'pytest',
      args = {
        '${file}',
      },
      pythonPath = function()
        local cwd = vim.fn.getcwd()
        if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
          return cwd .. '/venv/bin/python'
        elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
          return cwd .. '/.venv/bin/python'
        elseif vim.fn.executable(cwd .. '/venv/bin/python3') == 1 then
          return cwd .. '/venv/bin/python3'
        elseif vim.fn.executable(cwd .. '/.venv/bin/python3') == 1 then
          return cwd .. '/.venv/bin/python3'
        elseif vim.fn.executable('python3') == 1 then
          return 'python3'
        elseif vim.fn.executable('python') == 1 then
          return 'python'
        else
          return '/usr/bin/python3'
        end
      end,
    },
    {
      type = 'python',
      request = 'attach',
      name = 'Attach remote',
      connect = function()
        local host = vim.fn.input('Host [127.0.0.1]: ')
        host = host ~= '' and host or '127.0.0.1'
        local port = tonumber(vim.fn.input('Port [5678]: ')) or 5678
        return { host = host, port = port }
      end,
    },
  }

-- TypeScript configurations (reuse JavaScript adapter)
dap.configurations.typescript = dap.configurations.javascript

-- Key mappings
vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
vim.keymap.set('n', '<leader>B', function()
  dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
end, { desc = 'Debug: Set Conditional Breakpoint' })

-- Set breakpoint icons
vim.fn.sign_define('DapBreakpoint', { text='🔴', texthl='DapBreakpoint', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointCondition', { text='🟡', texthl='DapBreakpointCondition', linehl='', numhl=''})
vim.fn.sign_define('DapLogPoint', { text='📝', texthl='DapLogPoint', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', { text='➡️', texthl='DapStopped', linehl='debugPC', numhl=''})
vim.fn.sign_define('DapBreakpointRejected', { text='❌', texthl='DapBreakpointRejected', linehl='', numhl=''})
