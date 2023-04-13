local M = {
    "numToStr/Comment.nvim",
    keys = {
        {
            "<leader>/",
            mode = "n",
            "<Plug>(comment_toggle_linewise_current)",
        },
        {
            "<leader>/",
            mode = "v",
            "<Plug>(comment_toggle_linewise_visual)",
        },
        {
            "<C-M-/>",
            mode = "n",
            "<Plug>(comment_toggle_blockwise_current)",
        },
        {
            "<C-M-/>",
            mode = "x",
            "<Plug>(comment_toggle_blockwise_visual)",
        },
    },
    opts = {
        mappings = {
            basic = false,
            extra = false,
        },
    },
}

return M