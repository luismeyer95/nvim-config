return {
  "mxsdev/nvim-dap-vscode-js",
  ft = { "javascript", "typescript" },
  dependencies = { "mfussenegger/nvim-dap" },
  config = function()
    require("dap-vscode-js").setup({
      debugger_path = vim.fn.stdpath('data') .. '/mason/packages/js-debug-adapter',
      debugger_cmd = { 'js-debug-adapter' },
      adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
      -- Path for file logging
      -- log_file_path = vim.fn.stdpath('cache') .. "/dap_vscode_js.log",
      -- Logging level for output to file. Set to false to disable file logging
      -- log_file_level = false,
      log_console_level = vim.log.levels.DEBUG
    })

    local dap = require("dap")

    -- Note: redefining the adapter here to set the host as ::1
    -- due to issues with using localhost/127.0.0.1 on macOS
    dap.adapters['pwa-node'] = {
      type = 'server',
      host = '::1',
      port = '8123',
      executable = {
        command = 'js-debug-adapter',
        args = { '8123' },
      }
    }

    for _, language in ipairs({ "typescript", "javascript" }) do
      dap.configurations[language] = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          cwd = "${workspaceFolder}",
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach",
          processId = require 'dap.utils'.pick_process,
          cwd = "${workspaceFolder}",
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "Debug Jest Tests",
          -- trace = true, -- include debugger info
          runtimeExecutable = "node",
          runtimeArgs = {
            "./node_modules/jest/bin/jest.js",
            "--runInBand",
          },
          rootPath = "${workspaceFolder}",
          cwd = "${workspaceFolder}",
          console = "integratedTerminal",
          internalConsoleOptions = "neverOpen",
        }
      }
    end
  end
}
