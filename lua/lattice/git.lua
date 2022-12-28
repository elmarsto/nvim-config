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
  use {
    "TimUntersberger/neogit",
    config = function()
      require "neogit".setup(
        {
          integrations = {
            diffview = true
          }
        }
      )
    end
  }
  use { "tanvirtin/vgit.nvim",
    requires = { "nvim-lua/plenary.nvim" }

  }
  use "tpope/vim-fugitive"
  use {
    "zegervdv/settle.nvim",
    opt = true,
    cmd = { "SettleInit" },
    config = function()
      require("settle").setup {
        wrap = true,
        symbol = "!",
        keymaps = {
          next_conflict = "-n",
          prev_conflict = "-N",
          use_ours = "-u1",
          use_theirs = "-u2",
          close = "-q"
        }
      }
    end
  }
end

return git
