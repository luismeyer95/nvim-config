return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function(_, opts)
    local npairs = require "nvim-autopairs"
    npairs.setup {
      check_ts = true, -- Enable Treesitter if available
      fast_wrap = {},
      disable_filetype = { "TelescopePrompt", "vim" },
      ts_config = {
        lua = { "string" }, -- it will not add a pair on that treesitter node
        javascript = { "template_string" },
        typescript = { "template_string", "string" },
        typescriptreact = { "template_string", "string" },
      },
    }
    -- setup cmp for autopairs
    local cmp_autopairs = require "nvim-autopairs.completion.cmp"
    require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end,
}
