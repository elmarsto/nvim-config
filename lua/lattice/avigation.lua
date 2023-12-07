local avigation = {}
function avigation.setup(use)
  use {
    "ggandor/leap.nvim",
    -- requires = {
    --   "ggandor/leap-spooky.nvim",
    --   "ggandor/flit.nvim",
    -- },
    after = "vim-repeat",
    config = function()
      -- TODO: fix keybindings not to interfere with surround
      require('leap').add_default_mappings()
      -- require('leap-spooky').setup()
      -- require('flit').setup()
    end
  }
  use { "lukas-reineke/indent-blankline.nvim",
    configure = function()
      require("indent_blankline").setup()
    end
  }
  use "kiyoon/treesitter-indent-object.nvim"
  -- use "tommcdo/vim-ninja-feet"
  use "mbbill/undotree"
  -- use { "nacro90/numb.nvim",
  --   config = function()
  --     require('numb').setup {
  --       show_numbers = true,         -- Enable 'number' for the window while peeking
  --       show_cursorline = true,      -- Enable 'cursorline' for the window while peeking
  --       hide_relativenumbers = true, -- Enable turning off 'relativenumber' for the window while peeking
  --       number_only = false,         -- Peek only when the command is only a number instead of when it starts with a number
  --       centered_peeking = true,     -- Peeked line will be centered relative to window
  --     }
  --   end
  -- }
  use { "stevearc/oil.nvim",
    config = function()
      require "oil".setup({
        columns = {
          "icon"
        },
        view_options = {
          show_hidden = true
        },
        keymaps = {
          ["-"] = "actions.parent",
          ["<C-c>"] = "actions.close",
          ["<C-h>"] = "actions.select_split",
          ["<C-l>"] = "actions.refresh",
          ["<C-p>"] = "actions.preview",
          ["<C-s>"] = "actions.select_vsplit",
          ["<C-t>"] = "actions.select_tab",
          ["<CR>"] = "actions.select",
          ["_"] = "actions.open_cwd",
          ["`"] = "actions.tcd",
          ["~"] = "actions.cd",
          ["g."] = "actions.toggle_hidden",
          ["g?"] = "actions.show_help",
          ["g\\"] = "actions.toggle_trash",
          ["gs"] = "actions.change_sort",
          ["gx"] = "actions.open_external",
          ["y"] = "actions.copy_entry_path",
          ["!"] = "actions.open_terminal",
          [";"] = "actions.open_cmdline",
          ["g:"] = "actions.open_cmdline_dir",
        },
      })
      vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })
    end
  }
end

return avigation
