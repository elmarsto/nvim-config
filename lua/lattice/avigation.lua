local avigation = {}
function avigation.setup(use)
  use {
    'abecodes/tabout.nvim',
    after = { 'nvim-cmp', 'nvim-treesitter' }, -- if a completion plugin is using tabs load it before
    config = function()
      require('tabout').setup {
        tabkey = '<C-Space>',
        backwards_tabkey = '<C-S-Space>',
        act_as_tab = false,       -- shift content if tab out is not possible
        act_as_shift_tab = false, -- reverse shift content if tab out is not possible
        enable_backwards = true,  -- well ...
        completion = true,        -- if the tabkey is used in a completion pum
        tabouts = {
          { open = "'", close = "'" },
          { open = '"', close = '"' },
          { open = '`', close = '`' },
          { open = '(', close = ')' },
          { open = '[', close = ']' },
          { open = '{', close = '}' }
        },
        ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
        exclude = {} -- tabout will ignore these filetypes
      }
    end,
  }
  use {
    "cbochs/portal.nvim",
    requires = { "cbochs/grapple.nvim" },
    config = function()
      local portal = require 'portal'
      portal.setup()
      local grapple = require 'grapple'
      grapple.setup({ integrations = { resession = true } })

      vim.keymap.set("n", "<leader>o", "<cmd>Portal jumplist backward<cr>")
      vim.keymap.set("n", "<leader>i", "<cmd>Portal jumplist forward<cr>")
      vim.keymap.set("n", "<leader>m", grapple.toggle)
      vim.keymap.set("n", "<leader>j", function()
        grapple.select({ key = "{name}" })
      end)

      vim.keymap.set("n", "<leader>J", function()
        grapple.toggle({ key = "{name}" })
      end)
    end
  }
  use {
    "ggandor/leap.nvim",
    requires = { "ggandor/flit.nvim", "ggandor/leap-spooky.nvim" },
    config = function()
      require('leap').add_default_mappings()
      require('flit').setup()
      require('leap-spooky').setup()
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
  use {
    "simrat39/symbols-outline.nvim",
    config = function()
      require("symbols-outline").setup()
    end
  }
end

return avigation
