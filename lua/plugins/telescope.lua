local M = {
  "nvim-telescope/telescope.nvim",
  event = "BufReadPre",
  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    { "nvim-telescope/telescope-ui-select.nvim" },
    {
      "nvim-telescope/telescope-frecency.nvim",
      lazy = false,
      dependencies = { "kkharji/sqlite.lua" },
    },
  },
  keys = {
    { "<leader><leader>", "<cmd>Telescope<cr>", "open telescope" }
  },
  opts = function()
    local actions = require("telescope.actions")
    local theme = require("telescope.themes")
    return {
      pickers = {
        find_files = { hidden = true },
        live_grep = {
          additional_args = function(_)
            return { "--hidden" }
          end,
        },
      },
      defaults = {
        vimgrep_arguments = {
          "rg",
          "-L",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
        },
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        prompt_prefix = " ⬢  ",
        mappings = { i = { ["<esc>"] = actions.close } },
      },
      extensions = {
        fzf = {
          fuzzy = true,                   -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true,    -- override the file sorter
          case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
          -- the default case_mode is "smart_case"
        },
        ["ui-select"] = {
          theme.get_dropdown({
            -- even more opts
          }),
        },
        frecency = {},
        neoclip = {}
      },
    }
  end,
  config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup(opts)
    for ext, _ in pairs(opts.extensions) do
      telescope.load_extension(ext)
    end
  end,
}

return M
