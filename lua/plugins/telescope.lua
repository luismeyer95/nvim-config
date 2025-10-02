local M = {
  "nvim-telescope/telescope.nvim",
  event = "VeryLazy",
  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim",  build = "make" },
    { "nvim-telescope/telescope-ui-select.nvim" },
    { "nvim-telescope/telescope-file-browser.nvim" },
    { "debugloop/telescope-undo.nvim" }
  },
  keys = {
    { "<leader><leader>", "<cmd>Telescope<cr>", "open telescope" }
  },
  opts = function()
    local actions = require("telescope.actions")
    local theme = require("telescope.themes")
    return {
      pickers = {
        find_files = {
          mappings = {
            n = {
              ["cd"] = function(prompt_bufnr)
                local selection = require("telescope.actions.state").get_selected_entry()
                local dir = vim.fn.fnamemodify(selection.path, ":p:h")
                actions.close(prompt_bufnr)
                vim.cmd(string.format("silent tcd %s", dir))
              end,
            }
          }
        },
        live_grep = {
          additional_args = function(_)
            return { "--hidden" }
          end,
        },
        buffers = {
          show_all_buffers = true,
          sort_mru = true,
          mappings = {
            n = {
              ["dd"] = "delete_buffer",
            },
          },
        }
      },
      defaults = {
        cache_picker = {
          num_pickers = 30,
          limit_entries = 1000
        },
        path_display = { "smart" },
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
        mappings = { i = { ["<esc>"] = actions.close }, n = { ["q"] = actions.close } },
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
        neoclip = {},
        -- notify = {},
        file_browser = {},
        undo = {
          mappings = {
            n = {
              ["<cr>"] = require("telescope-undo.actions").yank_additions,
              ["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
              ["<C-cr>"] = require("telescope-undo.actions").restore,
            },
          },
        }
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
