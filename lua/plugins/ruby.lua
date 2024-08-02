core = require "astrocore"
local util = require "lspconfig.util"

return {
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = core.list_insert_unique(opts.ensure_installed, { "ruby" })
      end
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = core.list_insert_unique(opts.ensure_installed, { "ruby_lsp", "solargraph" })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = core.list_insert_unique(opts.ensure_installed, { "ruby_lsp", "solargraph" })
    end,
  },
  {
    "AstroNvim/astrolsp",
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      table.insert(opts.servers, "ruby_lsp")

      opts.config = core.extend_tbl(opts.config or {}, {
        ruby_lsp = {
          -- cmd = { "bundle", "exec", "ruby-lsp" },
          cmd = { "/Users/geoff/.rbenv/shims/ruby-lsp" },
          mason = false,
          filetypes = { "ruby" },
          root_dir = util.root_pattern("Gemfile", ".git"),
          init_options = {
            enabledFeatures = {
              "documentHighlights",
              "documentSymbols",
              "foldingRanges",
              "selectionRanges",
              -- "semanticHighlighting",
              "formatting",
              "codeActions",
            },
          },
          settings = {},
        },
        -- solargraph = {
        --   cmd = { "/Users/geoff/.rbenv/shims/solargraph" },
        --   mason = false,
        -- },
        commands = {
          FormatRuby = {
            function()
              vim.lsp.buf.format {
                name = "ruby_lsp",
                async = true,
              }
            end,
            description = "Format using ruby-lsp",
          },
        },
      })
    end,
  },
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = { "suketa/nvim-dap-ruby", config = true },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    -- opts = {
    --   formatters_by_ft = {
    --     ruby = { "standardrb" },
    --   },
    -- },
  },
}
