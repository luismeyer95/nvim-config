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
    },
}

return M
