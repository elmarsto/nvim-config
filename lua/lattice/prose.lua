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
      -- venn.nvim: enable or disable keymappings
      function _G.Toggle_venn()
        local venn_enabled = vim.inspect(vim.b.venn_enabled)
        if venn_enabled == "nil" then
          vim.b.venn_enabled = true
          vim.cmd [[setlocal ve=all]]
          -- draw a line on HJKL keystokes
          vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", { noremap = true })
          vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", { noremap = true })
          vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", { noremap = true })
          vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", { noremap = true })
          -- draw a box by pressing "f" with visual selection
          vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", { noremap = true })
        else
          vim.cmd [[setlocal ve=]]
          vim.cmd [[mapclear <buffer>]]
          vim.b.venn_enabled = nil
        end
      end

      -- toggle keymappings for venn using <leader>v
      vim.api.nvim_set_keymap('n', '<leader>v', ":lua Toggle_venn()<CR>", { noremap = true })
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
  use { "preservim/vim-textobj-quote",
    after = { "vim-textobj-user" },
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
    after = { "vim-textobj-user" },
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
    after = { "dressing.nvim" },
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
