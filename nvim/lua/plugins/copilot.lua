return {
  "zbirenbaum/copilot.lua",
  event = "InsertEnter",
  opts = {
    panel = {
      enabled = false,
    },
    suggestion = {
      hide_during_completion = false,
      keymap = {
        accept = "<m-cr>",
        accept_word = "<m-e>",
        accept_line = "<c-e>",
        next = false,
        prev = false,
        dismiss = "<c-c>",
      },
    },
    filetypes = {
      markdown = true,
      yaml = true,
      lua = true,
    },
  },
}
