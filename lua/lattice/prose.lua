local prose = {}

function prose.setup(use)
  use "ellisonleao/glow.nvim"
  use "ekickx/clipboard-image.nvim"
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
  use "f3fora/cmp-spell"
  use {
    "jakewvincent/mkdnflow.nvim", rocks = 'luautf8',
    config = function()
      vim.cmd("autocmd Filetype markdown set autowriteall")
      require("mkdnflow").setup()
    end
  }
  use "jbyuki/venn.nvim"
  use {
    'NFrid/due.nvim',
    config = function()
      require('due_nvim').setup {}
    end
  }
  use {
    "phaazon/mind.nvim",
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require 'mind'.setup()
    end
  }
  use "preservim/vim-colors-pencil"
  use "preservim/vim-pencil"
  use { "preservim/vim-textobj-quote",
    config = function()
      -- from https://github.com/preservim/vim-textobj-quote README.md
      vim.cmd [[
          filetype plugin on
          augroup textobj_quote
            autocmd!
            autocmd FileType markdown call textobj#quote#init()
            autocmd FileType textile call textobj#quote#init()
            autocmd FileType text call textobj#quote#init({'educate': 0})
          augroup END
        ]]
    end
  }
  use { "preservim/vim-textobj-sentence",
    config = function()
      -- from https://github.com/preservim/vim-textobj-sentence README.md
      vim.cmd [[
          filetype plugin indent on
          augroup textobj_sentence
            autocmd!
            autocmd FileType markdown call textobj#sentence#init()
            autocmd FileType textile call textobj#sentence#init()
          augroup END
        ]]
    end }
  use "preservim/vim-wordy"
  use "pirmd/gemini.vim"
  use {
    "ziontee113/icon-picker.nvim",
    config = function()
      require("icon-picker").setup({
        disable_legacy_commands = true
      })
      local opts = { noremap = true, silent = true }
      vim.keymap.set("n", "<Leader><Leader>i", "<cmd>IconPickerNormal<cr>", opts)
      vim.keymap.set("n", "<Leader><Leader>y", "<cmd>IconPickerYank<cr>", opts)
      vim.keymap.set("i", "<Leader>i", "<cmd>IconPickerInsert<cr>", opts)
    end
  }
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
