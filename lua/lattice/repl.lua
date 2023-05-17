local repl = {}

function repl.setup(use)
  -- https://www.maxwellrules.com/misc/nvim_jupyter.html
  use { "hkupty/iron.nvim",
    config = function()
      require 'iron.core'.setup {
        config = {
          scratch_repl = true,
          repl_definition = {
            -- TODO: add other repls here: lua, node, deno, etc.
            sh = {
              command = { "nsh" }
            },
            python = {
              command = { "ipython" },
              format = require("iron.fts.common").bracketed_paste
            }

          },
          repl_open_cmd = require('iron.view').bottom(40),
        },
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
        highlight = {
          italic = true
        },
        ignore_blank_lines = true,
      }
      vim.keymap.set('n', '<space>rs', '<cmd>IronRepl<cr>')
      vim.keymap.set('n', '<space>rr', '<cmd>IronRestart<cr>')
      vim.keymap.set('n', '<space>rf', '<cmd>IronFocus<cr>')
      vim.keymap.set('n', '<space>rh', '<cmd>IronHide<cr>')
    end
  }
  use {
    "GCBallesteros/jupytext.vim",
    config = function()
      vim.cmd [[
          let g:jupytext_fmt = 'py'
          let g:jupytext_style = 'hydrogen'
        ]]
    end
  }
  use "rafcamlet/nvim-luapad"
end

return repl
