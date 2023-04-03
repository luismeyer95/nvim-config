local M = {
  "hrsh7th/nvim-cmp",
  event = "BufReadPre",
  dependencies = {
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",

    "L3MON4D3/LuaSnip",
    "windwp/nvim-autopairs",
    "onsails/lspkind.nvim"
  },
  opts = function()
    local cmp = require("cmp")
    local lsp_kinds = require("utils").lsp_kinds

    return {
      completion = {
        completeopt = "menu,menuone",
      },
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      mapping = {
        ["<C-'>"] = cmp.mapping.abort(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        },
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif require("luasnip").expand_or_jumpable() then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true),
              "")
          else
            fallback()
          end
        end, {
          "i",
          "s",
        }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif require("luasnip").jumpable(-1) then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
          else
            fallback()
          end
        end, {
          "i",
          "s",
        }),
      },
      sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "nvim_lua" },
        { name = "path" },
      },
      formatting = {
        format = function(entry, vim_item)
          if vim.tbl_contains({ "path" }, entry.source.name) then
            local icon, hl_group = require("nvim-web-devicons").get_icon(entry:get_completion_item().label)
            if icon then
              vim_item.kind = icon
              vim_item.kind_hl_group = hl_group
              return vim_item
            end
          end
          vim_item.kind = (lsp_kinds[vim_item.kind] or "") .. " " .. vim_item.kind

          return vim_item
        end,
        -- format = require("lspkind").cmp_format {
        --     mode = "symbol_text",
        --     maxwidth = 50,
        --     ellipsis_char = "...",
        -- },
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      experimental = {
        ghost_text = {
          hl_group = "LspCodeLens",
        }
      },
    }
  end,
  config = function(_, opts)
    local cmp = require("cmp")
    cmp.setup(opts)
  end,
}

return M
