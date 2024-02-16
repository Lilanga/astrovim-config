return {
  {
    "nvim-telescope/telescope.nvim",
    requires = { "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup()
    end,
    cmd = "Telescope",
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    run = "make",
    after = "telescope.nvim",
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
