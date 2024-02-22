-- customize mason plugins
return {
  {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
  {'hrsh7th/cmp-nvim-lsp'},
  {"neovim/nvim-lspconfig"},
  -- use mason-lspconfig to configure LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
    -- overrides `require("mason-lspconfig").setup(...)`
    opts = function(_, opts)
      opts.automatic_installation = true
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("astronvim.utils").list_insert_unique(opts.ensure_installed, {
        -- `community.lua` ensures language servers via their language packs
        "marksman", -- Markdown structure (also in markdown pack)
        "yamlls",
        "yamlfmt",
        "yamllint",
        "json-lsp",
        "jsonlint",
        "prettier",
        "tsserver",
        "eslint",
        "biome",
        "clojure_lsp",
        "rust_analyzer",
        "go-debug-adapter",
        "gopls",
        "gofumpt",
        "goimports",
        "golines",
        "typescript-language-server",
        "yaml-language-server",
        "editorconfig-checker",
        "gitleaks",
        "omnisharp",
        "csharpier",
        "csharp-language-server",
        "eslint_lsp",
        "haskell-language-server",
        "haskell-debug-adapter",
        "htmlbeautifier",
        "htmx-lsp",
        "java-language-server",
        "java-debug-adapter",
        "protolint",
        "synk",
        "node-debug2-adaptor",
        "netcoredbg",
        "delve",
        "docker-language-server",
        "hadolint",
      })
    end,
  },
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    "jay-babu/mason-null-ls.nvim",
    -- overrides `require("mason-null-ls").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("astronvim.utils").list_insert_unique(opts.ensure_installed, {
        -- `community.lua` ensures lint and format tools via their language packs
        -- "prettier", -- too agressive
        "alex", -- neutral language lint
        "markdownlint", -- markdown lint & format (not in markdown pack)
      })
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    -- overrides `require("mason-nvim-dap").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("astronvim.utils").list_insert_unique(opts.ensure_installed, {
        -- "python",
      })
    end,
  },
}
