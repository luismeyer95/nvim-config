-- lazy.nvim
return {
  "GustavEikaas/easy-dotnet.nvim",
  ft = "cs",
  dependencies = { "nvim-lua/plenary.nvim", 'nvim-telescope/telescope.nvim', },
  config = function()
    require("easy-dotnet").setup()
  end
}
