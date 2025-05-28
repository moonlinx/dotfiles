-- return {
--   "nvim-treesitter/nvim-treesitter",
--   event = { "BufReadPre", "BufNewFile" },
--   build = ":TSUpdate",
--   dependencies = {
--     "windwp/nvim-ts-autotag",
--   },
--   config = function()
--     -- import nvim-treesitter plugin
--     local treesitter = require("nvim-treesitter.configs")
--
--     -- configure treesitter
--     treesitter.setup({ -- enable syntax highlighting
--       highlight = {
--         enable = true,
--       },
--       -- enable indentation
--       indent = { enable = true },
--       -- enable autotagging (w/ nvim-ts-autotag plugin)
--       autotag = {
--         enable = true,
--       },
--       -- ensure these language parsers are installed
--       ensure_installed = {
--         "json",
--         "typescript",
--         "tsx",
--         "yaml",
--         "html",
--         "css",
--         "python",
--         "markdown",
--         "markdown_inline",
--         "latex",
--         "graphql",
--         "bash",
--         "lua",
--         "vim",
--         "dockerfile",
--         "gitignore",
--         "query",
--         "c",
--       },
--       incremental_selection = {
--         enable = true,
--         keymaps = {
--           init_selection = "<C-space>",
--           node_incremental = "<C-space>",
--           scope_incremental = false,
--           node_decremental = "<bs>",
--         },
--       },
--     })
--   end,
-- }
-- https://github.com/nvim-treesitter/nvim-treesitter

-- Filename: ~/github/dotfiles-latest/neovim/neobean/lua/plugins/treesitter.lua
-- ~/github/dotfiles-latest/neovim/neobean/lua/plugins/treesitter.lua

-- SQL wasn't showing in my codeblocks when working with .md files, that's
-- how I found out it was missing from treesitter

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "lua",
        "sql",
        "go",
        "regex",
        "bash",
        "markdown",
        "markdown_inline",
        "latex",
        "python",
        "yaml",
        "json",
        "jsonc",
        "cpp",
        "csv",
        "java",
        "javascript",
        "python",
        "dockerfile",
        "html",
        "css",
        "templ",
        "php",
        "promql",
        "glsl",
        "dockerfile",
      },
    },
  },
}
