local git = {}

function git.setup(use)
  use { 'akinsho/git-conflict.nvim', tag = "*", config = function()
    require('git-conflict').setup({})
  end }
  use "APZelos/blamer.nvim"
  use {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end
  }
  use {
    "sindrets/diffview.nvim",
    config = function()
      require "diffview".setup()
    end
  }
  use "tpope/vim-fugitive"
end

return git
