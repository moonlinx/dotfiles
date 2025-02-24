-- Ensure that you add python to $PATH
-- Follow this tutorial: https://ahmadawais.com/python-not-found-on-macos-install-python-with-brew-fix-path/
return {
  "fredrikaverpil/pydoc.nvim",
  dependencies = {
    { "folke/snacks.nvim" }, -- optional
    {
      "nvim-treesitter/nvim-treesitter",
      opts = {
        ensure_installed = { "markdown" },
      },
    },
  },
  cmd = { "PyDoc" },
  opts = {},
}
