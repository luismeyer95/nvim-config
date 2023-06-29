return {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    opts = {
        signs = {
            add = { hl = "DiffAdd", text = "│", numhl = "GitSignsAddNr" },
            change = { hl = "DiffChange", text = "│", numhl = "GitSignsChangeNr" },
            delete = { hl = "DiffDelete", text = "", numhl = "GitSignsDeleteNr" },
            topdelete = { hl = "DiffDelete", text = "‾", numhl = "GitSignsDeleteNr" },
            changedelete = { hl = "DiffChangeDelete", text = "~", numhl = "GitSignsChangeNr" },
            untracked = { hl = "GitSignsAdd", text = "│", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
        },
    },
    config = function(_, opts)
        require("gitsigns").setup(opts)
    end,
}
