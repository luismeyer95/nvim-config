return {
  "simrat39/rust-tools.nvim",
  dependencies = { "nvim-lspconfig", "hrsh7th/cmp-nvim-lsp" },
  ft = "rust",
  config = function()
    local lspconfig = require "plugins.lsp.lsp-utils"
    local rt = require "rust-tools"

    rt.setup {
      server = {
        on_attach = function(client, bufnr)
          lspconfig.on_attach(client, bufnr)
          -- Hover actions
          vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
          -- Code action groups
          vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
        end,
      },
    }
  end,
}
