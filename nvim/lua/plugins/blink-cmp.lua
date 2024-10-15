return {
  "saghen/blink.cmp",
  dependencies = { "rafamadriz/friendly-snippets" },
  -- event = { "LspAttach", "InsertCharPre" },
  lazy = false,
  version = "v0.*",
  opts = {
    highlight = {
      use_nvim_cmp_as_default = true,
    },
    nerd_font_variant = "mono",
    accept = { auto_brackets = { enabled = true } },

    -- trigger = { signature_help = { enabled = true } },

    keymap = {
      -- show = "<C-space>",
      -- hide = { "<C-d>" },
      accept = "<CR>",
      select_prev = { "<Up>", "<C-k>" },
      select_next = { "<Down>", "<C-j>" },

      show_documentation = { "<C-x>" },
      hide_documentation = {},
      scroll_documentation_up = "<C-y>",
      scroll_documentation_down = "<C-e>",
    },

    windows = {
      autocomplete = {
        border = "single",
      },
      documentation = {
        border = "single",
      },
    },
  },
}
