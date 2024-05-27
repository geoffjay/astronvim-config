---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.colorscheme.kanagawa-nvim" },

  -- language packs
  { import = "astrocommunity.pack.go" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.ruby" },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.tailwindcss" },
  { import = "astrocommunity.pack.templ" },
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.yaml" },

  -- testing (add later when I have time to test, just here as a reminder for now)
  -- { import = "astrocommunity.test.nvim-coverage" },
  -- { import = "astrocommunity.test.neotest" },

  -- these can be imported/overriden with the plugins folder
}
