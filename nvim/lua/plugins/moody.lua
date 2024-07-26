return {
  "svampkorg/moody.nvim",
  event = { "ModeChanged", "BufWinEnter", "WinEnter" },
  dependencies = {
    -- or whatever "colorscheme" you use to setup your HL groups :)
    -- Colours can also be set within setup, in which case this is redundant.
    "catppuccin/nvim",
  },
  opts = {
    -- you can set different blend values for your different modes.
    -- Some colours might look better more dark, so set a higher value
    -- will result in a darker shade.
    blends = {
      normal = 0.2,
      insert = 0.2,
      visual = 0.25,
      command = 0.2,
      operator = 0.2,
      replace = 0.2,
      select = 0.2,
      terminal = 0.2,
      terminal_n = 0.2,
    },
    -- there are two ways to define colours for the different modes.
    -- one way is to define theme here in colors. Another way is to
    -- set them up with highlight groups. Any highlight group set takes
    -- precedence over any colours defined here.
    colors = {
      normal = "#00BFFF",
      insert = "#70CF67",
      visual = "#AD6FF7",
      command = "#EB788B",
      operator = "#FF8F40",
      replace = "#E66767",
      select = "#AD6FF7",
      terminal = "#4CD4BD",
      terminal_n = "#00BBCC",
    },
    -- disable filetypes here. Add for example "TelescopePrompt" to
    -- not have any coloured cursorline for the telescope prompt.
    disabled_filetypes = { "TelescopePrompt" },
    -- you can turn on or off bold characters for the line numbers
    bold_nr = true,
    -- you can turn on and off a feature which shows a little icon and
    -- registry number at the end of the CursorLine, for when you are
    -- recording a macro! Default is false.
    recording = {
      enabled = false,
      icon = "󰑋",
      -- you can set some text to surround the recording registry char with
      -- or just set one to empty to maybe have just one letter, an arrow
      -- perhaps! For example recording to q, you could have! "󰑋    q" :D
      pre_registry_text = "[",
      post_registry_text = "]",
    },
  },
}
