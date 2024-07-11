return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    -- "nvim-tree/nvim-web-devicons",
    "echasnovski/mini.icons",
  },
  config = function()
    local nvimtree = require("nvim-tree")

    -- recommended settings from nvim-tree documentation
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- change color for arrows in tree to light blue
    vim.cmd([[ highlight NvimTreeFolderArrowClosed guifg=#3FC5FF ]])
    vim.cmd([[ highlight NvimTreeFolderArrowOpen guifg=#3FC5FF ]])

    -- configure nvim-tree
    nvimtree.setup({
      view = {
        width = 35,
        relativenumber = true,
      },
      -- change folder arrow icons
      renderer = {
        indent_markers = {
          enable = true,
        },
        icons = {
          glyphs = {
            folder = {
              arrow_closed = "", -- arrow when folder is closed
              arrow_open = "", -- arrow when folder is open
            },
          },
        },
      },

      require("nvim-tree").setup({
        on_attach = function(bufnr)
          local function opts(desc)
            return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
          end

          local preview = require("nvim-tree-preview")

          vim.keymap.set("n", "P", preview.watch, opts("Preview (Watch)"))
          vim.keymap.set("n", "<Esc>", preview.unwatch, opts("Close Preview/Unwatch"))

          -- Option A: Smart tab behavior: Only preview files, expand/collapse directories (recommended)
          vim.keymap.set("n", "<Tab>", function()
            local ok, node = pcall(api.tree.get_node_under_cursor)
            if ok and node then
              if node.type == "directory" then
                api.node.open.edit()
              else
                preview.node(node, { toggle_focus = true })
              end
            end
          end, opts("Preview"))

          -- Option B: Simple tab behavior: Always preview
          -- vim.keymap.set('n', '<Tab>', preview.node_under_cursor, opts 'Preview')
        end,
      }),
      -- disable window_picker for
      -- explorer to work well with
      -- window splits
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
        },
      },
      filters = {
        custom = { ".DS_Store" },
      },
      git = {
        ignore = false,
      },
    })

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
    keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" }) -- toggle file explorer on current file
    keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
    keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer
  end,
}
