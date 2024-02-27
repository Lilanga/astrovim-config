local colors = {
    red = '#ca1243',
    blue = '#0078d7',
    yellow = '#bf9602',
    white = '#fafafa',
    black = '#181818',
    light_green = '#38c26b',
    orange = '#fe8019',
    magenta = '#990099',
    grey = '#666699',
  }
  
  local icons = {
    git = {
      added    = " ",
      modified = " ",
      removed  = " ",
    },
    diagnostics = {
      Error = " ",
      Warn  = " ",
      Hint  = " ",
      Info  = " ",
    },
  }
  local theme = {
    normal = {
      a = { fg = colors.white, bg = colors.yellow },
      b = { fg = colors.white, bg = colors.black },
      c = { fg = colors.white, bg = colors.blue },
      z = { fg = colors.white, bg = colors.grey },
    },
    insert = { a = { fg = colors.black, bg = colors.light_green } },
    visual = { a = { fg = colors.black, bg = colors.orange } },
    replace = { a = { fg = colors.black, bg = colors.magenta } },
  }
  
  local empty = require('lualine.component'):extend()
  function empty:draw(default_highlight)
    self.status = ''
    self.applied_separator = ''
    self:apply_highlights(default_highlight)
    self:apply_section_separators()
    return self.status
  end
  
  -- Put proper separators and gaps between components in sections
  local function process_sections(sections)
    for name, section in pairs(sections) do
      local left = name:sub(9, 10) < 'x'
      for pos = 1, name ~= 'lualine_z' and #section or #section - 1 do
        table.insert(section, pos * 2, { empty, color = { fg = colors.white, bg = colors.white } })
      end
      for id, comp in ipairs(section) do
        if type(comp) ~= 'table' then
          comp = { comp }
          section[id] = comp
        end
        comp.separator = left and { right = '' } or { left = '' }
      end
    end
    return sections
  end
  
  local function search_result()
    if vim.v.hlsearch == 0 then
      return ''
    end
    local last_search = vim.fn.getreg('/')
    if not last_search or last_search == '' then
      return ''
    end
    local searchcount = vim.fn.searchcount { maxcount = 9999 }
    return last_search .. '(' .. searchcount.current .. '/' .. searchcount.total .. ')'
  end
  
  local utils = require "user.util.utils"
  local function lsp_clients()
    local bufnr = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.buf_get_clients(bufnr)
    local clients_list = {}
    for _, client in pairs(clients) do
      table.insert(clients_list, client.name)
    end
    return utils.dump(clients_list, ' ')
  end

  local function modified()
    if vim.bo.modified then
      return '+'
    elseif vim.bo.modifiable == false or vim.bo.readonly == true then
      return '-'
    end
    return ''
  end
  
  local config = {
    options = {
      theme = theme,
      component_separators = '',
      section_separators = { left = '', right = '' },
    },
    sections = process_sections {
      lualine_a = { 'mode' },
      lualine_b = {
        'branch',
        {
          'diff',
          symbols = {
            added = icons.git.added,
            modified = icons.git.modified,
            removed = icons.git.removed,
          },
          source = function()
            local gitsigns = vim.b.gitsigns_status_dict
            if gitsigns then
              return {
                added = gitsigns.added,
                modified = gitsigns.changed,
                removed = gitsigns.removed,
              }
            end
          end,
        },
        {
          'diagnostics',
          source = { 'nvim' },
          sections = { 'error' },
          diagnostics_color = { error = { bg = colors.red, fg = colors.white } },
        },
        {
          'diagnostics',
          symbols = {
            error = icons.diagnostics.Error,
            warn = icons.diagnostics.Warn,
            info = icons.diagnostics.Info,
            hint = icons.diagnostics.Hint,
          },
          source = { 'nvim' },
          sections = { 'warn' },
          diagnostics_color = { warn = { bg = colors.orange, fg = colors.white } },
        },
        { 'filename', file_status = false, path = 1 },
        { modified, color = { bg = colors.red } },
        {
          '%w',
          cond = function()
            return vim.wo.previewwindow
          end,
        },
        {
          '%r',
          cond = function()
            return vim.bo.readonly
          end,
        },
        {
          '%q',
          cond = function()
            return vim.bo.buftype == 'quickfix'
          end,
        },
      },
      lualine_c = {},
      lualine_x = {
        { lsp_clients, color = { bg = colors.light_green, fg = colors.black} },
        'encoding'},
      lualine_y = { search_result, 'filetype' },
      lualine_z = { '%l:%c', '%p%%/%L' },
    },
    inactive_sections = {
      lualine_c = { '%f %y %m' },
      lualine_x = {},
    },
  }

return config;