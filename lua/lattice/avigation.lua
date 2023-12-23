local avigation = {}
function avigation.setup(use)
  use {
    "chrisgrieser/nvim-origami",
    config = function()
      require("origami").setup({}) -- setup call needed
    end,
  }
  use {
    "chentoast/marks.nvim", config = function()
    require 'marks'.setup {
      -- whether to map keybinds or not. default true
      default_mappings = true,
      -- which builtin marks to show. default {}
      builtin_marks = { ".", "<", ">", "^" },
      -- whether movements cycle back to the beginning/end of buffer. default true
      cyclic = true,
      -- whether the shada file is updated after modifying uppercase marks. default false
      force_write_shada = false,
      -- how often (in ms) to redraw signs/recompute mark positions.
      -- higher values will have better performance but may cause visual lag,
      -- while lower values may cause performance penalties. default 150.
      refresh_interval = 250,
      -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
      -- marks, and bookmarks.
      -- can be either a table with all/none of the keys, or a single number, in which case
      -- the priority applies to all marks.
      -- default 10.
      sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
      -- disables mark tracking for specific filetypes. default {}
      excluded_filetypes = {},
      -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
      -- sign/virttext. Bookmarks can be used to group together positions and quickly move
      -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
      -- default virt_text is "".
      bookmark_0 = {
        sign = "⚑",
        virt_text = "hello world",
        -- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
        -- defaults to false.
        annotate = false,
      },
      mappings = {}
    }
  end
  }
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
          ['<C-">'] = "actions.select_split",
          ["<C-l>"] = "actions.refresh",
          ["<C-p>"] = "actions.preview",
          ["<C-%>"] = "actions.select_vsplit",
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
