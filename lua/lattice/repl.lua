local repl = {}

function repl.setup(use)
  -- https://www.maxwellrules.com/misc/nvim_jupyter.html
  use { "hkupty/iron.nvim",
    config = function()
      require 'iron.core'.setup {
        config = {
          -- Whether a repl should be discarded or not
          scratch_repl = true,
          -- Your repl definitions come here
          repl_definition = {
            sh = {
              -- Can be a table or a function that
              -- returns a table (see https://github.com/hkupty/iron.nvim)
              command = { "nsh" }
            },
            -- https://www.maxwellrules.com/misc/nvim_jupyter.html
            python = {
              command = { "ipython" },
              format = require("iron.fts.common").bracketed_paste
            }

          },
          -- How the repl window will be displayed
          -- See below for more information
          repl_open_cmd = require('iron.view').bottom(40),
        },
        -- Iron doesn't set keymaps by default anymore.
        -- You can set them here or manually add keymaps to the functions in iron.core
        keymaps = {
          send_motion = "<space>sc",
          visual_send = "<space>sc",
          send_file = "<space>sf",
          send_line = "<space>sl",
          send_mark = "<space>sm",
          mark_motion = "<space>mc",
          mark_visual = "<space>mc",
          remove_mark = "<space>md",
          cr = "<space>s<cr>",
          interrupt = "<space>s<space>",
          exit = "<space>sq",
          clear = "<space>cl",
        },
        -- If the highlight is on, you can change how it looks
        -- For the available options, check nvim_set_hl
        highlight = {
          italic = true
        },
        ignore_blank_lines = true,

      }
      -- iron also has a list of commands, see :h iron-commands for all available commands
      vim.keymap.set('n', '<space>rs', '<cmd>IronRepl<cr>')
      vim.keymap.set('n', '<space>rr', '<cmd>IronRestart<cr>')
      vim.keymap.set('n', '<space>rf', '<cmd>IronFocus<cr>')
      vim.keymap.set('n', '<space>rh', '<cmd>IronHide<cr>')
    end
  }
  use { "GCBallesteros/vim-textobj-hydrogen",
    config = function()
      -- https://www.maxwellrules.com/misc/nvim_jupyter.html
      vim.cmd [[
           nmap ]x ctrih/^# %%<CR><CR> 
        ]]
    end
  }
  use {
    "GCBallesteros/jupytext.vim",
    config = function()
      -- https://www.maxwellrules.com/misc/nvim_jupyter.html
      vim.cmd [[
          let g:jupytext_fmt = 'py'
          let g:jupytext_style = 'hydrogen'
        ]]
    end
  }
end

return repl
