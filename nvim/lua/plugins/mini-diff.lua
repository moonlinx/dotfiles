return {
  "echasnovski/mini.diff",
  version = false,
  config = function()
    require("mini.diff").setup({
      -- Options for how hunks are visualized
      view = {
        style = "sign",
        -- Signs used for hunks with 'sign' view
        signs = { add = " ", change = " ", delete = "" },
      },
    })
  end,
}
