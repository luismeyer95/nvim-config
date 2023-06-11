local function termcodes(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local M = {
  n = {
    [";"] = { ":", "Enter command mode", opts = { nowait = true } },
    ["<leader>xa"] = { "<cmd>wa | qa<cr>", "Save all and exit" },
    ["<leader>cdf"] = { "<cmd>cd %:p:h<cr>", "Change directory to current file" },
    --Resizing
    ["<M-Up>"] = { "<C-w>+", "Increase height" },
    ["<M-Down>"] = { "<C-w>-", "Decrease height" },
    ["<M-Left>"] = { "<C-w><", "Decrease width" },
    ["<M-Right>"] = { "<C-w>>", "Increase width" },
    -- Buffers
    ["<Tab>"] = { '<cmd>BufferLineCycleNext<CR>', "Next buffer", opts = { noremap = true, silent = true } },
    ["<S-Tab>"] = { '<cmd>BufferLineCyclePrev<CR>', "Prev buffer", opts = { noremap = true, silent = true } },
    -- Neotree
    ["<leader>st"] = { "<cmd> Neotree toggle <CR>", "Toggle neotree" },
    ["<leader>ft"] = { "<cmd> Neotree <CR>", "Focus neotree" },
    -- Save + format
    ["<leader>sf"] = { "<cmd>lua vim.lsp.buf.format { async = true }<cr> <cmd>w<cr>", "Format + save" },
    -- Better window navigation
    ["<M-h>"] = { "<C-w>h", "Go left", opts = { noremap = true } },
    ["<M-j>"] = { "<C-w>j", "Go down", opts = { noremap = true } },
    ["<M-k>"] = { "<C-w>k", "Go up", opts = { noremap = true } },
    ["<M-l>"] = { "<C-w>l", "Go right", opts = { noremap = true } },
    ["<C-h>"] = { "<C-w>h", "Go left", opts = { noremap = true } },
    ["<C-j>"] = { "<C-w>j", "Go down", opts = { noremap = true } },
    ["<C-k>"] = { "<C-w>k", "Go up", opts = { noremap = true } },
    ["<C-l>"] = { "<C-w>l", "Go right", opts = { noremap = true } },
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
      "Leap (all windows)",
    },
    -- Diff view
    ["<leader>vdf"] = { "<cmd>DiffviewOpen HEAD -- %<CR>", "View file diff" },
    ["<leader>vda"] = { "<cmd>DiffviewOpen<CR>", "View diff (all files)" },
    ["<leader>vhf"] = { "<cmd>DiffviewFileHistory %<CR>", "View file history" },
    ["<leader>vha"] = { "<cmd>DiffviewFileHistory<CR>", "View history (all files)" },
    -- Telescope
    -- find
    ["<leader>ff"] = { "<cmd> Telescope find_files <CR>", "Find files" },
    ["<leader>gff"] = { "<cmd> Telescope find_files search_dirs=~ <CR>", "Find files (home)" },
    ["<leader>fa"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "Find all" },
    ["<leader>fw"] = { "<cmd> Telescope live_grep <CR>", "Live grep" },
    ["<leader>fg"] = { "<cmd> Telescope git_files <CR>", "Git files" },
    ["<leader>fb"] = { "<cmd> Telescope buffers <CR>", "Find buffers" },
    ["<leader>fh"] = { "<cmd> Telescope help_tags <CR>", "Find help" },
    ["<leader>fo"] = { "<cmd> Telescope oldfiles <CR>", "Find oldfiles" },
    ["<leader>tk"] = { "<cmd> Telescope keymaps <CR>", "Show keys" },
    ["<leader>fs"] = { "<cmd> Telescope grep_string <CR>", "Grep string" },
    -- Telescope undo
    ["<leader>ut"] = { "<cmd>Telescope undo<CR>", "Toggle undotree" },
    -- Telescope clipboard
    ["<leader>cb"] = { "<cmd>Telescope neoclip<CR>", "Toggle clipboard" },
    -- Gitsigns
    -- Navigation through hunks
    ["]h"] = {
      function()
        if vim.wo.diff then
          return "]h"
        end
        vim.schedule(function()
          require("gitsigns").next_hunk()
        end)
        return "<Ignore>"
      end,
      "Jump to next hunk",
      opts = { expr = true },
    },
    ["[h"] = {
      function()
        if vim.wo.diff then
          return "[h"
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
      "Toggle comment",
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
    ["<leader>gD"] = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "LSP declaration" },
    ["<leader>gd"] = { "<cmd>Telescope lsp_definitions<CR>", "LSP definition" },
    ["K"] = { '<cmd>lua vim.lsp.buf.hover()<CR>', "LSP hover", },
    ["<leader>gi"] = { "<cmd>Telescope lsp_implementations<CR>", "LSP implementations" },
    ["<leader>gt"] = { "<cmd>Telescope lsp_type_definitions<CR>", "LSP type definition" },
    ["<leader>gr"] = { "<cmd>Telescope lsp_references<CR>", "LSP references" },
    ["<leader>wa"] = { "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", "Add workspace folder" },
    ["<leader>wr"] = { "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", "Remove workspace folder" },
    ["<leader>wl"] = { "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", "List workspace folders" },
    ["<leader>rn"] = {
      function()
        vim.lsp.buf.rename()
      end,
      "LSP rename",
    },
    ["<leader>ca"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "LSP code_action",
    },
    ["<leader>fd"] = { "<cmd>lua vim.diagnostic.open_float()<CR>", "Floating diagnostic" },
    ["[d"] = {
      function()
        vim.diagnostic.goto_prev()
      end,
      "Go to previous diagnostic",
    },
    ["d]"] = {
      function()
        vim.diagnostic.goto_next()
      end,
      "Go to next diagnostic",
    },
    ["<leader>q"] = {
      function()
        vim.diagnostic.setloclist()
      end,
      "Diagnostic setloclist",
    },
    ["<leader>fm"] = {
      function()
        vim.lsp.buf.format { async = true }
      end,
      "LSP formatting",
    },
    -- NeoAI
    ["<leader>ai"] = {
      "<cmd>NeoAI<CR>", "Toggle AI window",
    },
    -- Debugger
    ["<leader>db"] = { function() require("dap").toggle_breakpoint() end, "Toggle Breakpoint" },
    ["<leader>dB"] = { function() require("dap").clear_breakpoints() end, "Clear Breakpoints" },
    ["<leader>dc"] = { function() require("dap").continue() end, "Start/Continue" },
    ["<leader>di"] = { function() require("dap").step_into() end, "Step Into" },
    ["<leader>do"] = { function() require("dap").step_over() end, "Step Over" },
    ["<leader>dO"] = { function() require("dap").step_out() end, "Step Out" },
    ["<leader>dq"] = { function() require("dap").close() end, "Close Session" },
    ["<leader>dQ"] = { function() require("dap").terminate() end, "Terminate Session" },
    ["<leader>dp"] = { function() require("dap").pause() end, "Pause" },
    ["<leader>dr"] = { function() require("dap").restart_frame() end, "Restart" },
    ["<leader>dR"] = { function() require("dap").repl.toggle() end, "Toggle REPL" },
    ["<leader>du"] = { function() require("dapui").toggle() end, "Toggle Debugger UI" },
    ["<leader>dh"] = { function() require("dap.ui.widgets").hover() end, "Debugger Hover" },

    -- Neotest
    ["<leader>tw"] = { function() require("neotest").summary.toggle() end, "Toggle Neotest" },

    -- Ng
    ["<leader>at"] = { function() require("ng").goto_template_for_component() end, "Go to template (Angular)", opts = {
      noremap = true } },
    ["<leader>ac"] = { function() require("ng").goto_component_with_template_file() end, "Go to component (Angular)", opts = {
      noremap = true } },

  },
  i = {
    ["jj"] = { "<ESC>", "Go to normal mode" },
    -- LuaSnip choices
    ["<M-Tab>"] = { "<Plug>luasnip-expand-or-jump", "Expand or jump (luasnip)" },
    ["<M-n>"] = {
      "<Plug>luasnip-next-choice",
      "Next choice (luasnip)",
    },
    ["<M-p>"] = {
      "<Plug>luasnip-prev-choice",
      "Prev choice (luasnip)",
    },
    -- Completion
    ["<C-l>"] = {
      function()
        local cmp = require("cmp")
        if cmp.visible() then
          cmp.abort()
          return ""
        else
          return vim.fn["codeium#Accept"]()
        end
      end,
      "Codeium complete",
      opts = { expr = true, }
    },
  },
  t = {
    -- Toggleterm
    ["jj"] = { [[<C-\><C-n>]], "Escape terminal mode", { buffer = 0 } },
    ["<C-h>"] = { "<cmd>wincmd h<cr>", "Go left" },
    ["<C-j>"] = { "<cmd>wincmd j<cr>", "Go down" },
    ["<C-k>"] = { "<cmd>wincmd k<cr>", "Go up" },
    ["<C-l>"] = { "<cmd>wincmd l<cr>", "Go right" },
    ["<C-x>"] = { termcodes "<C-\\><C-N>", "Escape terminal mode" }
  },
  v = {
    [";"] = { ":", "Enter command mode", opts = { nowait = true } },
    ["<leader>ai"] = {
      -- `:` instead of <cmd> required here in order to auto-insert visual selection marks
      ":NeoAIContext<cr>", "Toggle AI window (visual context)",
      opts = { noremap = true, }
    },
  }
}

return M
