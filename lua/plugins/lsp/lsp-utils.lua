local M = {}

-- TODO: remove hack on update to v0.11 (https://github.com/neovim/neovim/issues/26520)
local capabilities = vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), {
  workspace = {
    didChangeWatchedFiles = {
      dynamicRegistration = false,
    },
  },
})
-- local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem.snippetSupport = true

M.capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
M.on_attach = function(client, bufnr)
  -- if client.server_capabilities.inlayHintProvider then
  --   vim.g.inlay_hints_visible = true
  -- end
end

return M
