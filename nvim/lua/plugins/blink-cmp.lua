return {
  -- -- add blink.compat
  -- {
  --   "saghen/blink.compat",
  --   lazy = true,
  --   -- make sure to set opts so that lazy.nvim calls blink.compat's setup
  --   opts = {},
  -- },
  -- Filename: ~/github/dotfiles-latest/neovim/neobean/lua/pl
  -- ~/github/dotfiles-latest/neovim/neobean/lua/plugins/blink-cmp.lua

  -- HACK: blink.cmp updates | Remove LuaSnip | Emoji and Dictionary Sources | Fix Jump Autosave Issue
  -- https://youtu.be/JrgfpWap_Pg

  -- completion plugin with support for LSPs and external sources that updates
  -- on every keystroke with minimal overhead

  -- https://www.lazyvim.org/extras/coding/blink
  -- https://github.com/saghen/blink.cmp
  -- Documentation site: https://cmp.saghen.dev/

  {
    "saghen/blink.cmp",
    enabled = true,
    -- In case there are breaking changes and you want to go back to the last
    -- working release
    -- https://github.com/Saghen/blink.cmp/releases
    -- version = "v0.9.3",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "Kaiser-Yang/blink-cmp-dictionary",
      -- {
      --   "Kaiser-Yang/blink-cmp-git",
      --   dependencies = { "nvim-lua/plenary.nvim" },
      -- },
      "Kaiser-Yang/blink-cmp-avante",
    },
    opts = function(_, opts)
      -- I noticed that telescope was extremeley slow and taking too long to open,
      -- assumed related to blink, so disabled blink and in fact it was related
      -- :lua print(vim.bo[0].filetype)
      -- So I'm disabling blink.cmp for Telescope
      -- opts.enabled = function()
      --   -- Get the current buffer's filetype
      --   local filetype = vim.bo[0].filetype
      --   -- Disable for Telescope buffers
      --   if filetype == "TelescopePrompt" or filetype == "minifiles" or filetype == "snacks_picker_input" then
      --     return false
      --   end
      --   return true
      -- end

      -- NOTE: The new way to enable LuaSnip
      -- Merge custom sources with the existing ones from lazyvim
      -- NOTE: by default lazyvim already includes the lazydev source, so not adding it here again
      opts.sources = vim.tbl_deep_extend("force", opts.sources or {}, {
        default = {
          "lsp",
          "path",
          "snippets",
          "buffer",
          "markdown",
          "dictionary",
          "avante",
        },
        providers = {
          markdown = {
            name = "RenderMarkdown",
            module = "render-markdown.integ.blink",
            fallbacks = { "lsp" },
          },
          avante = {
            module = "blink-cmp-avante",
            name = "Avante",
          },
          lsp = {
            name = "lsp",
            enabled = true,
            module = "blink.cmp.sources.lsp",
            kind = "LSP",
            min_keyword_length = 2,
            -- When linking markdown notes, I would get snippets and text in the
            -- suggestions, I want those to show only if there are no LSP
            -- suggestions
            --
            -- Enabled fallbacks as this seems to be working now
            -- Disabling fallbacks as my snippets wouldn't show up when editing
            -- lua files
            -- fallbacks = { "snippets", "buffer" },
            -- fallbacks = { "snippets", "luasnip", "buffer" },
            score_offset = 90, -- the higher the number, the higher the priority
          },
          luasnip = {
            name = "luasnip",
            enabled = true,
            module = "blink.cmp.sources.luasnip",
            min_keyword_length = 2,
            fallbacks = { "snippets" },
            score_offset = 85, -- the higher the number, the higher the priority
            max_items = 6,
          },
          path = {
            name = "Path",
            module = "blink.cmp.sources.path",
            score_offset = 25,
            -- When typing a path, I would get snippets and text in the
            -- suggestions, I want those to show only if there are no path
            -- suggestions
            fallbacks = { "luasnip", "buffer" },
            -- min_keyword_length = 2,
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
            max_items = 3,
            module = "blink.cmp.sources.buffer",
            min_keyword_length = 4,
            score_offset = 15, -- the higher the number, the higher the priority
          },
          snippets = {
            name = "snippets",
            enabled = true,
            max_items = 15,
            module = "blink.cmp.sources.snippets",
            min_keyword_length = 2,
            score_offset = 85, -- the higher the number, the higher the priority
          },
          -- https://github.com/Kaiser-Yang/blink-cmp-dictionary
          -- In macOS to get started with a dictionary:
          -- cp /usr/share/dict/words ~/github/dotfiles-latest/dictionaries/words.txt
          --
          -- NOTE: For the word definitions make sure "wn" is installed
          -- brew install wordnet
          dictionary = {
            module = "blink-cmp-dictionary",
            name = "Dict",
            score_offset = 20, -- the higher the number, the higher the priority
            -- https://github.com/Kaiser-Yang/blink-cmp-dictionary/issues/2
            enabled = true,
            max_items = 8,
            min_keyword_length = 3,
            opts = {
              -- The dictionary by default now uses fzf, make sure to have it
              -- installed
              -- https://github.com/Kaiser-Yang/blink-cmp-dictionary/issues/2
              --
              -- Do not specify a file, just the path, and in the path you need to
              -- have your .txt files
              -- dictionary_directories = { vim.fn.expand("~/.dotfiles/nvim/spell") },
              -- Notice I'm also adding the words I add to the spell dictionary
              dictionary_files = {
                vim.fn.expand("~/.dotfiles/nvim/spell/en.utf-8.add.spl"),
                vim.fn.expand("~/.dotfiles/nvim/spell/en_dict.txt"),
              },
              --  NOTE: To disable the definitions uncomment this section below
              --
              -- separate_output = function(output)
              --   local items = {}
              --   for line in output:gmatch("[^\r\n]+") do
              --     table.insert(items, {
              --       label = line,
              --       insert_text = line,
              --       documentation = nil,
              --     })
              --   end
              --   return items
              -- end,
            },
          },
        },
      })
      opts.cmdline = {
        enabled = true,
      }

      opts.completion = {
        --   keyword = {
        --     -- 'prefix' will fuzzy match on the text before the cursor
        --     -- 'full' will fuzzy match on the text before *and* after the cursor
        --     -- example: 'foo_|_bar' will match 'foo_' for 'prefix' and 'foo__bar' for 'full'
        --     range = "full",
        --   },
        menu = {
          border = "rounded",
          max_height = 15,
          scrolloff = 0,
          draw = {
            align_to = "cursor",
            padding = 0,
            columns = {
              { "kind_icon" },
              { "label", "label_description", gap = 1 },
              { "source_name" },
            },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 0,
          update_delay_ms = 100,
          treesitter_highlighting = true,
          window = {
            border = "rounded",
          },
        },
        -- Displays a preview of the selected item on the current line
        ghost_text = {
          enabled = true,
        },
      }

      -- opts.fuzzy = {
      --   -- Disabling this matches the behavior of fzf
      --   use_typo_resistance = false,
      --   -- Frecency tracks the most recently/frequently used items and boosts the score of the item
      --   use_frecency = true,
      --   -- Proximity bonus boosts the score of items matching nearby words
      --   use_proximity = false,
      -- }

      opts.snippets = {
        preset = "luasnip",
        -- This comes from the luasnip extra, if you don't add it, won't be able to
        -- jump forward or backward in luasnip snippets
        -- https://www.lazyvim.org/extras/coding/luasnip#blinkcmp-optional
        -- expand = function(snippet)
        --   require("luasnip").lsp_expand(snippet)
        -- end,
        -- active = function(filter)
        --   if filter and filter.direction then
        --     return require("luasnip").jumpable(filter.direction)
        --   end
        --   return require("luasnip").in_snippet()
        -- end,
        -- jump = function(direction)
        --   require("luasnip").jump(direction)
        -- end,
      }

      -- The default preset used by lazyvim accepts completions with enter
      -- I don't like using enter because if on markdown and typing
      -- something, but you want to go to the line below, if you press enter,
      -- the completion will be accepted
      -- https://cmp.saghen.dev/configuration/keymap.html#default
      opts.keymap = {
        preset = "none",
        ["<C-x>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-c>"] = { "cancel", "fallback" },
        ["<C-y>"] = { "select_and_accept" },

        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },

        ["<C-u>"] = { "scroll_documentation_up", "fallback" },
        ["<C-d>"] = { "scroll_documentation_down", "fallback" },

        ["<Tab>"] = { "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },
      }

      return opts
    end,

    -- Experimental signature help support
    signature = {
      enabled = true,
      window = {
        border = "rounded",
      },
    },
  },
}
