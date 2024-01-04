vim.api.nvim_create_user_command("LuaDebugServer", function()
  require("osv").launch({ port = 8086 })
end, {})

vim.api.nvim_create_user_command("LuaDebugThis", function()
  require("osv").run_this()
end, {})
