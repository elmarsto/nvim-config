local other = {}

function other.setup(use)
  use {
    "cshuaimin/ssr.nvim",
    module = "ssr",
    -- Calling setup is optional.
    config = function()
      require("ssr").setup {
        border = "rounded",
        min_width = 50,
        min_height = 5,
        max_width = 120,
        max_height = 25,
        adjust_window = true,
        keymaps = {
          close = "q",
          next_match = "n",
          prev_match = "N",
          replace_confirm = "<cr>",
          replace_all = "<leader><cr>",
        },
      }
      vim.keymap.set({ "n", "x" }, "<leader>sr", function() require("ssr").open() end)
    end
  }
  use "gbprod/stay-in-place.nvim"
  use {
    'gsuuon/tshjkl.nvim',
    config = function()
      require('tshjkl').setup({
        keymaps = {
          toggle = '<leader>N',
        }
      })
    end
  }
  use "nvim-lua/plenary.nvim"
  use 'jghauser/mkdir.nvim'
  use "jmattaa/regedit.vim"
  use({
    "nat-418/boole.nvim",
    config = function()
      require('boole').setup({
        mappings = {
          increment = '<C-a>',
          decrement = '<C-x>'
        },
        -- User defined loops
        additions = {
          { 'Foo', 'Bar' },
          { 'tic', 'tac', 'toe' }
        },
        allow_caps_additions = {
          { 'enable', 'disable' }
          -- enable → disable
          -- Enable → Disable
          -- ENABLE → DISABLE
        }
      })
    end
  })
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
  use { "TobinPalmer/Tip.nvim",
    config = function()
      require("tip").setup({ seconds = 2, title = "󰓠", url = "https://vtip.43z.one" })
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
