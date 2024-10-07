-- colorscheme == catppuccin
return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function()
        require("catppuccin").load()
      end,
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      no_italic = false,
      term_colors = true,
      transparent_background = true,
      styles = {
        comments = {},
        conditionals = {},
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
      },
      color_overrides = {
        mocha = {
          base = "#000000",
          mantle = "#000000",
          crust = "#000000",
        },
      },
      integrations = {
        telescope = {
          enabled = true,
          style = "lazyvim",
        },
        dropbar = {
          enabled = true,
          color_mode = true,
        },
      },
    },
  },
}

-- colorscheme == bamboo
-- return {
--   "ribru17/bamboo.nvim",
--   lazy = false,
--   priority = 1000,
--   config = function()
--     require("bamboo").setup({
--       style = "vulgaris",
--       transparent = true,
--       ending_tildes = true,
--     })
--     require("bamboo").load()
--   end,
-- }

-- colorscheme == nightfox
-- return {
--   "EdenEast/nightfox.nvim",
--   config = function()
--     -- Default options
--     require("nightfox").setup({
--       options = {
--         -- Compiled file's destination location
--         compile_path = vim.fn.stdpath("cache") .. "/nightfox",
--         compile_file_suffix = "_compiled", -- Compiled file suffix
--         transparent = false, -- Disable setting background
--         terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
--         dim_inactive = false, -- Non focused panes set to alternative background
--         module_default = true, -- Default enable value for modules
--         colorblind = {
--           enable = false, -- Enable colorblind support
--           simulate_only = false, -- Only show simulated colorblind colors and not diff shifted
--           severity = {
--             protan = 0, -- Severity [0,1] for protan (red)
--             deutan = 0, -- Severity [0,1] for deutan (green)
--             tritan = 0, -- Severity [0,1] for tritan (blue)
--           },
--         },
--         styles = { -- Style to be applied to different syntax groups
--           comments = "NONE", -- Value is any valid attr-list value `:help attr-list`
--           conditionals = "NONE",
--           constants = "NONE",
--           functions = "NONE",
--           keywords = "NONE",
--           numbers = "NONE",
--           operators = "NONE",
--           strings = "NONE",
--           types = "NONE",
--           variables = "NONE",
--         },
--         inverse = { -- Inverse highlight for different types
--           match_paren = false,
--           visual = false,
--           search = false,
--         },
--         modules = { -- List of various plugins and additional options
--           -- ...
--         },
--       },
--       palettes = {},
--       specs = {},
--       groups = {},
--     })
--   end,
--   -- setup must be called before loading
--   vim.cmd("colorscheme nightfox"),
-- } -- lazy
