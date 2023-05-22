local avigation = {}
function avigation.setup(use)
  use {
    "ggandor/leap.nvim",
    config = function()
      require('leap').add_default_mappings()
    end
  }
  use "mbbill/undotree"
  use { "nacro90/numb.nvim",
    config = function()
      require('numb').setup {
        show_numbers = true,         -- Enable 'number' for the window while peeking
        show_cursorline = true,      -- Enable 'cursorline' for the window while peeking
        hide_relativenumbers = true, -- Enable turning off 'relativenumber' for the window while peeking
        number_only = false,         -- Peek only when the command is only a number instead of when it starts with a number
        centered_peeking = true,     -- Peeked line will be centered relative to window
      }
    end
  }
end

return avigation
