return {
  "MeanderingProgrammer/markdown.nvim",
  name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
  dependencies = {
    "nvim-treesitter/nvim-treesitter", -- Mandatory
    "nvim-tree/nvim-web-devicons", -- Optional but recommended
  },
  config = function()
    require("render-markdown").setup({
      -- Whether Markdown should be rendered by default or not
      start_enabled = true,
      -- Whether LaTeX should be rendered, mainly used for health check
      latex_enabled = true,
      -- Maximum file size (in MB) that this plugin will attempt to render
      -- Any file larger than this will effectively be ignored
      max_file_size = 1.5,
      -- Capture groups that get pulled from markdown
      markdown_query = [[
        (atx_heading [
            (atx_h1_marker)
            (atx_h2_marker)
            (atx_h3_marker)
            (atx_h4_marker)
            (atx_h5_marker)
            (atx_h6_marker)
        ] @heading)

        (thematic_break) @dash

        (fenced_code_block) @code

        [
            (list_marker_plus)
            (list_marker_minus)
            (list_marker_star)
        ] @list_marker

        (task_list_marker_unchecked) @checkbox_unchecked
        (task_list_marker_checked) @checkbox_checked

        (block_quote (block_quote_marker) @quote_marker)
        (block_quote (block_continuation) @quote_marker)
        (block_quote (paragraph (block_continuation) @quote_marker))
        (block_quote (paragraph (inline (block_continuation) @quote_marker)))

        (pipe_table) @table
        (pipe_table_header) @table_head
        (pipe_table_delimiter_row) @table_delim
        (pipe_table_row) @table_row
    ]],
      -- Capture groups that get pulled from inline markdown
      inline_query = [[
        (code_span) @code

        (shortcut_link) @callout
    ]],
      -- Executable used to convert latex formula to rendered unicode
      latex_converter = "latex2text",
      -- The level of logs to write to file: vim.fn.stdpath('state') .. '/render-markdown.log'
      -- Only intended to be used for plugin development / debugging
      log_level = "error",
      -- Filetypes this plugin will run on
      file_types = { "markdown" },
      -- Vim modes that will show a rendered view of the markdown file
      -- All other modes will be uneffected by this plugin
      render_modes = { "n", "c" },
      -- Characters that will replace the # at the start of headings
      headings = { "󰼏 ", "󰎨 ", "󰼑 ", "󰎲 ", "󰼓 ", "󰎴 " },
      -- Character to use for the horizontal break
      dash = "─",
      -- Character to use for the bullet points in lists
      bullets = { "●", "○", "◆", "◇" },
      checkbox = {
        -- Character that will replace the [ ] in unchecked checkboxes
        unchecked = "✘ ",
        -- Character that will replace the [x] in checked checkboxes
        checked = "✔ ",
      },
      -- Character that will replace the > at the start of block quotes
      quote = "┃",
      -- Symbol / text to use for different callouts
      callout = {
        note = "  Note",
        tip = "󰌶 Tip",
        important = "󰀨  Important",
        warning = "  Warning",
        caution = "󰳦  Caution",
      },
      -- Window options to use that change between rendered and raw view
      win_options = {
        -- See :h 'conceallevel'
        conceallevel = {
          -- Used when not being rendered, get user setting
          default = vim.api.nvim_get_option_value("conceallevel", {}),
          -- Used when being rendered, concealed text is completely hidden
          rendered = 3,
        },
        -- See :h 'concealcursor'
        concealcursor = {
          -- Used when not being rendered, get user setting
          default = vim.api.nvim_get_option_value("concealcursor", {}),
          -- Used when being rendered, conceal text in all modes
          rendered = "nvic",
        },
      },
      -- Determines how code blocks are rendered
      --  full: adds language icon above code block if possible + normal behavior
      --  normal: renders a background
      --  none: disables rendering
      code_style = "full",
      -- Determines how tables are rendered
      --  full: adds a line above and below tables + normal behavior
      --  normal: renders the rows of tables
      --  none: disables rendering
      table_style = "full",
      -- Determines how table cells are rendered
      --  overlay: writes over the top of cells removing conealing and highlighting
      --  raw: will leave the cells as they and only replace table related symbols
      cell_style = "overlay",
      -- Mapping from treesitter language to user defined handlers
      -- See 'Custom Handlers' section for more info
      custom_handlers = {},
      -- Define the highlight groups to use when rendering various components
      highlights = {
        heading = {
          -- Background of heading line
          backgrounds = { "DiffAdd", "DiffChange", "DiffDelete" },
          -- Foreground of heading character only
          foregrounds = {
            "markdownH1",
            "markdownH2",
            "markdownH3",
            "markdownH4",
            "markdownH5",
            "markdownH6",
          },
        },
        -- Horizontal break
        dash = "LineNr",
        -- Code blocks
        code = "ColorColumn",
        -- Bullet points in list
        bullet = "Normal",
        checkbox = {
          -- Unchecked checkboxes
          unchecked = "@markup.list.unchecked",
          -- Checked checkboxes
          checked = "@markup.heading",
        },
        table = {
          -- Header of a markdown table
          head = "@markup.heading",
          -- Non header rows in a markdown table
          row = "Normal",
        },
        -- LaTeX blocks
        latex = "@markup.math",
        -- Quote character in a block quote
        quote = "@markup.quote",
        -- Highlights to use for different callouts
        callout = {
          note = "DiagnosticInfo",
          tip = "DiagnosticOk",
          important = "DiagnosticHint",
          warning = "DiagnosticWarn",
          caution = "DiagnosticError",
        },
      },
    })
  end,
}
