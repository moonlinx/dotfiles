return {
  "epwalsh/obsidian.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  ft = "markdown",
  keys = {
    {
      "<leader>on",
      function()
        vim.api.nvim_command("ObsidianNew")
        vim.api.nvim_buf_set_lines(0, 0, -1, false, {}) -- Clear buffer
        vim.api.nvim_command("ObsidianTemplate Core") -- Apply Core Template
      end,
      desc = "Create new note",
    },
    { "<leader>oo", "<cmd>ObsidianSearch<cr>", desc = "Search Obsidian notes" },
    { "<leader>os", "<cmd>ObsidianQuickSwitch<cr>", desc = "Quick Switch" },
    { "<leader>ob", "<cmd>ObsidianBacklinks<cr>", desc = "Show location list of backlinks" },
    { "<leader>of", "<cmd>ObsidianFollowLink<cr>", desc = "Follow link under cursor" },
    { "<leader>ot", "<cmd>ObsidianTemplate Core<cr>", desc = "Apply Core Template" },
  },
  opts = {
    workspaces = {
      {
        name = "vault",
        path = "~/Vault/",
      },
    },

    templates = {
      folder = "~/Vault/99 - Meta/00 - Templates/",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
      -- A map for custom variables, the key should be the variable and the value a function
      substitutions = {},
    },

    attachments = {
      -- The default folder to place images in via `:ObsidianPasteImg`.
      -- If this is a relative path it will be interpreted as relative to the vault root.
      -- You can always override this per image by passing a full path to the command instead of just a filename.
      img_folder = "~/Vault/99 - Meta/01 - Assets/imgs/", -- This is the default
      -- A function that determines the text to insert in the note when pasting an image.
      -- It takes two arguments, the `obsidian.Client` and an `obsidian.Path` to the image file.
      -- This is the default implementation.
      ---@param client obsidian.Client
      ---@param path obsidian.Path the absolute path to the image file
      ---@return string
      img_text_func = function(client, path)
        path = client:vault_relative_path(path) or path
        return string.format("![%s](%s)", path.name, path)
      end,
    },
  },
}
