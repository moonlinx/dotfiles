return {
  "oribarilan/lensline.nvim",
  event = "LspAttach",
  config = function()
    require("lensline").setup({
      providers = { -- Array format: order determines display sequence
        {
          name = "references",
          enabled = true, -- enable references provider
          quiet_lsp = true, -- suppress noisy LSP log messages (e.g., Pyright reference spam)
        },
        {
          name = "last_author",
          enabled = true, -- enabled by default with caching optimization
          cache_max_files = 50, -- maximum number of files to cache blame data for (default: 50)
        },
        -- built-in providers that are diabled by default:
        {
          name = "diagnostics",
          enabled = false, -- disabled by default - enable explicitly to use
          min_level = "WARN", -- only show WARN and ERROR by default (HINT, INFO, WARN, ERROR)
        },
        {
          name = "complexity",
          enabled = false, -- disabled by default - enable explicitly to use
          min_level = "L", -- only show L (Large) and XL (Extra Large) complexity by default
        },
      },
      style = {
        separator = " • ", -- separator between all lens attributes
        highlight = "Comment", -- highlight group for lens text
        prefix = "┃ ", -- prefix before lens content
        use_nerdfont = true, -- enable nerd font icons in built-in providers
      },
      limits = {
        exclude = {
          -- see config.lua for extensive list of default patterns
        },
        exclude_gitignored = true, -- respect .gitignore by not processing ignored files
        max_lines = 1000, -- process only first N lines of large files
        max_lenses = 70, -- skip rendering if too many lenses generated
      },
      debounce_ms = 500, -- unified debounce delay for all providers
      debug_mode = false, -- enable debug output for development, see CONTRIBUTE.md
    })
  end,
}
