return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    opts = {
      disable_italics = true,
    },
  },
  { "kartikp10/noctis.nvim", name = "noctis", dependencies = { "rktjmp/lush.nvim" }, lazy = false },
  { "haishanh/night-owl.vim", name = "night-owl", lazy = false },
  {
    "bluz71/vim-nightfly-colors",
    name = "nightfly",
    lazy = false,
    config = function() vim.g.nightflyTransparent = true end,
  },
  {
    "EdenEast/nightfox.nvim",
    name = "nightfox",
    lazy = false,
    opts = {
      options = { transparent = true },
    },
  },
  {
    "folke/tokyonight.nvim",
    name = "tokyonight",
    lazy = false,
    opts = {
      on_colors = function(colors) colors.fg = "#abcdeb" end,
    },
  },
  {
    "RRethy/nvim-base16",
    lazy = false,
  },
}
