return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    opts = {
      disable_italics = true,
    },
  },
  { "kartikp10/noctis.nvim",  name = "noctis",    dependencies = { "rktjmp/lush.nvim" }, event = "VeryLazy" },
  { "haishanh/night-owl.vim", name = "night-owl", event = "VeryLazy" },
  {
    "bluz71/vim-nightfly-colors",
    name = "nightfly",
    config = function() vim.g.nightflyTransparent = true end,
  },
  {
    "EdenEast/nightfox.nvim",
    name = "nightfox",
    opts = {
      options = { transparent = true },
    },
  },
  {
    "folke/tokyonight.nvim",
    name = "tokyonight",
    opts = {
      on_colors = function(colors) colors.fg = "#abcdeb" end,
    },
  },
  {
    "RRethy/nvim-base16",
  },
}
