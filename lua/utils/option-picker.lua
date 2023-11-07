local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local M = {}

--- Displays an option picker based on the output of a command and returns the selected entry
-- @param title string: The title of the picker.
-- @param cmd table: A shell command in the form of a list of strings
-- @param callback function: A callback function that takes the selected entry
function M.option_picker(title, cmd, callback)
  assert(type(title) == 'string', "title must be a string")
  assert(type(cmd) == 'table', "cmd must be a table of strings")
  assert(type(callback) == 'function', "callback must be a function")
  local opts = {}
  pickers
      .new(opts, {
        prompt_title = title,
        finder = finders.new_oneshot_job(cmd, { cwd = vim.loop.cwd() }),
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(buffer_number)
          actions.select_default:replace(function()
            actions.close(buffer_number)
            callback(action_state.get_selected_entry()[1])
          end)
          return true
        end,
      })
      :find()
end

function M.parent_dir_picker(callback)
  return M.option_picker("Select Parent Directory",
    { "bash", "-c", "dir=\"$PWD\"; while [ \"$dir\" != \"/\" ]; do echo \"$dir\"; dir=\"$(dirname \"$dir\")\"; done" },
    callback)
end

return M
