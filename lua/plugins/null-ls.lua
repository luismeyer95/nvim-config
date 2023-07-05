return {
  "jose-elias-alvarez/null-ls.nvim",
  dependencies = {
    "jose-elias-alvarez/typescript.nvim",
  },
  lazy = false,
  opts = function()
    local null_ls = require "null-ls"
    return {
      sources = {
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.code_actions.eslint,
        require("typescript.extensions.null-ls.code-actions"),
      },
    }
  end
}
