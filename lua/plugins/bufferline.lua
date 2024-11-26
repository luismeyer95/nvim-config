return {
  "akinsho/bufferline.nvim",
  event = "VimEnter",
  dependencies = 'nvim-tree/nvim-web-devicons',
  keys = {
    { "<leader>p", "<cmd>BufferLineTogglePin<cr>" },
  },
  opts = {
    options = {
      diagnostics = "nvim_lsp",
      hover = {
        enabled = true,
        delay = 0,
        reveal = { "close" },
      },
      offsets = {
        {
          filetype = "neo-tree",
          text = "File Explorer",
          highlight = "Directory",
          separator = true -- use a "true" to enable the default, or set your own character
        }
      }
    },
  },
}
