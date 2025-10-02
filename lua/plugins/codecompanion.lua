return {
  "olimorris/codecompanion.nvim",
  event = "VeryLazy",
  opts = {
    keymaps = {
    },
    display = {
      chat = {
        window = {
          width = 0.25,
        },
      },
      diff = {
        provider = 'mini_diff'
      }
    },
    strategies = {
      inline = {
        adapter = "gemini",
        model = "gemini-2.5-flash",
        keymaps = {
          accept_change = {
            modes = { n = "<leader>as" },
            description = "Accept the suggested change",
          },
          reject_change = {
            modes = { n = "<leader>rs" },
            description = "Reject the suggested change",
          },
        },
      },
      chat = {
        adapter = "gemini_cli", -- use gemini_cli for ACP
        model = "gemini-2.5-flash"
      },
      cmd = {
        adapter = "gemini", -- use gemini_cli for ACP
        model = "gemini-2.5-flash"
      },
    },
    adapters = {
      acp = {
        gemini_cli = function()
          return require("codecompanion.adapters").extend("gemini_cli", {
            defaults = {
              timeout = 50000,
              auth_method = "gemini-api-key",
            },
          })
        end,
      },
      http = {
        gemini = function()
          return require("codecompanion.adapters").extend("gemini", {
            defaults = {
              timeout = 50000,
              auth_method = "gemini-api-key",
            },
          })
        end,
      }
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "ravitemer/mcphub.nvim",
  },
}
