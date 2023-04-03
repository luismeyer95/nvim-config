local M = {}

M.git_colors = {
  GitAdd = "#A1C281",
  GitChange = "#74ADEA",
  GitDelete = "#FE747A",
}
M.lsp_signs = { Error = "✖ ", Warn = "! ", Hint = "󰌶 ", Info = " " }

M.lsp_kinds = {
  Text = " ",
  Method = " ",
  Function = " ",
  Constructor = " ",
  Field = " ",
  Variable = " ",
  Class = " ",
  Interface = " ",
  Module = " ",
  Property = " ",
  Unit = " ",
  Value = " ",
  Enum = " ",
  Keyword = " ",
  Snippet = " ",
  Color = " ",
  File = " ",
  Reference = " ",
  Folder = " ",
  EnumMember = " ",
  Constant = " ",
  Struct = " ",
  Event = " ",
  Operator = " ",
  TypeParameter = " ",
  Copilot = " ",
  Namespace = " ",
  Package = " ",
  String = " ",
  Number = " ",
  Boolean = " ",
  Array = " ",
  Object = " ",
  Key = " ",
  Null = " ",
}

M.mason_packages = {
  "bash-language-server",
  "clang-format",
  "clangd",
  "codelldb",
  "css-lsp",
  "eslint-lsp",
  "html-lsp",
  "json-lsp",
  "lua-language-server",
  "prettier",
  "stylua",
  "tailwindcss-language-server",
  "typescript-language-server",
  "yaml-language-server",
  "editorconfig-checker",
}

M.lsp_servers = {
  "clangd",
  "tsserver",
  "lua_ls",
  "eslint",
  "bashls",
  "yamlls",
  "jsonls",
  "cssls",
  "html",
  "tailwindcss",
  "angularls",
  "pyright",
  "omnisharp",
}

return M
