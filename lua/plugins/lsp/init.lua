return {
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "williamboman/mason-lspconfig.nvim",
      "folke/neodev.nvim",
    },
    config = function(_, _)
      local lspconfig = require "lspconfig"
      local lsp_utils = require "plugins.lsp.lsp-utils"
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

      lspconfig.lua_ls.setup {
        on_attach = lsp_utils.on_attach,
        capabilities = lsp_utils.capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            completion = {
              callSnippet = "Replace",
            },
          },
        },
      }

      lspconfig.vtsls.setup {
        on_attach = lsp_utils.on_attach,
        capabilities = lsp_utils.capabilities,
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
        },
      }
    end,
  },
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    opts = {
      pip = {
        upgrade_pip = true,
      },
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      local utils = require "utils"
      local mr = require "mason-registry"
      local packages = utils.mason_packages
      local function ensure_installed()
        for _, package in ipairs(packages) do
          local p = mr.get_package(package)
          if not p:is_installed() then p:install() end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },
}
