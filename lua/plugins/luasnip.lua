return {
  -- snippet plugin
  "L3MON4D3/LuaSnip",
  dependencies = "rafamadriz/friendly-snippets",
  opts = { history = true, updateevents = "TextChanged,TextChangedI" },
  config = function(_, opts)
    require("luasnip").config.set_config(opts)
    require("config.snippets")
    require("luasnip.loaders.from_vscode").lazy_load()

    vim.api.nvim_create_autocmd("InsertLeave", {
      callback = function()
        if
            require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
            and not require("luasnip").session.jump_active
        then
          require("luasnip").unlink_current()
        end
      end,
    })
  end,
}
