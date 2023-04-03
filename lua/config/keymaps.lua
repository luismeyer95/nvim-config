local function termcodes(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local M = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["mm"] = {
      "<cmd> Telescope keymaps <CR>",
      "Open keymaps",
    },
    -- Buffers
    ["<leader>x"] = { function()
      local cur_buf = vim.api.nvim_get_current_buf()
      vim.cmd('bp')
      local ok, _ = pcall(vim.api.nvim_buf_delete, cur_buf, { force = false })
      if not ok then
        vim.cmd('bn')
      end
    end, "close buffer" },
    ["<Tab>"] = { '<cmd>BufferLineCycleNext<CR>', "next buffer", opts = { noremap = true, silent = true } },
    ["<S-Tab>"] = { '<cmd>BufferLineCyclePrev<CR>', "prev buffer", opts = { noremap = true, silent = true } },
    -- Neotree
    ["<leader>st"] = { "<cmd> Neotree toggle <CR>", "toggle neotree" },
    ["<leader>ft"] = { "<cmd> Neotree <CR>", "focus neotree" },
    -- Save + format
    ["<leader>sf"] = { "<cmd>lua vim.lsp.buf.format { async = true }<cr> <cmd>w<cr>", "format + save" },
    -- Better window navigation
    ["<leader>h"] = { "<C-w>h", "go left", opts = { noremap = true } },
    ["<leader>j"] = { "<C-w>j", "go down", opts = { noremap = true } },
    ["<leader>k"] = { "<C-w>k", "go up", opts = { noremap = true } },
    ["<leader>l"] = { "<C-w>l", "go right", opts = { noremap = true } },
    -- Leap cross-window
    ["<leader>gs"] = {
      -- Searching in all windows (including the current one) on the tab page.
      function()
        require("leap").leap {
          target_windows = vim.tbl_filter(function(win)
            return vim.api.nvim_win_get_config(win).focusable
          end, vim.api.nvim_tabpage_list_wins(0)),
        }
      end,
      "leap (all windows)",
    },
    -- Diff view
    ["<leader>vdf"] = { "<cmd>DiffviewOpen HEAD -- %<CR>", "view file diff" },
    ["<leader>vda"] = { "<cmd>DiffviewOpen<CR>", "view diff (all files)" },
    ["<leader>vhf"] = { "<cmd>DiffviewFileHistory %<CR>", "view file history" },
    ["<leader>vha"] = { "<cmd>DiffviewFileHistory<CR>", "view history (all files)" },
    -- Telescope
    -- find
    ["<leader>ff"] = { "<cmd> Telescope find_files <CR>", "find files" },
    ["<leader>fa"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "find all" },
    ["<leader>fw"] = { "<cmd> Telescope live_grep <CR>", "live grep" },
    ["<leader>fg"] = { "<cmd> Telescope git_files <CR>", "git files" },
    ["<leader>fb"] = { "<cmd> Telescope buffers <CR>", "find buffers" },
    ["<leader>fh"] = { "<cmd> Telescope help_tags <CR>", "help page" },
    ["<leader>fo"] = { "<cmd> Telescope oldfiles <CR>", "find oldfiles" },
    ["<leader>tk"] = { "<cmd> Telescope keymaps <CR>", "show keys" },
    ["<leader>fs"] = { "<cmd> Telescope grep_string <CR>", "grep string" },
    -- Telescope undo
    ["<leader>ut"] = { "<cmd>Telescope undo<CR>", "toggle undotree" },
    -- Telescope clipboard
    ["<leader>cb"] = { "<cmd>Telescope neoclip<CR>", "toggle clipboard" },
    -- Telescope frecency
    ["<leader>fr"] = { "<cmd>Telescope frecency<CR>", "toggle frecency" },
    -- Gitsigns
    -- Navigation through hunks
    ["]c"] = {
      function()
        if vim.wo.diff then
          return "]c"
        end
        vim.schedule(function()
          require("gitsigns").next_hunk()
        end)
        return "<Ignore>"
      end,
      "Jump to next hunk",
      opts = { expr = true },
    },
    ["[c"] = {
      function()
        if vim.wo.diff then
          return "[c"
        end
        vim.schedule(function()
          require("gitsigns").prev_hunk()
        end)
        return "<Ignore>"
      end,
      "Jump to prev hunk",
      opts = { expr = true },
    },
    -- Actions
    ["<leader>rh"] = {
      function()
        require("gitsigns").reset_hunk()
      end,
      "Reset hunk",
    },
    ["<leader>ph"] = {
      function()
        require("gitsigns").preview_hunk()
      end,
      "Preview hunk",
    },
    ["<leader>gb"] = {
      function()
        package.loaded.gitsigns.blame_line()
      end,
      "Blame line",
    },
    ["<leader>td"] = {
      function()
        require("gitsigns").toggle_deleted()
      end,
      "Toggle deleted",
    },
    ["<leader>sh"] = {
      function()
        require("gitsigns").stage_hunk()
      end,
      "Stage hunk",
    },
    ["<leader>uh"] = {
      function()
        require("gitsigns").undo_stage_hunk()
      end,
      "Undo stage hunk",
    },
    -- Comment
    ["<leader>/"] = {
      function()
        require("Comment.api").toggle.linewise.current()
      end,
      "toggle comment",
    },
    -- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
    -- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
    -- empty mode is same as using <cmd> :map
    -- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
    ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
    ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
    ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
    ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
    -- LSP config
    ["gD"] = {
      function()
        vim.lsp.buf.declaration()
      end,
      "lsp declaration",
    },
    ["gd"] = {
      function()
        vim.lsp.buf.definition()
      end,
      "lsp definition",
    },
    ["K"] = {
      function()
        vim.lsp.buf.hover()
      end,
      "lsp hover",
    },
    ["gi"] = {
      function()
        vim.lsp.buf.implementation()
      end,
      "lsp implementation",
    },
    ["<leader>D"] = {
      function()
        vim.lsp.buf.type_definition()
      end,
      "lsp definition type",
    },
    ["<leader>rn"] = {
      function()
        vim.lsp.buf.rename()
      end,
      "lsp rename",
    },
    ["<leader>ca"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "lsp code_action",
    },
    ["gr"] = {
      function()
        vim.lsp.buf.references()
      end,
      "lsp references",
    },
    ["<leader>f"] = {
      function()
        vim.diagnostic.open_float()
      end,
      "floating diagnostic",
    },
    ["[d"] = {
      function()
        vim.diagnostic.goto_prev()
      end,
      "goto prev",
    },
    ["d]"] = {
      function()
        vim.diagnostic.goto_next()
      end,
      "goto_next",
    },
    ["<leader>q"] = {
      function()
        vim.diagnostic.setloclist()
      end,
      "diagnostic setloclist",
    },
    ["<leader>fm"] = {
      function()
        vim.lsp.buf.format { async = true }
      end,
      "lsp formatting",
    },
  },
  i = {
    ["jj"] = { "<ESC>", "go to normal mode" },
    ["<Tab>"] = {
      function()
        return vim.fn["codeium#Accept"]()
      end,
      "accept codeium completion",
      opts = { expr = true },
    },
    -- LuaSnip choices
    ["<M-n>"] = {
      "<Plug>luasnip-next-choice",
      "next choice",
    },
    ["<M-p>"] = {
      "<Plug>luasnip-prev-choice",
      "prev choice",
    },
  },
  t = {
    -- Toggleterm
    ["jj"] = { [[<C-\><C-n>]], "escape terminal mode", { buffer = 0 } },
    ["<C-h>"] = { "<cmd>wincmd h<cr>" },
    ["<C-j>"] = { "<cmd>wincmd j<cr>" },
    ["<C-k>"] = { "<cmd>wincmd k<cr>" },
    ["<C-l>"] = { "<cmd>wincmd l<cr>" },
    ["<C-x>"] = { termcodes "<C-\\><C-N>", "escape terminal mode" }
  },
}

return M
