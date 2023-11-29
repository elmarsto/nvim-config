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
    "jalvesaq/dict.nvim",
    config = function()
      local dict_dir = require "lattice_local".dict_dir
      require 'dict'.setup({
        dict_dir = dict_dir,
      })
      vim.keymap.set('n', '<Leader>d', '<Cmd>lua require("dict").lookup()<CR>')
    end
  }
  use {
    "jbyuki/venn.nvim",
    config = function()
      -- see keyboard.lua (using legendary for its clarity)
    end
  }
  use "kana/vim-textobj-user"
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
  use { "preservim/vim-textobj-quote",
    config = function()
      vim.cmd [[
      let g:textobj#quote#educate = 1
      augroup textobj_quote
        autocmd!
        autocmd FileType markdown call textobj#quote#init()
        autocmd FileType textile call textobj#quote#init()
        autocmd FileType text call textobj#quote#init({'educate': 0})
      augroup END
      ]]
    end
  }
  use "pirmd/gemini.vim"
  use "tpope/vim-abolish"
  vim.cmd [[
    let g:markdown_folding=1
   ]]
end

return prose
