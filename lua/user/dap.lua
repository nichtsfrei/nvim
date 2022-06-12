-- requires debugpy
local dapui = require("dapui")
local dap = require('dap')

dapui.setup()
-- requires debugpy
require('dap-python').setup('/usr/bin/python3')
-- requires lldb-11
dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/bin/lldb-vscode', -- adjust as needed
  name = "lldb"
}

dap.configurations.cpp = {
  {
    name = "Launch",
    type = "lldb",
    request = "launch",
    -- todo extend here for args
    program = function()
      return vim.fn.input('Program: ', vim.fn.getcwd() .. '/', 'file')
    end,
    -- todo combine program with args for easier usage
    args = function ()
      local t={}
      local wss = vim.fn.input('Arguments: ')
      for token in string.gmatch(wss, "[^%s]+") do
        table.insert(t, token)
      end
      return t
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,

    -- 💀
    -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
    --
    --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    --
    -- Otherwise you might get the following error:
    --
    --    Error on launch: Failed to attach to the target process
    --
    -- But you should be aware of the implications:
    -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html

    runInTerminal = false,

    -- 💀
    -- If you use `runInTerminal = true` and resize the terminal window,
    -- lldb-vscode will receive a `SIGWINCH` signal which can cause problems
    -- To avoid that uncomment the following option
    -- See https://github.com/mfussenegger/nvim-dap/issues/236#issuecomment-1066306073
    postRunCommands = { 'process handle -p true -s false -n false SIGWINCH' }
  },
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp


dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end


 -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
