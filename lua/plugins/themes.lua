return {
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    opts = {
      disable_italics = true
    }
  },
  { "kartikp10/noctis.nvim",      name = "noctis",    dependencies = { "rktjmp/lush.nvim" }, lazy = false },
  { "haishanh/night-owl.vim",     name = "night-owl", lazy = false },
  { "bluz71/vim-nightfly-colors", name = "nightfly",  lazy = false },
  {
    "EdenEast/nightfox.nvim",
    name = "nightfox",
    lazy = false,
    opts = {
      options = { transparent = true } }
  },
  { "folke/tokyonight.nvim", name = "tokyonight", lazy = false },
}
