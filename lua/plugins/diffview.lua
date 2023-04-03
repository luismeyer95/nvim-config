return {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    init = function()
        -- load gitsigns only when a git file is opened
        vim.api.nvim_create_autocmd({ "BufRead" }, {
            group = vim.api.nvim_create_augroup("DiffviewLazyLoad", { clear = true }),
            callback = function()
                vim.fn.system("git -C " .. vim.fn.expand "%:p:h" .. " rev-parse")
                if vim.v.shell_error == 0 then
                    vim.api.nvim_del_augroup_by_name "DiffviewLazyLoad"
                    vim.schedule(function()
                        require("lazy").load { plugins = { "diffview.nvim" } }
                    end)
                end
            end,
        })
    end,
}
