local other = {}

function other.setup(use)
  use "gbprod/stay-in-place.nvim"
  use "nvim-lua/plenary.nvim"

  use "famiu/bufdelete.nvim"

  use({
    "olimorris/persisted.nvim",
    --module = "persisted", -- For lazy loading
    config = function()
      require("persisted").setup()
      require("telescope").load_extension("persisted") -- To load the telescope extension
    end,
  })
  use "samjwill/nvim-unception"
  use {
    "tami5/sqlite.lua",
    config = function()
      local lattice_local = require "lattice_local"
      vim.g.sqlite_clib_path = lattice_local.sqlite.lib -- I also set this below (race condition?)
    end
  }
  use "wbthomason/packer.nvim" -- self-control
end

return other
