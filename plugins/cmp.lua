return {
    "hrsh7th/nvim-cmp",
    opts = {
      performance = {
        debounce = 300,
        throttle = 120,
        fetching_timeout = 100
      },
      experimental = {
        ghost_text = true,
      },
      sources = {
        { name = "nvim_lsp", priority = 1000, group_index = 2 },
        { name = "codeium",  priority = 750, group_index = 2 },
        { name = "copilot",  priority = 750, group_index = 2 },
        { name = "luasnip",  priority = 700, group_index = 2 },
        { name = "path",     priority = 650, group_index = 2 },
        { name = "buffer",   priority = 400, group_index = 2 },
      }
    }
  }