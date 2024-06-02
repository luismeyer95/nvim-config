local prompt = require("utils.prompt").prompt

return {
  'ThePrimeagen/git-worktree.nvim',
  opts = {
    change_directory_command = 'tcd'
  },
  keys = {
    {
      "<leader>cw",
      function()
        prompt('Create worktree: ', function(name)
          local basename = string.gsub(name, "(.*/)(.*)", "%2")
          require('git-worktree').create_worktree(name, basename, 'origin')
        end)
      end,
      desc = "Open worktree"
    },
    {
      "<leader>sw",
      function()
        prompt('Switch to worktree: ', function(name) require('git-worktree').switch_worktree(name) end)
      end,
      desc = "Switch to existing worktree"
    },
    {
      "<leader>dw",
      function()
        prompt('Delete worktree: ', function(name) require('git-worktree').delete_worktree(name) end)
      end,
      desc = "Delete existing worktree"
    },
  }
}
