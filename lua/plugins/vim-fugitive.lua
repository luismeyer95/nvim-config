return {
    "tpope/vim-fugitive",
    init = function()
        -- load gitsigns only when a git file is opened
        vim.api.nvim_create_autocmd({ "BufRead" }, {
            group = vim.api.nvim_create_augroup("VimFugitiveLazyLoad", { clear = true }),
            callback = function()
                vim.fn.system("git -C " .. vim.fn.expand "%:p:h" .. " rev-parse")
                if vim.v.shell_error == 0 then
                    vim.api.nvim_del_augroup_by_name "VimFugitiveLazyLoad"
                    vim.schedule(function()
                        require("lazy").load { plugins = { "vim-fugitive" } }
                    end)
                end
            end,
        })
    end,
}
