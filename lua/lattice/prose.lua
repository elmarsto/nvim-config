local prose = {}

function prose.setup(use)
  use "ellisonleao/glow.nvim"
  use {
    "jakewvincent/mkdnflow.nvim",
    after = { "plenary.nvim" },
    rocks = 'luautf8',
    config = function()
      vim.cmd("autocmd Filetype markdown set autowriteall")
      require("mkdnflow").setup({
        links = {
          transform_explicit = function(text)
            text = text:gsub(" ", "-")
            text = text:lower()
            return (text)
          end
        }
      })
    end
  }
  use {
    "rawnly/gist.nvim",
    config = function() require("gist").setup() end,
  }
  use {
    "jbyuki/venn.nvim",
    config = function()
      -- see keyboard.lua (using legendary for its clarity)
    end
  }
  use {
    "marcelofern/vale.nvim",
    config = function()
      local ll = require "lattice_local"
      require 'vale'.setup({
        bin = ll.vale.bin,
        vale_config_path = ll.vale.ini
      })
    end
  }
  use {
    'NFrid/due.nvim',
    config = function()
      require('due_nvim').setup {}
    end
  }
  use "preservim/vim-pencil"
  use "tpope/vim-abolish"
  vim.cmd [[
    let g:markdown_folding=1
   ]]
end

return prose
