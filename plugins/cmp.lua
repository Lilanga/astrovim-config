local has_words_before = function()
        if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
    end
    local cmp = require("cmp")
    cmp.setup({
            mapping = {
            ["<Tab>"] = vim.schedule_wrap(function(fallback)
                if cmp.visible() and has_words_before() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            else
                fallback()
            end
            end),
            },
        })

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
        { name = "nvim_lsp", priority = 1000 },
        { name = "codeium",  priority = 750 },
        { name = "copilot",  priority = 750 },
        { name = "luasnip",  priority = 700 },
        { name = "path",     priority = 650 },
        { name = "buffer",   priority = 400 },
      }
    }
  }