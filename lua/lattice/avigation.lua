local avigation = {}


function avigation.setup(use)
  -- Lua
  use {
    'abecodes/tabout.nvim',
    config = function()
      require('tabout').setup {
        tabkey = '<Tab>', -- key to trigger tabout, set to an empty string to disable
        backwards_tabkey = '<S-Tab>', -- key to trigger backwards tabout, set to an empty string to disable
        act_as_tab = true, -- shift content if tab out is not possible
        act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
        default_tab = '<C-t>', -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
        default_shift_tab = '<C-d>', -- reverse shift default action,
        enable_backwards = true, -- well ...
        completion = true, -- if the tabkey is used in a completion pum
        tabouts = {
          { open = "'", close = "'" },
          { open = '"', close = '"' },
          { open = '`', close = '`' },
          { open = '(', close = ')' },
          { open = '[', close = ']' },
          { open = '{', close = '}' }
        },
        ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
        exclude = {} -- tabout will ignore these filetypes
      }
    end,
    wants = { 'nvim-treesitter' }, -- or require if not used so far
    after = { 'nvim-cmp' } -- if a completion plugin is using tabs load it before
  }
  use {
    "cbochs/portal.nvim",
    requires = {
      "cbochs/grapple.nvim", -- Optional: provides the "grapple" query item
      "ThePrimeagen/harpoon", -- Optional: provides the "harpoon" query item
    },
  }
  use {
    "ggandor/leap.nvim",
    requires = { "ggandor/flit.nvim" },
    config = function()
      require('leap').add_default_mappings()
      require('flit').setup()
    end
  }
  use "kana/vim-textobj-user"
  use "kana/vim-textobj-line"
  use "mbbill/undotree"
  use {
    "stevearc/aerial.nvim",
    config = function()
      require("aerial").setup(
        {
          on_attach = function(bufnr) -- copypasta https://github.com/stevearc/aerial.nvim
            -- Toggle the aerial window with <leader>a
            vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>a", "<cmd>AerialToggle!<CR>", {})
            -- Jump forwards/backwards with '{' and '}'
            vim.api.nvim_buf_set_keymap(bufnr, "n", "{", "<cmd>AerialPrev<CR>", {})
            vim.api.nvim_buf_set_keymap(bufnr, "n", "}", "<cmd>AerialNext<CR>", {})
            -- Jump up the tree with '[[' or ']]'
            vim.api.nvim_buf_set_keymap(bufnr, "n", "[[", "<cmd>AerialPrevUp<CR>", {})
            vim.api.nvim_buf_set_keymap(bufnr, "n", "]]", "<cmd>AerialNextUp<CR>", {})
          end
        }
      )
    end
  }
end

return avigation
