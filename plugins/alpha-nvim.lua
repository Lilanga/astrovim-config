return {
    "goolord/alpha-nvim",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = "VimEnter",
    lazy = true,
    config = function ()
        local dashboard = require "alpha.themes.dashboard"
        dashboard.opts.opts.noautocmd = true
        dashboard.section.header.val = require "user.util.dashboard_image".bat2
      require "alpha".setup(dashboard.opts)
    end
  }