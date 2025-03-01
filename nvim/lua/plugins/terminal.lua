return {
  "akinsho/toggleterm.nvim",
  keys = {
    {
      "<c-g>",
      function()
        if global_lazygit == nil then
          global_lazygit = require("toggleterm.terminal").Terminal:new({
            cmd = "lazygit",
            hidden = true,
          })
        end
        global_lazygit:toggle()
      end,
      mode = { "i", "n", "t" },
      silent = true,
      noremap = true,
      desc = "Toggle lazygit",
    },
    {
      "<c-t>",
      "<cmd>ToggleTerm<cr>",
      mode = { "i", "n", "t" },
      silent = true,
      noremap = true,
      desc = "Toggle terminal",
    },
    {
      "<leader>r",
      function()
        local fullpath = vim.fn.expand("%:p")
        local directory = vim.fn.fnamemodify(fullpath, ":h")
        local filename = vim.fn.fnamemodify(fullpath, ":t")
        local filename_noext = vim.fn.fnamemodify(fullpath, ":t:r")
        local command = ""
        if vim.bo.filetype == "c" then
          command = string.format(
            'gcc -g -Wall "%s" -I include -o "%s.out" && echo RUNNING && time "./%s.out"',
            filename,
            filename_noext,
            filename_noext
          )
        elseif vim.bo.filetype == "cpp" then
          command = string.format(
            'g++ -g -Wall -std=c++17 -I include "%s" -o "%s.out" && echo RUNNING && time "./%s.out"',
            filename,
            filename_noext,
            filename_noext
          )
        elseif vim.bo.filetype == "java" then
          command = string.format('javac "%s" && echo RUNNING && time java "%s"', filename, filename_noext)
        elseif vim.bo.filetype == "sh" then
          command = string.format('time "./%s"', filename)
        elseif vim.bo.filetype == "python" then
          command = string.format('time python3 "%s"', filename)
        elseif vim.bo.filetype == "html" then
          command = string.format('wslview "%s" &', filename)
        elseif vim.bo.filetype == "lua" then
          command = string.format('lua "%s"', filename)
        end
        if command == "" then
          print("Unsupported filetype")
          return
        end
        command = string.format("TermExec cmd='cd \"%s\" && %s' dir='%s'", directory, command, directory)
        vim.cmd(command)
      end,
      mode = "n",
      desc = "Compile and run",
      noremap = true,
    },
  },
  opts = {
    direction = "float",
  },
}
