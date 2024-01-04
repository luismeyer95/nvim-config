return {
  "mfussenegger/nvim-dap",
  lazy = false,
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
    },
  },
  config = function(_, opts)
    local dap = require('dap')

    -- Setup signs

    local signs = {
      { name = "DapStopped",             text = " ", texthl = "DiagnosticWarn" },
      { name = "DapBreakpoint",          text = "", texthl = "DiagnosticInfo" },
      { name = "DapBreakpointRejected",  text = "", texthl = "DiagnosticError" },
      { name = "DapBreakpointCondition", text = "", texthl = "DiagnosticInfo" },
      { name = "DapLogPoint",            text = ".>",  texthl = "DiagnosticInfo" },
    }

    for _, sign in ipairs(signs) do
      vim.fn.sign_define(sign.name, sign)
    end

    -- Setup adapters

    dap.adapters.lldb       = {
      type = 'executable',
      command = "/opt/homebrew/opt/llvm/bin/lldb-vscode",
      name = 'lldb',
    }

    dap.adapters.netcoredbg    = {
      type = 'executable',
      command = vim.fn.resolve(vim.fn.stdpath("data") .. "/mason/packages/netcoredbg/netcoredbg"),
      args = { '--interpreter=vscode' }
    }

    dap.adapters.nlua       = function(callback, config)
      callback({ type = 'server', host = config.host or "127.0.0.1", port = config.port or 8086 })
    end

    -- Setup configurations

    dap.configurations.rust = {
      {
        name = "Rust debug",
        type = "lldb",
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

    dap.configurations.cs   = {
      {
        type = "netcoredbg",
        name = "launch - netcoredbg",
        request = "launch",
        program = function()
          return coroutine.create(function(coro)
            local picker = require("utils.option-picker").option_picker
            picker("Select Project",
              { "bash", "-c", "find . -name \"*.csproj\" -exec dirname {} \\;" },
              function(project)
                print("Selected project: " .. project)
                picker("Select DLL", { "bash", "-c", "find " .. project .. " -name \"*.dll\"" },
                  function(dll) coroutine.resume(coro, dll) end)
              end)
          end)
        end
      },
    }

    dap.configurations.lua  = {
      {
        type = 'nlua',
        request = 'attach',
        name = "Attach to running Neovim instance",
      }
    }
  end
}
