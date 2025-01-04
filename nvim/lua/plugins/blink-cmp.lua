-- Filename: ~/github/dotfiles-latest/neovim/neobean/lua/plugins/blink-cmp.lua
-- ~/github/dotfiles-latest/neovim/neobean/lua/plugins/blink-cmp.lua

-- completion plugin with support for LSPs and external sources that updates
-- on every keystroke with minimal overhead

-- https://www.lazyvim.org/extras/coding/blink
-- https://github.com/saghen/blink.cmp
-- Documentation site: https://cmp.saghen.dev/

return {
  -- add blink.compat
  {
    "saghen/blink.compat",
    lazy = true,
    -- make sure to set opts so that lazy.nvim calls blink.compat's setup
    opts = {},
  },

  "saghen/blink.cmp",
  enabled = true,
  opts = function(_, opts)
    -- Merge custom sources with the existing ones from lazyvim
    -- NOTE: by default lazyvim already includes the lazydev source, so not
    -- adding it here again
    opts.sources = vim.tbl_deep_extend(
      "force",
      opts.sources or {},
      {
        default = { "lsp", "path", "snippets", "buffer", "luasnip" },
        providers = {
          lsp = {
            name = "lsp",
            enabled = true,
            module = "blink.cmp.sources.lsp",
            kind = "LSP",
            -- When linking markdown notes, I would get snippets and text in the
            -- suggestions, I want those to show only if there are no LSP
            -- suggestions
            fallbacks = { "snippets", "luasnip", "buffer" },
            score_offset = 90, -- the higher the number, the higher the priority
          },
          luasnip = {
            name = "luasnip",
            enabled = true,
            module = "blink.cmp.sources.luasnip",
            min_keyword_length = 2,
            fallbacks = { "snippets" },
            score_offset = 85, -- the higher the number, the higher the priority
            max_items = 8,
          },
          path = {
            name = "Path",
            enabled = true,
            module = "blink.cmp.sources.path",
            score_offset = 3,
            -- When typing a path, I would get snippets and text in the
            -- suggestions, I want those to show only if there are no path
            -- suggestions
            fallbacks = { "snippets", "luasnip", "buffer" },
            opts = {
              trailing_slash = false,
              label_trailing_slash = true,
              get_cwd = function(context)
                return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
              end,
              show_hidden_files_by_default = true,
            },
          },
          buffer = {
            name = "Buffer",
            enabled = true,
            module = "blink.cmp.sources.buffer",
            min_keyword_length = 4,
          },
          snippets = {
            name = "snippets",
            enabled = true,
            max_items = 3,
            module = "blink.cmp.sources.snippets",
            min_keyword_length = 4,
            score_offset = 80, -- the higher the number, the higher the priority
          },
          cmdline = function()
            local type = vim.fn.getcmdtype()
            -- Search forward and backward
            if type == "/" or type == "?" then
              return { "buffer" }
            end
            -- Commands
            if type == ";" then
              return { "cmdline" }
            end
            return {}
          end,
        },
      },
      signature == { enabled = true },

      -- This comes from the luasnip extra, if you don't add it, won't be able to
      -- jump forward or backward in luasnip snippets
      -- https://www.lazyvim.org/extras/coding/luasnip#blinkcmp-optional
      snippets
        == {
          expand = function(snippet)
            require("luasnip").lsp_expand(snippet)
          end,
          active = function(filter)
            if filter and filter.direction then
              return require("luasnip").jumpable(filter.direction)
            end
            return require("luasnip").in_snippet()
          end,
          jump = function(direction)
            require("luasnip").jump(direction)
          end,
        },
      opts.keymap
        == {
          preset = "default",
          ["<Tab>"] = { "snippet_forward", "fallback" },
          ["<S-Tab>"] = { "snippet_backward", "fallback" },

          ["<Up>"] = { "select_prev", "fallback" },
          ["<Down>"] = { "select_next", "fallback" },
          ["<C-p>"] = { "select_prev", "fallback" },
          ["<C-n>"] = { "select_next", "fallback" },

          ["<C-b>"] = { "scroll_documentation_up", "fallback" },
          ["<C-f>"] = { "scroll_documentation_down", "fallback" },

          ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
          ["<C-e>"] = { "hide", "fallback" },
          ["<CR>"] = {},
        }
    )

    return opts
  end,
}
