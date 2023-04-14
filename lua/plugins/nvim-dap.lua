return {
  "mfussenegger/nvim-dap",
  enabled = vim.fn.has "win32" == 0,
  lazy = true,
  dependencies = {
    {
      "jay-babu/mason-nvim-dap.nvim",
      dependencies = { "williamboman/mason.nvim" },
      cmd = { "DapInstall", "DapUninstall" },
      opts = { automatic_setup = true },
      config = function(_, opts)
        local mason_nvim_dap = require "mason-nvim-dap"
        mason_nvim_dap.setup(opts)
      end,
    },
    {
      "rcarriga/nvim-dap-ui",
      opts = { floating = { border = "rounded" } },
      config = function(_, opts)
        local dap, dapui = require "dap", require "dapui"
        dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
        dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
        dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
        dapui.setup(opts)
      end,
    },
  },
  config = function(_, opts)
    local dap               = require('dap')

    dap.adapters.lldb       = {
      type = 'executable',
      command = "/opt/homebrew/opt/llvm/bin/lldb-vscode",
      name = 'lldb-vscode',
    }

    dap.configurations.rust = {
      {
        name = "Rust debug",
        type = "lldb-vscode",
        request = "launch",
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = true,
        showDisassembly = "never",
        sourceLanguages = { 'rust' }
      },
    }
  end
}
