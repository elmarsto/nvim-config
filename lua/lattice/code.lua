local code = {}

function code.setup(use)
  use {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end
  }
  use "bfredl/nvim-luadev"
  use "dmix/elvish.vim"
  use "github/copilot.vim"
  use {
    "simrat39/rust-tools.nvim",
    config = function()
      require("rust-tools").setup(
        {
          -- from https://github.com/simrat39/rust-tools.nvim/issues/72
          server = {
            settings = {
              ["rust-analyzer"] = {
                unstable_features = true,
                build_on_save = false,
                all_features = true,
                checkOnSave = {
                  enable = true,
                  command = "check",
                  extraArgs = { "--target-dir", "/tmp/rust-analyzer-check" }
                }
              }
            }
          }
        }
      )
    end
  }
  use "rafcamlet/nvim-luapad"
  use {
    "smjonas/inc-rename.nvim",
    config = function()
      require "inc_rename".setup()
    end
  }
  use "tpope/vim-surround"
  use {
    "windwp/nvim-autopairs",
    config = function()
      require('nvim-autopairs').setup({ disable_filetype = { "TelescopePrompt", "vim" } })
    end
  }
end

return code
