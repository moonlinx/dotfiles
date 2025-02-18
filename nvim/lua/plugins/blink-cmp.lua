return {
  -- add blink.compat
  {
    "saghen/blink.compat",
    lazy = true,
    -- make sure to set opts so that lazy.nvim calls blink.compat's setup
    opts = {},
  },

  "saghen/blink.cmp",
  dependencies = {},
  opts = function(_, opts)
    -- Merge custom sources with the existing ones from lazyvim
    opts.sources = vim.tbl_deep_extend(
      "force",
      opts.sources or {},
      {
        default = { "lsp", "path", "snippets", "buffer", "dictionary" },
        providers = {
          dictionary = {
            module = "blink-cmp-dictionary",
            name = "Dict",
            min_keyword_length = 3,
            max_items = 5,
            score_offset = -3,
            --- @module 'blink-cmp-dictionary'
            --- @type blink-cmp-dictionary.Options
            opts = {
              dictionary_files = {
                vim.fn.expand("~/.config/nvim/spell/en.utf-8.add.spl"),
              },
            },
          },
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
            module = "blink.cmp.sources.path",
            score_offset = 3,
            -- When typing a path, I would get snippets and text in the
            -- suggestions, I want those to show only if there are no path
            -- suggestions
            fallbacks = { "luasnip", "buffer" },
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
      fuzzy == {
        use_frecency = true,
      },
      completion
        == {
          keyword = {
            range = "full",
          },
          accept = {
            auto_brackets = {
              enabled = true,
            },
          },
          list = {
            selection = { preselect = false, auto_insert = true },
          },
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
              components = {
                source_name = {
                  text = function(ctx)
                    return "[" .. ctx.source_name .. "]"
                  end,
                },
                label = {
                  text = function(ctx)
                    if not vim.g.rime_enabled then
                      return ctx.label .. ctx.label_detail
                    end
                    local client = vim.lsp.get_client_by_id(ctx.item.client_id)
                    if not client or client.name ~= "rime_ls" then
                      return ctx.label .. ctx.label_detail
                    end
                    local code_start = #ctx.label_detail + 1
                    for i = 1, #ctx.label_detail do
                      local ch = string.sub(ctx.label_detail, i, i)
                      if ch >= "a" and ch <= "z" then
                        code_start = i
                        break
                      end
                    end
                    local code_end = #ctx.label_detail - 4
                    local code = ctx.label_detail:sub(code_start, code_end)
                    code = string.gsub(code, "  ·  ", " ")
                    if code ~= "" then
                      code = " <" .. code .. ">"
                    end
                    return ctx.label .. code
                  end,
                  highlight = function(ctx, text)
                    if ctx.source_name == "Git" then
                      local id_len = #(ctx.label:match("^[^%s]+"))
                      -- Find id like #123, !123 or hash,
                      -- but not for commit and mention
                      if id_len > 0 and id_len ~= #ctx.label then
                        local highlights = {
                          {
                            0,
                            id_len,
                            group = "BlinkCmpGitLabel" .. ctx.kind,
                          },
                          {
                            id_len,
                            #ctx.label - id_len,
                            require("blink.cmp.config.completion.menu").default.draw.components.label.highlight(
                              ctx,
                              text
                            ),
                          },
                        }
                        -- characters matched on the label by the fuzzy matcher
                        for _, idx in ipairs(ctx.label_matched_indices) do
                          table.insert(highlights, { idx, idx + 1, group = "BlinkCmpLabelMatch" })
                        end
                        return highlights
                      end
                    end
                    return require("blink.cmp.config.completion.menu").default.draw.components.label.highlight(
                      ctx,
                      text
                    )
                  end,
                },
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
        },
      signature == {
        enabled = true,
        window = {
          border = "rounded",
        },
      },
      keymap
        == {
          preset = "default",
          ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
          ["<C-e>"] = { "hide" },
          ["<C-y>"] = { "select_and_accept" },

          ["<C-p>"] = { "select_prev", "fallback" },
          ["<C-n>"] = { "select_next", "fallback" },

          ["<C-b>"] = { "scroll_documentation_up", "fallback" },
          ["<C-f>"] = { "scroll_documentation_down", "fallback" },

          ["<Tab>"] = { "snippet_forward", "fallback" },
          ["<S-Tab>"] = { "snippet_backward", "fallback" },
        },
      appearance == {
        nerd_font_variant = "mono",
      },

      -- This comes from the luasnip extra, if you don't add it, won't be able to
      -- jump forward or backward in luasnip snippets
      -- https://www.lazyvim.org/extras/coding/luasnip#blinkcmp-optional
      opts.snippets
        == {
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
    )
    return opts
  end,
}
