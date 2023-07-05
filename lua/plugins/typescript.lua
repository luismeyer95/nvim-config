local lsp_utils = require("plugins.lsp.lsp-utils")

return {
  "jose-elias-alvarez/typescript.nvim",
  lazy = false,
  opts = {
    disable_commands = false, -- prevent the plugin from creating Vim commands
    debug = false,            -- enable debug logging for commands
    go_to_source_definition = {
      fallback = true,        -- fall back to standard LSP definition on failure
    },
    server = {
      on_attach = function(client, bufnr)
        lsp_utils.on_attach(client, bufnr)
        -- WARNING: this disables document formatting to not conflict with prettier
        -- client.server_capabilities.documentFormattingProvider = false -- 0.8 and later
      end,
      capabilities = lsp_utils.capabilities,
    },
  }
}
