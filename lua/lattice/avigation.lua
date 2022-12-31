local avigation = {}


function avigation.setup(use)
  -- Lua
  use {
    'abecodes/tabout.nvim',
    config = function()
      require('tabout').setup {
        tabkey = '<Tab>',
        backwards_tabkey = '<S-Tab>', -- key to trigger backwards tabout, set to an empty string to disable
        act_as_tab = false, -- shift content if tab out is not possible
        act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
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
    after = { 'nvim-cmp' } -- if a completion plugin is using tabs load ie before
  }
  use {
    "ggandor/leap.nvim",
    requires = { "ggandor/flit.nvim" },
    config = function()
      require('leap').add_default_mappings()
      require('flit').setup()
    end
  }
  use "kana/vim-textobj-user"
  use "kana/vim-textobj-line"
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
  use {
    "sindrets/winshift.nvim",
    config = function()
      -- Lua
      require("winshift").setup({
        highlight_moving_win = true, -- Highlight the window being moved
        focused_hl_group = "Visual", -- The highlight group used for the moving window
        moving_win_options = {
          -- These are local options applied to the moving window while it's
          -- being moved. They are unset when you leave Win-Move mode.
          wrap = false,
          cursorline = false,
          cursorcolumn = false,
          colorcolumn = "",
        },
        keymaps = {
          disable_defaults = false, -- Disable the default keymaps
          win_move_mode = {
            ["h"] = "left",
            ["j"] = "down",
            ["k"] = "up",
            ["l"] = "right",
            ["H"] = "far_left",
            ["J"] = "far_down",
            ["K"] = "far_up",
            ["L"] = "far_right",
            ["<left>"] = "left",
            ["<down>"] = "down",
            ["<up>"] = "up",
            ["<right>"] = "right",
            ["<S-left>"] = "far_left",
            ["<S-down>"] = "far_down",
            ["<S-up>"] = "far_up",
            ["<S-right>"] = "far_right",
          },
        },
        ---A function that should prompt the user to select a window.
        ---
        ---The window picker is used to select a window while swapping windows with
        ---`:WinShift swap`.
        ---@return integer? winid # Either the selected window ID, or `nil` to
        ---   indicate that the user cancelled / gave an invalid selection.
        window_picker = function()
          return require("winshift.lib").pick_window({
            -- A string of chars used as identifiers by the window picker.
            picker_chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
            filter_rules = {
              -- This table allows you to indicate to the window picker that a window
              -- should be ignored if its buffer matches any of the following criteria.
              cur_win = true, -- Filter out the current window
              floats = true, -- Filter out floating windows
              filetype = {}, -- List of ignored file types
              buftype = {}, -- List of ignored buftypes
              bufname = {}, -- List of vim regex patterns matching ignored buffer names
            },
            ---A function used to filter the list of selectable windows.
            ---@param winids integer[] # The list of selectable window IDs.
            ---@return integer[] filtered # The filtered list of window IDs.
            filter_func = nil,
          })
        end,
      })
    end
  }
end

return avigation
