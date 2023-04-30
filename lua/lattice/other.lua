local other = {}

function other.setup(use)
  use "gbprod/stay-in-place.nvim"
  use "nvim-lua/plenary.nvim"
  use "famiu/bufdelete.nvim"
  use({
    "olimorris/persisted.nvim",
    --module = "persisted", -- For lazy loading
    config = function()
      require("persisted").setup()
      require("telescope").load_extension("persisted") -- To load the telescope extension
    end,
  })
  use "samjwill/nvim-unception"
  use "tpope/vim-repeat"
  use {
    "tyru/open-browser.vim",
    config = function()
      vim.cmd [[
          " misc mappings
          nnoremap Q @@
          nnoremap gH :execute "OpenBrowser" "https://github.com/" . expand("<cfile>")  <cr>
          nnoremap gN :execute "OpenBrowser" "https://search.nixos.org/packages?query=" . expand("<cfile>")  <cr>
          nnoremap gFs :execute "OpenBrowser" "https://flathub.org/apps/search/" . expand("<cfile>")  <cr>
          nnoremap gFd :execute "OpenBrowser" "https://flathub.org/apps/details/" . expand("<cfile>")  <cr>
          nnoremap gX :silent :execute "!xdg-open" expand('%:p:h') . "/" . expand("<cfile>") " &"<cr>

          " Paste-mode shenanigans
          function! TogglePaste()
              if(&paste == 0)
                  set paste
                  echo "Paste Mode Enabled"
              else
                  set nopaste
                  echo "Paste Mode Disabled"
              endif
          endfunction
          map <leader>p :call TogglePaste()<cr>

      ]]
    end
  }
  use {
    'stevearc/resession.nvim',
    config = function()
      local resession = require 'resession'
      resession.setup({ extensions = { grapple = {} } })
      vim.keymap.set('n', '<leader>ss', resession.save)
      vim.keymap.set('n', '<leader>sl', resession.load)
      vim.keymap.set('n', '<leader>sd', resession.delete)
    end
  }
end

return other
