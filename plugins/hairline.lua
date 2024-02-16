return {
  "rebelot/heirline.nvim",
  event = "BufEnter",
  opts = function()
    local status = require "astronvim.utils.status"
    return {
      opts = {
        disable_winbar_cb = function(args)
          return not require("astronvim.utils.buffer").is_valid(args.buf)
            or status.condition.buffer_matches({
              buftype = { "terminal", "prompt", "nofile", "help", "quickfix" },
              filetype = { "NvimTree", "neo%-tree", "dashboard", "Outline", "aerial" },
            }, args.buf)
        end,
      },
      statusline = { -- statusline
        hl = { fg = "fg", bg = "bg" },
        status.component.mode(),
        status.component.git_branch(),
        status.component.file_info { filetype = {}, filename = false, file_modified = false },
        status.component.git_diff(),
        status.component.diagnostics(),
        status.component.fill(),
        status.component.cmd_info(),
        status.component.fill(),
        status.component.lsp(),
        status.component.treesitter(),
        status.component.nav(),
        status.component.mode { surround = { separator = "right" } },
      },
      winbar = { -- winbar
        init = function(self) self.bufnr = vim.api.nvim_get_current_buf() end,
        fallthrough = false,
        {
          condition = function() return not status.condition.is_active() end,
          status.component.separated_path(),
          status.component.file_info {
            file_icon = { hl = status.hl.file_icon "winbar", padding = { left = 0 } },
            file_modified = false,
            file_read_only = false,
            hl = status.hl.get_attributes("winbarnc", true),
            surround = false,
            update = "BufEnter",
          },
        },
        status.component.breadcrumbs { hl = status.hl.get_attributes("winbar", true) },
      },
      tabline = { -- bufferline
        { -- file tree padding
          condition = function(self)
            self.winid = vim.api.nvim_tabpage_list_wins(0)[1]
            return status.condition.buffer_matches({
              filetype = {
                "NvimTree",
                "OverseerList",
                "aerial",
                "dap%-repl",
                "dapui_.",
                "edgy",
                "neo%-tree",
                "undotree",
              },
            }, vim.api.nvim_win_get_buf(self.winid))
          end,
          provider = function(self) return string.rep(" ", vim.api.nvim_win_get_width(self.winid) + 1) end,
          hl = { bg = "tabline_bg" },
        },
        status.heirline.make_buflist(status.component.tabline_file_info()), -- component for each buffer tab
        status.component.fill { hl = { bg = "tabline_bg" } }, -- fill the rest of the tabline with background color
        { -- tab list
          condition = function() return #vim.api.nvim_list_tabpages() >= 2 end, -- only show tabs if there are more than one
          status.heirline.make_tablist { -- component for each tab
            provider = status.provider.tabnr(),
            hl = function(self) return status.hl.get_attributes(status.heirline.tab_type(self, "tab"), true) end,
          },
          { -- close button for current tab
            provider = status.provider.close_button { kind = "TabClose", padding = { left = 1, right = 1 } },
            hl = status.hl.get_attributes("tab_close", true),
            on_click = {
              callback = function() require("astronvim.utils.buffer").close_tab() end,
              name = "heirline_tabline_close_tab_callback",
            },
          },
        },
      },
      statuscolumn = vim.fn.has "nvim-0.9" == 1 and {
        init = function(self) self.bufnr = vim.api.nvim_get_current_buf() end,
        status.component.foldcolumn(),
        status.component.fill(),
        status.component.numbercolumn(),
        status.component.signcolumn(),
      } or nil,
    }
  end,
  config = require "user.plugins.configs.heirline",
    -- "rebelot/heirline.nvim",
    -- opts = function(_, opts)
    --   local status = {
    --     user = require "user.util.statusline",
    --     astro = require "astronvim.utils.status",
    --   }
    --   local icons = require "astronvim.icons.nerd_font"
  
    --   local mode_text_color_1 = {
    --     "#1C2A43",
    --     "#002627",
    --     "#1C1836",
    --     "#2B0000",
    --     "#1D1905",
    --   }
  
    --   local mode_text_color_2 = {
    --     normal = "#E0FFFF",
    --     insert = "#C8F7C5",
    --     visual = "#FFECDB",
    --     replace = "#FFECDB",
    --     command = "#FFFACD",
    --   }
  
    --   -- the first element of the configuration table is the statusline
    --   opts.statusline = {
    --     -- default highlight for the entire statusline
    --     hl = { fg = "fg", bg = "bg" },
    --     -----------------------------------
    --     ---- NOTE: Left side of neovim.----
    --     -----------------------------------
  
    --     -- Vim mode compnonent, using custom
    --     status.astro.component.builder {
    --       { provider = status.user.mode },
    --       -- mode_text = { icon = "test", padding = { right = 1, left = 1 } },
    --       -- hl = function() return { fg = mode_color(mode_text_color_1) } end,
    --       hl = { fg = "bg" },
    --       surround = {
    --         separator = "left",
    --         color = function()
    --           return {
    --             main = status.user.mode_color(THEME.mode),
    --             right = status.user.mode_color(THEME.grapple),
    --           }
    --         end,
    --       },
    --       update = {
    --         "ModeChanged",
    --         callback = vim.schedule_wrap(function() vim.cmd.redrawstatus() end),
    --       },
    --     },
    --     -- Custom component for grapple
    --     status.astro.component.builder {
    --       { provider = status.user.grapple },
    --       hl = function() return { fg = status.user.set_grapple_color(mode_text_color_2) } end,
    --       surround = {
    --         separator = "left",
    --         color = function()
    --           return {
    --             main = status.user.mode_color(THEME.grapple),
    --             right = status.user.mode_color(THEME.tools),
    --           }
    --         end,
    --       },
    --     },
    --     -- Custom compnent for macro recordings
    --     status.astro.component.builder {
    --       { provider = status.user.macro_recording },
    --       hl = function() return { fg = status.user.mode_color(mode_text_color_2), bold = true } end,
    --       surround = {
    --         separator = "left",
    --         color = function() return { main = status.user.mode_color(THEME.tools), right = "bg" } end,
    --       },
    --       update = {
    --         "RecordingEnter",
    --         "RecordingLeave",
    --         callback = vim.schedule_wrap(function() vim.cmd.redrawstatus() end),
    --       },
    --     },
    --     -------------------------------------
    --     ---- NOTE: Center side of neovim.----
    --     -------------------------------------
  
    --     -- add a component for the current git branch if it exists and use no separator for the sections
    --     status.astro.component.git_branch { surround = { separator = "none" } },
    --     -- add a component for the current git diff if it exists and use no separator for the sections
    --     status.astro.component.git_diff { padding = { left = 1 }, surround = { separator = "none" } },
    --     -- fill the rest of the statusline
    --     -- the elements after this will appear in the middle of the statusline
    --     status.astro.component.fill(),
    --     -- add a component to display if the LSP is loading, disable showing running client names, and use no separator
    --     status.astro.component.lsp { lsp_client_names = false, surround = { separator = "none", color = "bg" } },
    --     -- fill the rest of the statusline
    --     -- the elements after this will appear on the right of the statusline
    --     status.astro.component.fill(),
    --     ------------------------------------
    --     ---- NOTE: Right side of neovim.----
    --     ------------------------------------
  
    --     -- add a component for the current diagnostics if it exists and use the right separator for the section
    --     status.astro.component.diagnostics { surround = { separator = "space_right" } },
    --     -- add a component to display LSP clients, disable showing LSP progress, and use the right separator
    --     status.astro.component.lsp { lsp_progress = false, surround = { separator = "space_right" } },
    --     {
    --       -- define a simple component where the provider is just a folder icon
    --       status.astro.component.builder {
    --         { provider = icons.FolderClosed },
    --         padding = { right = 1 },
    --         hl = { fg = "bg" },
    --         surround = {
    --           separator = "right",
    --           color = function() return { main = THEME.folder_icon_bg } end,
    --         },
    --       },
    --       status.astro.component.builder {
    --         { provider = "" },
    --         surround = {
    --           separator = "right_accent",
    --           color = function() return { main = THEME.folder_icon_bg, right = THEME.folder_bg } end,
    --         },
    --       },
    --       -- add a file information component and only show the current working directory name
    --       status.astro.component.file_info {
    --         filename = { fname = function() return vim.fn.getcwd() end, padding = { left = 0 } },
    --         hl = function() return { fg = THEME.folder_icon_bg } end,
    --         file_icon = false,
    --         file_modified = false,
    --         file_read_only = false,
    --         surround = {
    --           separator = "none",
    --           color = function() return THEME.folder_bg end,
    --         },
    --       },
    --     },
    --     {
    --       status.astro.component.builder {
    --         { provider = icons.DefaultFile },
    --         padding = { right = 1 },
    --         hl = { fg = "bg" },
    --         surround = {
    --           separator = "right",
    --           color = function() return { main = THEME.nav_icon_bg, left = THEME.folder_bg } end,
    --         },
    --       },
    --       status.astro.component.builder {
    --         { provider = "" },
    --         surround = {
    --           separator = "right_accent",
    --           color = function() return { main = THEME.nav_icon_bg, right = THEME.nav_bg } end,
    --         },
    --       },
    --       status.astro.component.nav {
    --         percentage = { padding = { left = 0, right = 1 } },
    --         ruler = false,
    --         scrollbar = false,
    --         hl = function() return { fg = THEME.nav_icon_bg } end,
    --         surround = {
    --           separator = "none",
    --           color = function() return THEME.nav_bg end,
    --         },
    --       },
    --     },
    --   }
  
    --   -- opts.winbar = status.astro.component.breadcrumbs {
    --   --   condition = status.astro.condition.is_active,
    --   --   hl = { fg = "winbar_fg", bg = "winbar_fg" },
    --   -- }
  
    --   opts.winbar = nil
  
    --   opts.tabline[2] = status.astro.heirline.make_buflist {
    --     {
    --       provider = function(self) return self.is_visible and " " or " " end,
    --       hl = { fg = "buffer_bg", bg = "buffer_visible_bg" },
    --     },
    --     status.astro.component.tabline_file_info { close_button = false },
    --     {
    --       provider = function(self) return self.is_visible and " " or " " end,
    --       hl = { fg = "buffer_bg", bg = "buffer_visible_bg" },
    --     },
    --   }
  
    --   opts.tabline[3] = status.astro.component.fill { hl = { bg = "buffer_visible_bg" } }
  
    --   return opts
    -- end,
  }