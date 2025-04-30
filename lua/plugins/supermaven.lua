return {
  "supermaven-inc/supermaven-nvim",
  event = "InsertEnter",
  keys = {
    {
      "<C-j>",
      function() require("supermaven-nvim.completion_preview").on_accept_suggestion_word() end,
      mode = "i",
      desc = "Accept Word",
    },
  },
  disable_keymaps = true,
  config = function()
    require("supermaven-nvim").setup({})
  end,
}
