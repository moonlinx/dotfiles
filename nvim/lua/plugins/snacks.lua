return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    dashboard = {
      width = 50,
      preset = {
        header = [[
   _____                       ____   _____         
  /     \   ____   ____   ____ \   \ /  /__| _____  
 /  \ /  \ / __ \ / __ \ /    \ \   \  /|  |/     \ 
/    \    \  \_\ )  \_\ )   |  \ \    / |  |  | |  \
\____/\_  /\____/ \____/|___|  /  \  /  |__|__|_|  /
        \/                   \/    \/            \/ ]],
      },
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 2 },
        {
          padding = 1,
          title = [[
______  /\___________________/\      m o o n 
      \/                       \  _______________
                                \/                ]],
        },
        { section = "startup" },
      },
    },
    statuscolumn = { enabled = true },
  },
}
