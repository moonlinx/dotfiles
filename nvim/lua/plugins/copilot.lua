return {
  "zbirenbaum/copilot.lua",
  event = "InsertEnter",
  opts = {
    panel = {
      enabled = false,
    },
    suggestion = {
      auto_trigger = true,
      hide_during_completion = false,
      keymap = {
        accept = "<m-cr>",
        accept_word = "<m-f>",
        accept_line = "<c-f>",
        next = false,
        prev = false,
        dismiss = "<c-c>",
      },
    },
    filetypes = {
      ["*"] = true,
    },
    copilot_node_command = "node",
    server_opts_overrides = {},
  },
}
