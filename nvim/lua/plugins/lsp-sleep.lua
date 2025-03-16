return {
  "zeioth/garbage-day.nvim",
  -- dependencies = "neovim/nvim-lspconfig",
  event = "VeryLazy",
  opts = {
    --Set it to true to stop all lsp clients except the current buffer, every time you enter a buffer. aggressive_mode ignores grace_period, and it only triggers when entering a buffer with a different filetype than the current buffer. Ensures the maximum RAM save.
    aggressive_mode = true,

    -- Seconds to wait before stopping all LSP clients after neovim loses focus.
    grace_period = 60 * 15,

    -- Milliseconds to wait before restoring LSP after the mouse re-enters nvim. Useful to avoid waking up the LSP clients by accident when passing the mouse over it.
    -- wakeup_delay = 0,
  },
}
