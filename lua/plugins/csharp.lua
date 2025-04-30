return {
  "iabdelkareem/csharp.nvim",
  lazy = false,
  dependencies = {
    "williamboman/mason.nvim", -- Required, automatically installs omnisharp
    "mfussenegger/nvim-dap",
    "Tastyep/structlog.nvim",  -- Optional, but highly recommended for debugging
  },
  config = function()
    require("mason").setup()
    require("csharp").setup(
      {
        lsp = {
          -- Sets if you want to use omnisharp as your LSP
          omnisharp = {
            -- When set to false, csharp.nvim won't launch omnisharp automatically.
            enable = false,
          },
          -- Sets if you want to use roslyn as your LSP
          roslyn = {
            -- When set to true, csharp.nvim will launch roslyn automatically.
            enable = true,
            -- Path to the roslyn LSP see 'Roslyn LSP Specific Prerequisites' above.
            cmd_path = "/usr/local/bin/roslyn/Microsoft.CodeAnalysis.LanguageServer.dll",
          },
          -- The capabilities to pass to the omnisharp server
          capabilities = nil,
          -- on_attach function that'll be called when the LSP is attached to a buffer
          on_attach = nil
        },
        logging = {
          -- The minimum log level.
          level = "TRACE",
        },
        dap = {
          -- When set, csharp.nvim won't launch install and debugger automatically. Instead, it'll use the debug adapter specified.
          adapter_name = nil,
        }
      }
    )
  end
}
