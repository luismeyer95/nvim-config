return {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = { { "<C-\\>" } },
    config = function()
        require("toggleterm").setup {
            open_mapping = [[<c-\>]],
            terminal_mappings = true,
        }
    end,
}
