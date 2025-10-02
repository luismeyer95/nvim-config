return {
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      -- Automatically install LSPs and related tools to stdpath for neovim
      'williamboman/mason.nvim',
      "williamboman/mason-lspconfig.nvim",
      {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          }
        }
      }
    },
    config = function(_, _)
      local signs = require("utils").lsp_signs

      -- vim.lsp.set_log_level "debug"

      vim.diagnostic.config {
        virtual_text = {
          prefix = "●",
          source = true,
        },
        underline = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = signs.Error,
            [vim.diagnostic.severity.WARN]  = signs.Warn,
            [vim.diagnostic.severity.INFO]  = signs.Info,
            [vim.diagnostic.severity.HINT]  = signs.Hint,
          },
          numhl = {
            [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
            [vim.diagnostic.severity.WARN]  = "DiagnosticSignWarn",
            [vim.diagnostic.severity.INFO]  = "DiagnosticSignInfo",
            [vim.diagnostic.severity.HINT]  = "DiagnosticSignHint",
          },
        },
      }


      local servers = {
        vtsls = {
          settings = {
            typescript = {
              inlayHints = {
                parameterNames = { enabled = "literals" },
                parameterTypes = { enabled = true },
                variableTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                enumMemberValues = { enabled = true },
              },
            },
          }
        },

        lua_ls = {
          settings = {
            Lua = {
              telemetry = { enable = false },
              hint = { enable = true },
              diagnostics = {
                globals = { "vim" },
                disable = { "missing-fields" },
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          }
        },

        clangd = {},
        bashls = {},
        yamlls = {},
        jsonls = {},
        cssls = {},
        html = {},
        pyright = {}
      }

      local ensure_installed = vim.tbl_keys(servers or {})

      require('mason').setup()
      require('mason-lspconfig').setup({
        ensure_installed = ensure_installed
      })

      for server, settings in pairs(servers) do
        vim.lsp.config(server, settings)
        vim.lsp.enable(server)
      end
    end,
  }
}
