return {
  "mfussenegger/nvim-lint",
  enabled = false,
  ft = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
  },
  opts = {
    linters_by_ft = {
      typescriptreact = { "eslint_d" },
      typescript = { "eslint_d" },
      javascript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
    },
  },
  config = function(_, opts)
    -- npm install -g eslint_d
    local lint = require "lint"
    lint.linters_by_ft = opts.linters_by_ft

    vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
      group = vim.api.nvim_create_augroup("Lint", { clear = true }),
      callback = function() require("lint").try_lint() end,
    })
  end,
}
