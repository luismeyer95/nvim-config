return {
  "seblyng/roslyn.nvim",
  lazy = false,
  ft = "cs",
  opts = {
    config = {
      cmd = {
        "Microsoft.CodeAnalysis.LanguageServer",
        "--logLevel=Information",
        "--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
        "--stdio",
      }
    },
  },
}
