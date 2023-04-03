require("config.options")
require("config.lazy")

local keymaps = require("config.keymaps")
for mode, mode_values in pairs(keymaps) do
  for keybind, mapping_info in pairs(mode_values) do
    -- merge default + user opts
    local opts = vim.tbl_deep_extend("force", {}, mapping_info.opts or {})
    mapping_info.opts, opts.mode = nil, nil
    opts.desc = mapping_info[2]
    vim.keymap.set(mode, keybind, mapping_info[1], opts)
  end
end

vim.cmd('colorscheme rose-pine')
vim.lsp.set_log_level("debug")
