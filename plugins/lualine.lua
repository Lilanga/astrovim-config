-- configure lualine
return {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.winbar = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = {
          {
            "filename",
            path = 1,

            file_status = true, -- Displays file status (readonly status, modified status)
            newfile_status = false, -- Display new file status (new file means no write after created)

            shorting_target = 40, -- Shortens path to leave 40 spaces in the window
            -- for other components. (terrible name, any suggestions?)
            symbols = {
              modified = "", -- Text to show when the file is modified.
              readonly = "", -- Text to show when the file is non-modifiable or readonly.
              unnamed = "", -- Text to show for unnamed buffers.
              newfile = "", -- Text to show for newly created file before first write
              directory = "",
              oil = "",
            },

            filetype_names = {
              TelescopePrompt = "Telescope ",
              dashboard = "Dashboard",
              packer = "Packer",
              fzf = "FZF",
              alpha = "Dashboard",
              oil = "",
            },
          },
        },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = {
          { "progress" },
          {
            "searchcount",
            maxcount = 999,
            timeout = 500,
          },
        },
        lualine_z = { "location" },
      }

      opts.inactive_winbar = {
        lualine_a = opts.winbar.lualine_a,
        lualine_b = opts.winbar.lualine_b,
        lualine_c = opts.winbar.lualine_c,
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      }

      opts.sections = {}
      opts.inactive_sections = {}

      return opts
    end,
    config = require "user.plugins.configs.lualine",
  }