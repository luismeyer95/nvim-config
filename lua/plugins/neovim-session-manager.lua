return {
  "Shatur/neovim-session-manager",
  lazy = false,
  keys = {
    { "<leader>Sl", "<cmd>SessionManager! load_last_session<cr>",        desc = "Load last session" },
    { "<leader>Ss", "<cmd>SessionManager! save_current_session<cr>",     desc = "Save this session" },
    { "<leader>Sd", "<cmd>SessionManager! delete_session<cr>",           desc = "Delete session" },
    { "<leader>Sf", "<cmd>SessionManager! load_session<cr>",             desc = "Search sessions" },
    { "<leader>S.", "<cmd>SessionManager! load_current_dir_session<cr>", desc = "Load current directory session" },
  },
  opts = {
    autosave_ignore_filetypes = {
      'gitcommit',
      'toggleterm',
    },
  }
}
