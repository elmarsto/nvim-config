local other = {}

function other.setup(use)
  use "gbprod/stay-in-place.nvim"
  use "nvim-lua/plenary.nvim"
  use 'jghauser/mkdir.nvim'
  use "jmattaa/regedit.vim"
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
  use {
    "samjwill/nvim-unception", -- used by Rawnly/gist.nvim
    config =
        function()
          vim.g.unception_block_while_host_edits = true
        end
  }
  use {
    "tyru/open-browser.vim",
    config = function()
      -- TODO: move to keyboard.lua
      vim.cmd [[
          " misc mappings
          nnoremap Q @@
          nnoremap gH :execute "OpenBrowser" "https://github.com/" . expand("<cfile>")  <cr>
          nnoremap gN :execute "OpenBrowser" "https://search.nixos.org/packages?query=" . expand("<cfile>")  <cr>

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
end

return other
