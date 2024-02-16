return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", enabled = vim.fn.executable "make" == 1, build = "make" },
    },
    cmd = "Telescope",
    opts = function()
      local actions = require "telescope.actions"
      local get_icon = require("astronvim.utils").get_icon
      return {
        defaults = {
          git_worktrees = vim.g.git_worktrees,
          prompt_prefix = get_icon("Selected", 1),
          selection_caret = get_icon("Selected", 1),
          path_display = { "truncate" },
          sorting_strategy = "ascending",
          layout_config = {
            horizontal = { prompt_position = "top", preview_width = 0.55 },
            vertical = { mirror = false },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
          },
          mappings = {
            i = {
              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
            },
            n = { q = actions.close },
          },
        },
      }
    end,
    config = require "user.plugins.configs.telescope",
  },
  {
    "nvim-telescope/telescope-media-files.nvim",
    requires = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").load_extension "media_files"
    end,
    event = "User AstroMedia",
  },
  {
    "nvim-telescope/telescope-project.nvim",
    requires = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").load_extension "project"
    end,
    event = "User AstroProject",
  },
  {
    "nvim-telescope/telescope-frecency.nvim",
    requires = { "nvim-telescope/telescope.nvim", "tami5/sql.nvim" },
    config = function()
      require("telescope").load_extension "frecency"
    end,
    event = "User AstroFrecency",
  },
  {
    "nvim-telescope/telescope-packer.nvim",
    requires = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").load_extension "packer"
    end,
    event = "User AstroPacker",
  },
  {
    "nvim-telescope/telescope-github.nvim",
    requires = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").load_extension "gh"
    end,
    event = "User AstroGithub",
  },
  {
    "nvim-telescope/telescope-arecibo.nvim",
    requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").load_extension "arecibo"
    end,
    event = "User AstroArecibo",
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    config = function() require("telescope").load_extension "file_browser" end,
    event = "User AstroFile",
  },
}
