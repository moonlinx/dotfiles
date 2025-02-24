local function pr_or_issue_configure_score_offset(items)
  -- Bonus to make sure items sorted as below:
  local keys = {
    -- place `kind_name` here
    { "openIssue", "openedIssue", "reopenedIssue" },
    { "openPR", "openedPR" },
    { "lockedIssue", "lockedPR" },
    { "completedIssue" },
    { "draftPR" },
    { "mergedPR" },
    { "closedPR", "closedIssue", "not_plannedIssue", "duplicateIssue" },
  }
  local bonus = 999999
  local bonus_score = {}
  for i = 1, #keys do
    for _, key in ipairs(keys[i]) do
      bonus_score[key] = bonus * (#keys - i)
    end
  end
  for i = 1, #items do
    local bonus_key = items[i].kind_name
    if bonus_score[bonus_key] then
      items[i].score_offset = bonus_score[bonus_key]
    end
    -- sort by number when having the same bonus score
    local number = items[i].label:match("[#!](%d+)")
    if number then
      if items[i].score_offset == nil then
        items[i].score_offset = 0
      end
      items[i].score_offset = items[i].score_offset + tonumber(number)
    end
  end
end

local blink_cmp_kind_name_highlight = {
  Dict = { default = false, fg = "#cba6f7" },
}
for kind_name, hl in pairs(blink_cmp_kind_name_highlight) do
  vim.api.nvim_set_hl(0, "BlinkCmpKind" .. kind_name, hl)
end

local blink_cmp_git_label_name_highlight = {
  Commit = { default = false, fg = "#a6e3a1" },
  openPR = { default = false, fg = "#a6e3a1" },
  openedPR = { default = false, fg = "#a6e3a1" },
  closedPR = { default = false, fg = "#f38ba8" },
  mergedPR = { default = false, fg = "#cba6f7" },
  draftPR = { default = false, fg = "#9399b2" },
  lockedPR = { default = false, fg = "#f5c2e7" },
  openIssue = { default = false, fg = "#a6e3a1" },
  openedIssue = { default = false, fg = "#a6e3a1" },
  reopenedIssue = { default = false, fg = "#a6e3a1" },
  completedIssue = { default = false, fg = "#cba6f7" },
  closedIssue = { default = false, fg = "#cba6f7" },
  not_plannedIssue = { default = false, fg = "#9399b2" },
  duplicateIssue = { default = false, fg = "#9399b2" },
  lockedIssue = { default = false, fg = "#f5c2e7" },
}
for kind_name, hl in pairs(blink_cmp_git_label_name_highlight) do
  vim.api.nvim_set_hl(0, "BlinkCmpGitKindIcon" .. kind_name, hl)
  vim.api.nvim_set_hl(0, "BlinkCmpGitLabel" .. kind_name .. "Id", hl)
end

return {
  -- add blink.compat
  {
    "saghen/blink.compat",
    lazy = true,
    -- make sure to set opts so that lazy.nvim calls blink.compat's setup
    opts = {},
  },
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
      {
        "Kaiser-Yang/blink-cmp-git",
        dependencies = { "nvim-lua/plenary.nvim" },
      },
    },
    opts = function(_, opts)
      -- I noticed that telescope was extremeley slow and taking too long to open,
      -- assumed related to blink, so disabled blink and in fact it was related
      -- :lua print(vim.bo[0].filetype)
      -- So I'm disabling blink.cmp for Telescope
      opts.enabled = function()
        -- Get the current buffer's filetype
        local filetype = vim.bo[0].filetype
        -- Disable for Telescope buffers
        if filetype == "TelescopePrompt" or filetype == "minifiles" or filetype == "snacks_picker_input" then
          return false
        end
        return true
      end

      -- NOTE: The new way to enable LuaSnip
      -- Merge custom sources with the existing ones from lazyvim
      -- NOTE: by default lazyvim already includes the lazydev source, so not adding it here again
      opts.sources = vim.tbl_deep_extend("force", opts.sources or {}, {
        default = { "lsp", "path", "snippets", "buffer", "git", "dictionary" },
        providers = {
          -- markdown = {
          --   name = "Render",
          --   module = "render-markdown.integ.blink",
          --   fallbacks = { "lsp" },
          -- },
          git = {
            -- Because we use filetype to enable the source,
            -- we can make the score higher
            score_offset = 100,
            module = "blink-cmp-git",
            name = "Git",
            -- enabled this source at the beginning to make it possible to pre-cache
            -- at very beginning
            enabled = function()
              return vim.tbl_contains({ "gitcommit", "markdown", "octo" }, vim.o.filetype)
            end,
            -- only show this source when filetype is gitcommit or markdown
            -- should_show_items = function()
            -- end,
            --- @module 'blink-cmp-git'
            --- @type blink-cmp-git.Options
            opts = {
              kind_icons = {
                openPR = "",
                openedPR = "",
                closedPR = "",
                mergedPR = "",
                draftPR = "",
                lockedPR = "",
                openIssue = "",
                openedIssue = "",
                reopenedIssue = "",
                completedIssue = "",
                closedIssue = "",
                not_plannedIssue = "",
                duplicateIssue = "",
                lockedIssue = "",
              },
              git_centers = {
                github = {
                  pull_request = {
                    get_command_args = function(command, token)
                      local args = require("blink-cmp-git.default.github").pull_request.get_command_args(command, token)
                      args[#args] = args[#args] .. "?state=all"
                      return args
                    end,
                    get_kind_name = function(item)
                      return item.locked and "lockedPR"
                        or item.draft and "draftPR"
                        or item.merged_at and "mergedPR"
                        or item.state .. "PR"
                    end,
                    configure_score_offset = pr_or_issue_configure_score_offset,
                  },
                  issue = {
                    get_command_args = function(command, token)
                      local args = require("blink-cmp-git.default.github").issue.get_command_args(command, token)
                      args[#args] = args[#args] .. "?state=all"
                      return args
                    end,
                    get_kind_name = function(item)
                      return item.locked and "lockedIssue" or (item.state_reason or item.state) .. "Issue"
                    end,
                    configure_score_offset = pr_or_issue_configure_score_offset,
                  },
                },
                gitlab = {
                  pull_request = {
                    get_command_args = function(command, token)
                      local args = require("blink-cmp-git.default.gitlab").pull_request.get_command_args(command, token)
                      args[#args] = args[#args] .. "?state=all"
                      return args
                    end,
                    get_kind_name = function(item)
                      return item.discussion_locked and "lockedPR" or item.draft and "draftPR" or item.state .. "PR"
                    end,
                    configure_score_offset = pr_or_issue_configure_score_offset,
                  },
                  issue = {
                    get_command_args = function(command, token)
                      local args = require("blink-cmp-git.default.gitlab").issue.get_command_args(command, token)
                      args[#args] = args[#args] .. "?state=all"
                      return args
                    end,
                    get_kind_name = function(item)
                      return item.discussion_locked and "lockedIssue" or item.state .. "Issue"
                    end,
                    configure_score_offset = pr_or_issue_configure_score_offset,
                  },
                },
              },
            },
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
            score_offset = 90, -- the higher the number, the higher the priority
          },
          path = {
            name = "Path",
            module = "blink.cmp.sources.path",
            score_offset = 25,
            -- When typing a path, I would get snippets and text in the
            -- suggestions, I want those to show only if there are no path
            -- suggestions
            fallbacks = { "snippets", "buffer" },
            min_keyword_length = 2,
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
            max_items = 3,
            module = "blink.cmp.sources.snippets",
            min_keyword_length = 4,
            score_offset = 80, -- the higher the number, the higher the priority
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
              -- -- The dictionary by default now uses fzf, make sure to have it
              -- -- installed
              -- -- https://github.com/Kaiser-Yang/blink-cmp-dictionary/issues/2
              --
              -- Do not specify a file, just the path, and in the path you need to
              -- have your .txt files
              dictionary_directories = { vim.fn.expand("~/github/dotfiles-latest/dictionaries") },
              -- Notice I'm also adding the words I add to the spell dictionary
              dictionary_files = {
                vim.fn.expand("~/.dotfiles/nvim/spell/en.utf-8.add.spl"),
              },
              -- --  NOTE: To disable the definitions uncomment this section below
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
        -- command line completion, thanks to dpetka2001 in reddit
        -- https://www.reddit.com/r/neovim/comments/1hjjf21/comment/m37fe4d/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
        sources = function()
          local type = vim.fn.getcmdtype()
          if type == "/" or type == "?" then
            return { "buffer" }
          end
          if type == ":" then
            return { "cmdline" }
          end
          return {}
        end,
      }

      opts.completion = {
        --   keyword = {
        --     -- 'prefix' will fuzzy match on the text before the cursor
        --     -- 'full' will fuzzy match on the text before *and* after the cursor
        --     -- example: 'foo_|_bar' will match 'foo_' for 'prefix' and 'foo__bar' for 'full'
        --     range = "full",
        --   },
        menu = {
          border = "single",
        },
        documentation = {
          auto_show = true,
          window = {
            border = "single",
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
      }

      -- The default preset used by lazyvim accepts completions with enter
      -- I don't like using enter because if on markdown and typing
      -- something, but you want to go to the line below, if you press enter,
      -- the completion will be accepted
      -- https://cmp.saghen.dev/configuration/keymap.html#default
      opts.keymap = {
        preset = "default",
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-c>"] = { "cancel", "fallback" },
        ["<C-y>"] = { "select_and_accept" },

        ["<C-p>"] = { "select_prev", "fallback" },
        ["<C-n>"] = { "select_next", "fallback" },

        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },

        ["<Tab>"] = { "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },
      }

      return opts
    end,

    -- Experimental signature help support
    signature = { enabled = true },
  },
}
