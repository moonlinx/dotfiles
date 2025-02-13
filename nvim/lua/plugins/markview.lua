return {
  "OXY2DEV/markview.nvim",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("markview").setup({
      preview = {
        icon_provider = "mini",
        modes = { "n", "i", "no", "c" },
        hybrid_modes = { "n", "i" },
      },
    })
  end,
}
