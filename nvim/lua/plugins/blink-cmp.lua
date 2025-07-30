return {
  -- add blink.compat
  {
    "saghen/blink.compat",
    lazy = true,
    -- make sure to set opts so that lazy.nvim calls blink.compat's setup
    opts = {},
  },

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
      "mikavilpas/blink-ripgrep.nvim",
      "Kaiser-Yang/blink-cmp-dictionary",
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
          "ripgrep",
          "dictionary",
          "markdown",
        },
        providers = {
          markdown = {
            name = "RenderMarkdown",
            module = "render-markdown.integ.blink",
            fallbacks = { "lsp" },
            score_offset = 80, -- the higher the number, the higher the priority
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
            fallbacks = { "snippets", "luasnip", "buffer" },
            score_offset = 95, -- the higher the number, the higher the priority
          },
          luasnip = {
            name = "luasnip",
            enabled = true,
            module = "blink.cmp.sources.luasnip",
            min_keyword_length = 2,
            fallbacks = { "snippets" },
            score_offset = 90, -- the higher the number, the higher the priority
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
          ripgrep = {
            module = "blink-ripgrep",
            name = "Ripgrep",
            -- the options below are optional, some default values are shown
            ---@module "blink-ripgrep"
            ---@type blink-ripgrep.Options
            opts = {
              -- the minimum length of the current word to start searching
              -- (if the word is shorter than this, the search will not start)
              prefix_min_len = 3,

              -- Specifies how to find the root of the project where the ripgrep
              -- search will start from. Accepts the same options as the marker
              -- given to `:h vim.fs.root()` which offers many possibilities for
              -- configuration. If none can be found, defaults to Neovim's cwd.
              --
              -- Examples:
              -- - ".git" (default)
              -- - { ".git", "package.json", ".root" }
              project_root_marker = ".git",

              -- When a result is found for a file whose filetype does not have a
              -- treesitter parser installed, fall back to regex based highlighting
              -- that is bundled in Neovim.
              fallback_to_regex_highlighting = true,

              -- Keymaps to toggle features on/off. This can be used to alter
              -- the behavior of the plugin without restarting Neovim. Nothing
              -- is enabled by default. Requires folke/snacks.nvim.
              toggles = {
                -- The keymap to toggle the plugin on and off from blink
                -- completion results. Example: "<leader>tg" ("toggle grep")
                on_off = nil,

                -- The keymap to toggle debug mode on/off. Example: "<leader>td" ("toggle debug")
                debug = nil,
              },

              backend = {
                -- The backend to use for searching. Defaults to "ripgrep".
                use = "ripgrep",

                -- Whether to set up custom highlight-groups for the icons used
                -- in the completion items. Defaults to `true`, which means this
                -- is enabled.
                customize_icon_highlight = true,

                ripgrep = {
                  -- For many options, see `rg --help` for an exact description of
                  -- the values that ripgrep expects.

                  -- The number of lines to show around each match in the preview
                  -- (documentation) window. For example, 5 means to show 5 lines
                  -- before, then the match, and another 5 lines after the match.
                  context_size = 5,

                  -- The maximum file size of a file that ripgrep should include
                  -- in its search. Useful when your project contains large files
                  -- that might cause performance issues.
                  -- Examples:
                  -- "1024" (bytes by default), "200K", "1M", "1G", which will
                  -- exclude files larger than that size.
                  max_filesize = "1M",

                  -- Enable fallback to neovim cwd if project_root_marker is not
                  -- found. Default: `true`, which means to use the cwd.
                  project_root_fallback = true,

                  -- The casing to use for the search in a format that ripgrep
                  -- accepts. Defaults to "--ignore-case". See `rg --help` for
                  -- all the available options ripgrep supports, but you can try
                  -- "--case-sensitive" or "--smart-case".
                  search_casing = "--ignore-case",

                  -- (advanced) Any additional options you want to give to
                  -- ripgrep. See `rg -h` for a list of all available options.
                  -- Might be helpful in adjusting performance in specific
                  -- situations. If you have an idea for a default, please open
                  -- an issue!
                  --
                  -- Not everything will work (obviously).
                  additional_rg_options = {},

                  -- Absolute root paths where the rg command will not be
                  -- executed. Usually you want to exclude paths using gitignore
                  -- files or ripgrep specific ignore files, but this can be used
                  -- to only ignore the paths in blink-ripgrep.nvim, maintaining
                  -- the ability to use ripgrep for those paths on the command
                  -- line. If you need to find out where the searches are
                  -- executed, enable `debug` and look at `:messages`.
                  ignore_paths = {},

                  -- Any additional paths to search in, in addition to the
                  -- project root. This can be useful if you want to include
                  -- dictionary files (/usr/share/dict/words), framework
                  -- documentation, or any other reference material that is not
                  -- available within the project root.
                  additional_paths = {},
                },
              },

              -- Show debug information in `:messages` that can help in
              -- diagnosing issues with the plugin.
              debug = false,
            },
            -- (optional) customize how the results are displayed. Many options
            -- are available - make sure your lua LSP is set up so you get
            -- autocompletion help
            transform_items = function(_, items)
              for _, item in ipairs(items) do
                -- example: append a description to easily distinguish rg results
                item.labelDetails = {
                  description = "(rg)",
                }
              end
              return items
            end,
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
            score_offset = 40, -- the higher the number, the higher the priority
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
            gap = 2,
            -- align_to = "cursor",
            -- padding = 0,
            columns = {
              -- { "kind_icon" },
              -- { "label", "label_description", gap = 1 },
              -- { "source_name" },
              { "source_name", gap = 1 },
              { "label", "label_description", gap = 1 },
              { "kind_icon", "kind", gap = 2 },
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
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
          },
        },
        -- Displays a preview of the selected item on the current line
        -- ghost_text = {
        --   enabled = true,
        -- },
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
        ["<C-\\>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-c>"] = { "cancel", "fallback" },
        ["<CR>"] = { "accept", "fallback" },

        ["<C-p>"] = { "select_prev", "fallback" },
        ["<C-n>"] = { "select_next", "show" },

        ["<C-u>"] = { "scroll_documentation_up", "fallback" },
        ["<C-d>"] = { "scroll_documentation_down", "fallback" },

        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
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
