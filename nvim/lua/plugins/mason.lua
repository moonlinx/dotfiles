return {
  "williamboman/mason.nvim",
  -- do not update this with config, nvim-java requires this be loaded with opts
  opts = {
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "󰇘",
        package_uninstalled = "✗",
      },
    },
  },
}
