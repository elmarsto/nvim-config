local git = {}

function git.setup(use)
  use "APZelos/blamer.nvim"
  use {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end
  }
  use "sindrets/diffview.nvim"
  use "tpope/vim-fugitive"
end

return git
