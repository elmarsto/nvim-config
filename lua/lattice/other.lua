local other = {}

function other.setup(use)
  use {
    "ariel-frischer/bmessages.nvim",
    config = function()
      require("bmessages").setup({})
    end
  }
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
      vim.keymap.set({ "n", "x" }, "<leader>/", function() require("ssr").open() end)
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
    'notomo/cmdbuf.nvim',
    config = function()
      vim.keymap.set("n", "q:", function()
        require("cmdbuf").split_open(vim.o.cmdwinheight)
      end)
      vim.keymap.set("c", "<C-f>", function()
        require("cmdbuf").split_open(vim.o.cmdwinheight, { line = vim.fn.getcmdline(), column = vim.fn.getcmdpos() })
        vim.api.nvim_feedkeys(vim.keycode("<C-c>"), "n", true)
      end)

      -- Custom buffer mappings
      vim.api.nvim_create_autocmd({ "User" }, {
        group = vim.api.nvim_create_augroup("cmdbuf_setting", {}),
        pattern = { "CmdbufNew" },
        callback = function(args)
          vim.bo.bufhidden = "wipe" -- if you don't need previous opened buffer state
          vim.keymap.set("n", "q", [[<Cmd>quit<CR>]], { nowait = true, buffer = true })
          vim.keymap.set("n", "dd", [[<Cmd>lua require('cmdbuf').delete()<CR>]], { buffer = true })

          -- you can filter buffer lines
          local lines = vim.tbl_filter(function(line)
            return line ~= "q"
          end, vim.api.nvim_buf_get_lines(args.buf, 0, -1, false))
          vim.api.nvim_buf_set_lines(args.buf, 0, -1, false, lines)
        end,
      })

      -- open lua command-line window
      vim.keymap.set("n", "ql", function()
        require("cmdbuf").split_open(vim.o.cmdwinheight, { type = "lua/cmd" })
      end)

      -- q/, q? alternative
      vim.keymap.set("n", "q/", function()
        require("cmdbuf").split_open(vim.o.cmdwinheight, { type = "vim/search/forward" })
      end)
      vim.keymap.set("n", "q?", function()
        require("cmdbuf").split_open(vim.o.cmdwinheight, { type = "vim/search/backward" })
      end)
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

  use {
    "smjonas/live-command.nvim",
    config = function()
      require("live-command").setup {
        commands = {
          Norm = { cmd = "norm" },
        },
      }
    end
  }
  use 'subnut/nvim-ghost.nvim'
  use { 'tversteeg/registers.nvim', config = function()
    require('registers').setup()
  end }
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
