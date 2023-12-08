local git = {}

function git.setup(use)
  use { 'akinsho/git-conflict.nvim', tag = "*", config = function()
    require('git-conflict').setup()
  end }
  use { "APZelos/blamer.nvim",
    config = function()
      vim.g.blamer_enabled = true
    end
  }
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
