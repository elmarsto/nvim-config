local prose = {}

function prose.setup(use)
  use "ellisonleao/glow.nvim"
  use {
    "epwalsh/obsidian.nvim",
    config = function()
      require 'obsidian'.setup({
        dir = "~/navaruk",
        notes_subdir = 'zeteka',
        daily_notes = {
          folder = 'zeteka',
        },
        templates = {
          subdir = 'bureka',
          date_format = '%Y-%m-%d-%a',
          time_format = '%H:%M',
        },
        completion = {
          nvim_cmp = true,
        },
      })
      vim.keymap.set(
        "n",
        "gf",
        -- TODO: move to keyboard.lua
        function()
          if require('obsidian').util.cursor_on_markdown_link() then
            return "<cmd>ObsidianFollowLink<CR>"
          else
            return "gf"
          end
        end,
        { noremap = false, expr = true }
      )
    end
  }
  use {
    "jakewvincent/mkdnflow.nvim", rocks = 'luautf8',
    config = function()
      vim.cmd("autocmd Filetype markdown set autowriteall")
      require("mkdnflow").setup()
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
    'NFrid/due.nvim',
    config = function()
      require('due_nvim').setup {}
    end
  }
  use "preservim/vim-pencil"
  use "pirmd/gemini.vim"
  vim.cmd [[
    autocmd BufWinEnter *.html iabbrev --- &mdash;
    autocmd BufWinEnter *.svelte iabbrev --- &mdash;
    autocmd BufWinEnter *.jsx iabbrev --- &mdash;
    autocmd BufWinEnter *.tsx iabbrev --- &mdash;
    autocmd BufWinEnter *.norg inoremap <M-CR> <End><CR>- [ ]
    autocmd BufWinEnter *.md inoremap <M-CR> <End><CR>- [ ]
    let g:markdown_folding=1
   ]]
end

return prose
