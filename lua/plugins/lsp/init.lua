return {
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "williamboman/mason-lspconfig.nvim",
      "Hoffs/omnisharp-extended-lsp.nvim",
      { "folke/neodev.nvim", opts = { setup_jsonls = false } },
    },
    config = function(_, _)
      local utils = require("utils")
      local mason_lspconfig = require("mason-lspconfig")
      local lspconfig = require("lspconfig")
      local lsp_utils = require("plugins.lsp.lsp-utils")

      vim.diagnostic.config({
        virtual_text = {
          prefix = "●",
          source = true,
        },
        signs = true,
        underline = true,
      })

      ---- sign column
      local signs = require("utils").lsp_signs

      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end


      mason_lspconfig.setup({
        ensure_installed = utils.lsp_servers,
      })

      mason_lspconfig.setup_handlers({
        function(server_name)
          lspconfig[server_name].setup({
            on_attach = lsp_utils.on_attach,
            capabilities = lsp_utils.capabilities,
          })
        end,
      })

      lspconfig.lua_ls.setup({
        on_attach = lsp_utils.on_attach,
        capabilities = lsp_utils.capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' }
            },
            completion = {
              callSnippet = "Replace"
            }
          }
        }
      })

      lspconfig.omnisharp.setup({
        on_attach = lsp_utils.on_attach,
        capabilities = lsp_utils.capabilities,
        handlers = {
          ["textDocument/definition"] = require('omnisharp_extended').handler,
        }
      })
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
      local utils = require("utils")
      local mr = require("mason-registry")
      local packages = utils.mason_packages
      local function ensure_installed()
        for _, package in ipairs(packages) do
          local p = mr.get_package(package)
          if not p:is_installed() then
            p:install()
          end
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
