return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = "BufReadPost",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-refactor",
  },
  opts = {
    highlight = {
      enable = true,
      disable = function(_, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then return true end
      end,
      additional_vim_regex_highlighting = false,
    },
    autopairs = { enable = true },
    indent = { enable = true },
    ensure_installed = {
      "c",
      "lua",
      "vim",
      "vimdoc",
      "rust",
      "typescript",
      "tsx",
      "markdown",
      "markdown_inline",
      "c_sharp",
    },
    sync_install = true,
    ignore_install = {}, -- List of parsers to ignore installation
    refactor = {
      highlight_definitions = {
        enable = true,
        -- Set to false if you have an `updatetime` of ~100.
        clear_on_cursor_move = true,
      },
      highlight_current_scope = { enable = false },
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<leader>q", -- set to `false` to disable one of the mappings
        node_incremental = "q", -- scope out
        node_decremental = "w", -- scope in
        scope_incremental = "grc",
      },
    },
  },
  config = function(_, opts) require("nvim-treesitter.configs").setup(opts) end,
}
