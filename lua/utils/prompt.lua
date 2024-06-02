local prompt = function(p, cb)
  local opts = {
    prompt = p,
  }

  vim.ui.input(opts, function(input)
    if input ~= '' then
      cb(input)
    else
      print('Nothing entered')
    end
  end)
end

return {
  prompt = prompt
}
