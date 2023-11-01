local function print_all_cwds()
  print("global: " .. vim.fn.getcwd(-1, -1))
  print("tab: " .. vim.fn.getcwd(-1, 0))
  print("win: " .. vim.fn.getcwd(0, 0))
  print("resolved: " .. vim.fn.getcwd())
  print(vim.cmd("verbose pwd"))
end



print_all_cwds()
-- vim.cmd("vsplit")
print("error " .. vim.v.errmsg)
print_all_cwds()
