return {
  "jose-elias-alvarez/null-ls.nvim",
  lazy = false,
  opts = function()
    local null_ls = require "null-ls"
    return {
      sources = {
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.code_actions.eslint,
        null_ls.builtins.code_actions.refactoring
      },
    }
  end
}
