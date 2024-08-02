---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.colorscheme.kanagawa-nvim" },

  -- language packs
  { import = "astrocommunity.pack.go" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.python" },
  -- standardrb is annoying
  -- { import = "astrocommunity.pack.ruby" },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.tailwindcss" },
  { import = "astrocommunity.pack.templ" },
  -- vtsls is annoying
  -- { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.yaml" },

  -- testing (add later when I have time to test, just here as a reminder for now)
  -- { import = "astrocommunity.test.nvim-coverage" },
  { import = "astrocommunity.test.neotest" },

  -- debugging
  { import = "astrocommunity.debugging.telescope-dap-nvim" },

  -- these can be imported/overriden with the plugins folder
}
