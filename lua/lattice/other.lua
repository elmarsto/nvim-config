local other = {}

function other.setup(use)
  use "nvim-lua/plenary.nvim"
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
