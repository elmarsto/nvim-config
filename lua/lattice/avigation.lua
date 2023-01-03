local avigation = {}
function avigation.setup(use)
  use {
    'abecodes/tabout.nvim',
    config = function()
      require('tabout').setup {
        tabkey = '<Tab>',
        backwards_tabkey = '<S-Tab>',
        act_as_tab = false, -- shift content if tab out is not possible
        act_as_shift_tab = false, -- reverse shift content if tab out is not possible
        enable_backwards = true, -- well ...
        completion = true, -- if the tabkey is used in a completion pum
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
    wants = { 'nvim-treesitter' }, -- or require if not used so far
    after = { 'nvim-cmp' } -- if a completion plugin is using tabs load it before
  }
  use {
    "cbochs/portal.nvim",
    requires = { "cbochs/grapple.nvim" },
    config = function()
      vim.keymap.set("n", "<leader>o", require("portal").jump_backward, {})
      vim.keymap.set("n", "<leader>i", require("portal").jump_forward, {})
    end
  }
  use {
    "ggandor/leap.nvim",
    requires = { "ggandor/flit.nvim" },
    config = function()
      require('leap').add_default_mappings()
      require('flit').setup()
    end
  }
  use "mbbill/undotree"
  use { "nacro90/numb.nvim",
    config = function()
      require('numb').setup {
        show_numbers = true, -- Enable 'number' for the window while peeking
        show_cursorline = true, -- Enable 'cursorline' for the window while peeking
        hide_relativenumbers = true, -- Enable turning off 'relativenumber' for the window while peeking
        number_only = false, -- Peek only when the command is only a number instead of when it starts with a number
        centered_peeking = true, -- Peeked line will be centered relative to window
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
