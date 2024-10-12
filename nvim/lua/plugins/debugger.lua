return {
  "mfussenegger/nvim-dap-python",
  keys = {
    -- **Test-Related Key Mappings**
    {
      mode = "n",
      "<leader>dm",
      function()
        require("dap-python").test_method()
      end,
      desc = "Debug Test Method",
    },
    {
      mode = "n",
      "<leader>dc",
      function()
        require("dap-python").test_class()
      end,
      desc = "Debug Test Class",
    },
    -- **File-Related Key Mappings**
    {
      mode = "n",
      "<leader>df",
      function()
        require("dap-python").debug_file()
      end,
      desc = "Debug Python File",
    },

    -- **Function-Related Key Mappings**
    {
      mode = "n",
      "<leader>du",
      function()
        -- Custom function to debug the function under the cursor
        local dap_python = require("dap-python")
        local utils = require("dap-python.utils")
        local path = vim.fn.expand("%:p")
        local row = vim.fn.line(".")
        local func_name = utils.get_func_at_line(path, row)
        if func_name then
          dap_python.debug_at_point()
        else
          print("No function found under cursor.")
        end
      end,
      desc = "Debug Function Under Cursor",
    },

    -- **Class-Related Key Mappings**
    {
      mode = "n",
      "<leader>dk",
      function()
        -- Custom function to debug the class under the cursor
        local dap_python = require("dap-python")
        local utils = require("dap-python.utils")
        local path = vim.fn.expand("%:p")
        local row = vim.fn.line(".")
        local class_name = utils.get_class_at_line(path, row)
        if class_name then
          dap_python.debug_at_point()
        else
          print("No class found under cursor.")
        end
      end,
      desc = "Debug Class Under Cursor",
    },
  },
  config = function()
    require("dap-python").setup(vim.g.python3_host_prog)
    require("dap-python").test_runner = "pytest"
  end,
}
