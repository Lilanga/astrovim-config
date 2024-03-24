return function(_, opts)
    -- require("lspkind").init({
    opts.with_text = true
    opts.symbol_map = {
        Copilot = "",
        Text = "",
        Method = "",
        Function = "",
        Constructor = "",
        Field = "ﰠ",
        Variable = "",
        Class = "ﴯ",
        Interface = "",
        Module = "",
        Property = "ﰠ",
        Unit = "塞",
        Value = "",
        Enum = "",
        Keyword = "",
        Snippet = "",
        Color = "",
        File = "",
        Reference = "",
        Folder = "",
        EnumMember = "",
        Constant = "",
        Struct = "פּ",
        Event = "",
        Operator = "",
        TypeParameter = "",
    }
    -- })
    opts.preset = "codicons"

    vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
end
