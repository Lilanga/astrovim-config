return {
    "mfussenegger/nvim-dap",
    enabled = vim.fn.has "win32" == 0,
    dependencies = {
      {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = { "nvim-dap" },
        cmd = { "DapInstall", "DapUninstall" },
        opts = { handlers = {} },
      },
      {
        "rcarriga/nvim-dap-ui",
        opts = { floating = { border = "rounded" } },
        config = require "user.plugins.configs.nvim-dap-ui",
      },
      {
        "rcarriga/cmp-dap",
        dependencies = { "nvim-cmp" },
        config = require "user.plugins.configs.cmp-dap",
      },
    },
    event = "User AstroFile",
}