local scope = {}

function scope.setup(use)
  use {
    "nvim-telescope/telescope.nvim",
    requires = {
      "elmarsto/telescope-nodescripts.nvim",
      "jvgrootveld/telescope-zoxide",
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-project.nvim",
      "tami5/sqlite.lua",
      "nvim-lua/plenary.nvim",
    },
    -- TODO: this appeared not work, why?
    -- after = { "plenary.nvim", "sqlite.lua" },
    config = function()
      local tscope = require("telescope")
      local ll = require("lattice_local")
      tscope.setup {
        pickers = {},
        extensions = {
          media_files = {
            filetypes = { "png", "webp", "jpg", "jpeg" },
            find_cmd = "rg"
          },
          project = ll.project
        }
      }
      vim.g.sqlite_clib_path = require "lattice_local".sqlite.lib
      tscope.load_extension "file_browser"
      tscope.load_extension "nodescripts"
      tscope.load_extension "project"
      tscope.load_extension "zoxide"
    end
  }
  use {
    'LukasPietzschmann/telescope-tabs',
    requires = { 'nvim-telescope/telescope.nvim' },
    config = function()
      require 'telescope-tabs'.setup()
    end
  }
end

return scope
