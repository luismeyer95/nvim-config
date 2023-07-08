local prompt_name = function(cb)
  local opts = {
    prompt = "Enter mark name: ",
  }

  vim.ui.input(opts, function(name)
    if name ~= '' then
      cb(name)
    else
      print('No name entered')
    end
  end)
end

return {
  "cbochs/grapple.nvim",
  keys = {
    { "<leader>m",  function() require("grapple").toggle() end,        desc = "Toggle mark (Grapple)" },
    { "<leader>cm", function() require("grapple").cycle_forward() end, desc = "Cycle marks (Grapple)" },
    { "<leader>vm", "<cmd>GrapplePopup tags<cr>", desc = "View marks (Grapple)" },
    {
      "<leader>nm",
      function()
        prompt_name(function(name) require("grapple").toggle({ key = name }) end)
      end,
      desc = "Create named mark (Grapple)"
    },
    {
      "<leader>gm",
      function()
        prompt_name(function(name) require("grapple").select({ key = name }) end)
      end,
      desc = "Create named mark (Grapple)"
    },
  },
  lazy = false
}
