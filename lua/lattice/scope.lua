local scope = {}

function scope.setup(use)
  use {
    "nvim-telescope/telescope.nvim",
    requires = {
      "AckslD/nvim-neoclip.lua",
      "debugloop/telescope-undo.nvim",
      "elmarsto/telescope-nodescripts.nvim",
      "elmarsto/telescope-symbols.nvim",
      "JoseConseco/telescope_sessions_picker.nvim",
      "jvgrootveld/telescope-zoxide",
      "LukasPietzschmann/telescope-tabs",
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-frecency.nvim",
      "nvim-telescope/telescope-project.nvim",
      "protex/better-digraphs.nvim",
      "tami5/sqlite.lua", -- IDEA: do as `after {...}` rule
    },
    config = function()
      local tscope = require("telescope")
      local ll = require("lattice_local")
      tscope.setup {
        pickers = {},
        extensions = {
          sessions_picker = {
            sessions_dir = vim.fn.stdpath('data') .. '/session/',
          },
          media_files = {
            filetypes = { "png", "webp", "jpg", "jpeg" },
            find_cmd = "rg"
          },
          project = ll.project
        }
      }
      vim.g.sqlite_clib_path = require "lattice_local".sqlite.lib
      tscope.load_extension "file_browser"
      tscope.load_extension "frecency"
      tscope.load_extension "nodescripts"
      tscope.load_extension "project"
      tscope.load_extension "undo"
      tscope.load_extension "sessions_picker"
      tscope.load_extension "zoxide"
      require 'telescope-tabs'.setup()
      require 'neoclip'.setup()

      vim.cmd [[
          inoremap <C-k><C-k> <Cmd>lua require'better-digraphs'.digraphs("insert")<CR>
          nnoremap r<C-k><C-k> <Cmd>lua require'better-digraphs'.digraphs("normal")<CR>
          vnoremap r<C-k><C-k> <ESC><Cmd>lua require'better-digraphs'.digraphs("visual")<CR>
        ]]

    end
  }
  use "tversteeg/registers.nvim"
end

return scope
