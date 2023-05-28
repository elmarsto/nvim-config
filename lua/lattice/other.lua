local other = {}

function other.setup(use)
  use "gbprod/stay-in-place.nvim"
  use "nvim-lua/plenary.nvim"
  use { "famiu/bufdelete.nvim",
    config = function()
      -- TODO: move to keyboard.lua
      vim.cmd [[
        nnoremap <silent> <leader>bd :Bdelete<CR>
        nnoremap <silent> <leader>bw :Bwipeout<CR>
      ]]
    end
  }
  use({
    "olimorris/persisted.nvim",
    -- module = "persisted", -- For lazy loading
    config = function()
      require("persisted").setup({
        autoload = true,
        use_git_branch = true,
        follow_cwd = false,
      })
      require("telescope").load_extension("persisted") -- To load the telescope extension
    end,
  })
  use "samjwill/nvim-unception"
  use {
    "tyru/open-browser.vim",
    config = function()
      -- TODO: move to keyboard.lua
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
    "chrisgrieser/nvim-various-textobjs",
    config = function()
      require("various-textobjs").setup({
        -- treesitter-textobjects provides better solutions to the following
        disabledKeymaps = {
          '%',                    -- already provided
          'iv', 'av', 'ik', 'ak', -- about key/value pairs; not language-sensitive AFAICT. JSON?
          'im',
          'am',                   -- conflicts with treesitter? I think? Anyways not sure what 'chainMember' is, sounds language specific
          'ic', 'ac',             -- css-specific
          'ix', 'ax',             -- html-specific
          'i/', 'a/',             -- js-specific
        }
      })
    end
  }
end

return other
