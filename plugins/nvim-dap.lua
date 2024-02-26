return {
{    "mfussenegger/nvim-dap",
    enabled = vim.fn.has "win32" == 0,
    dependencies = {
      {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = { "nvim-dap" },
        cmd = { "DapInstall", "DapUninstall" },
        opts = { handlers = {} },
      },
    },
    event = "User AstroFile",
  },
  {
    "rcarriga/cmp-dap",
    dependencies = { "nvim-cmp" },
    config = require "user.plugins.configs.cmp-dap",
  },
  {
    "rcarriga/nvim-dap-ui",
    opts = { floating = { border = "rounded" } },
    requires = {"mfussenegger/nvim-dap"},
    config = require "user.plugins.configs.nvim-dap-ui",
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    requires = { "nvim-dap" },
    config = require "user.plugins.configs.nvim-dap-virtual-text",
  }
}