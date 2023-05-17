local git = {}

function git.setup(use)
  use "APZelos/blamer.nvim"
  use {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end
  }
  use {
    'pwntester/octo.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'kyazdani42/nvim-web-devicons',
    },
    config = function()
      require "octo".setup()
    end
  }
  use {
    "ruifm/gitlinker.nvim",
    config = function()
      require "gitlinker".setup()
    end
  }
  use "sindrets/diffview.nvim"
  use "tpope/vim-fugitive"
end

return git
