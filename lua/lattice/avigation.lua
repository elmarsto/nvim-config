local avigation = {}

function avigation.setup(use)
  use "kana/vim-textobj-user"
  use "kana/vim-textobj-line"
  use "mbbill/undotree"
  use {
    "phaazon/hop.nvim",
    branch = "v2",
    as = "hop",
    config = function()
      local hop = require("hop")
      hop.setup { keys = "etovxqpdygfblzhckisuran" }
      local directions = require("hop.hint").HintDirection
      vim.keymap.set(
        "",
        "f",
        function()
          hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
        end,
        { remap = true }
      )
      vim.keymap.set(
        "",
        "F",
        function()
          hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
        end,
        { remap = true }
      )
      vim.keymap.set(
        "",
        "t",
        function()
          hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
        end,
        { remap = true }
      )
      vim.keymap.set(
        "",
        "T",
        function()
          hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
        end,
        { remap = true }
      )
    end
  }
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
