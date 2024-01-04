return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim",
    "rouge8/neotest-rust",
    'haydenmeade/neotest-jest',
    "Issafalcon/neotest-dotnet"
  },
  opts = function()
    return {
      log_level = vim.log.levels.TRACE,
      adapters = {
        require("neotest-rust"),
        require('neotest-jest')({
          jestCommand = "npm test -- ",
          cwd = function()
            return vim.fn.getcwd()
          end,
        }),
        require("neotest-dotnet")({
          loglevel = 1,
          -- Extra arguments for nvim-dap configuration
          -- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
          dap = { justMyCode = false },
          -- Provide any additional "dotnet test" CLI commands here. These will be applied to ALL test runs performed via neotest. These need to be a table of strings, ideally with one key-value pair per item.
          dotnet_additional_args = {
            -- "--verbosity detailed"
          },
          -- Tell neotest-dotnet to use either solution (requires .sln file) or project (requires .csproj or .fsproj file) as project root
          -- Note: If neovim is opened from the solution root, using the 'project' setting may sometimes find all nested projects, however,
          --       to locate all test projects in the solution more reliably (if a .sln file is present) then 'solution' is better.
          discovery_root = "solution"
        })
      }
    }
  end
}
