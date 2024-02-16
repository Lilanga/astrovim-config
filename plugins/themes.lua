-- Themes for AstroNvim
-- aka colorscheme

-- `SPC f t` selector shows all themes and their variants
-- Themes are configured to disable lazy loading so they are selectable
-- default theme is defined in `init.lua` using the `colorscheme` option

return {
  {
    "folke/styler.nvim",
    event = "VeryLazy",
    config = function()
      require("styler").setup {
        themes = {
          markdown = { colorscheme = "gruvbox" },
          help = { colorscheme = "gruvbox" },
        },
      }
    end,
  },
  {
    "folke/twilight.nvim",
    lazy = false,
    config = function()
      require("twilight").setup {
        dimming = {
          alpha = 0.25, -- amount of dimming
          -- we try to get the foreground from the highlight groups or fallback color
          color = { "Normal", "#ffffff" },
        },
      }
    end,
  },
  {
    "folke/zen-mode.nvim",
    lazy = false,
    config = function()
      require("zen-mode").setup {
        window = {
          backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
          width = 120, -- width of the Zen window
          height = 1, -- height of the Zen window
          options = {
            signcolumn = "no", -- disable signcolumn
            number = false, -- disable number column
            relativenumber = false, -- disable relative numbers
            cursorline = false, -- disable cursorline
            cursorcolumn = false, -- disable cursor column
            foldcolumn = "0", -- disable fold column
            list = false, -- disable whitespace characters
          },
        },
        plugins = {
          gitsigns = { enabled = false }, -- disables git signs
          tmux = { enabled = false }, -- disables the tmux statusline
          twilight = { enabled = false }, -- disables twilight
        },
        on_open = function()
          vim.cmd "set foldlevel=20" -- this sets the initial foldlevel to open all folds
        end,
        on_close = function()
          vim.cmd "set foldlevel=0" -- this sets the initial foldlevel to close all folds
        end,
      }
    end,
  },
  {
    "Pocco81/TrueZen.nvim",
    lazy = false,
    config = function()
      require("true-zen").setup {
        ui = {
          bottom = {
            laststatus = 0,
            ruler = false,
            showmode = false,
            showcmd = false,
            cmdheight = 1,
          },
          top = {
            showtabline = 0,
          },
          left = {
            number = false,
            relativenumber = false,
            signcolumn = "no",
          },
        },
        modes = {
          ataraxis = { left_padding = 32, right_padding = 32, top_padding = 1, bottom_padding = 1 },
          focus = { margin_of_error = 5, focus_method = "experimental" },
        },
        integrations = {
          vim_gitgutter = false,
          galaxyline = true,
          tmux = true,
          gitsigns = false,
          nvim_bufferline = true,
          limelight = false,
          vim_airline = false,
          vim_powerline = false,
          vim_signify = false,
          express_line = false,
          lualine = true,
        },
      }
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "storm",
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
    config = function(_, opts)
      local tokyonight = require "tokyonight"
      tokyonight.setup(opts)
      tokyonight.load()
    end,
  },
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
  },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    config = function()
      require("gruvbox").setup()
    end,
  },
  {
    "AstroNvim/astrotheme", -- default AstroNvim theme
    lazy = false,
  },
  -- Add the community repository of plugin specifications
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.colorscheme.everforest" },
  {
    "sainnhe/everforest",
    lazy = false,
  },
  { import = "astrocommunity.colorscheme.nightfox-nvim" },
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
  },
  { import = "astrocommunity.colorscheme.kanagawa-nvim" },
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
  },
  { import = "astrocommunity.colorscheme.github-nvim-theme" }, -- no background support
  {
    "projekt0n/github-nvim-theme",
    lazy = false,
  },
}
