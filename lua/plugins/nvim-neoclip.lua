return {
  "AckslD/nvim-neoclip.lua",
  keys = {
    {
      "<leader>cb",
      mode = "n",
      "<cmd>Telescope neoclip<cr>",
    },
  },
  dependencies = {
    { 'kkharji/sqlite.lua' },
    { 'nvim-telescope/telescope.nvim' },
  },
  config = function()
    require('neoclip').setup()
  end,
}
