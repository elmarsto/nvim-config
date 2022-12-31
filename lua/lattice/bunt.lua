local bunt = {}

function bunt.setup(use)
  use {
    "edluffy/specs.nvim",
    config = function()
      require "specs".setup {
        show_jumps = true,
        min_jump = 30,
        popup = {
          delay_ms = 0, -- delay before popup displays
          inc_ms = 10, -- time increments used for fade/resize effects
          blend = 10, -- starting blend, between 0-100 (fully transparent), see :h winblend
          width = 10,
          winhl = "PMenu",
          fader = require("specs").linear_fader,
          resizer = require("specs").shrink_resizer
        },
        ignore_filetypes = {},
        ignore_buftypes = {
          nofile = true
        }
      }
    end
  }
  use {
    "folke/todo-comments.nvim",
    config = function()
      require("todo-comments").setup {
        signs = true, -- show icons in the signs column
        keywords = {
          DONE = { icon = " ", color = "success" },
          TODO = { icon = "⭕", color = "warning" },
          IDEA = { icon = "💡", color = "idea" },
          RND = { icon = "🧪", color = "idea" },
          FIXME = { color = "error" }, -- default ladybug emoji
          BUG = { color = "error" }, -- default ladybug emoji
          WARNING = { icon = "⚠️", color = "warning" },
          WARN = { icon = "⚠️", color = "warning" },
          YIKES = { icon = "💢", color = "warning" },
          CONTEXT = { icon = "🌐", color = "info" },
          CHALLENGE = { icon = "👊", color = "default" },
          PITCH = { icon = "✍️", color = "default" },
          FIX = { icon = "⚕️", color = "success" }, -- default ladybug emoji
          FEAT = { icon = "🏆", color = "success" }, -- default ladybug emoji
          NOTE = { color = "info" }
        },
        merge_keywords = true, -- when true, custom keywords will be merged with the defaults
        colors = {
          idea = { "IdeaMsg", "#FDFF74" },
          success = { "SuccessMsg", "#10B981" },
          error = { "LspDiagnosticsDefaultError", "ErrorMsg", "#DC2626" },
          warning = { "LspDiagnosticsDefaultWarning", "WarningMsg", "#FBBF24" },
          info = { "LspDiagnosticsDefaultInformation", "#2563EB" },
          hint = { "LspDiagnosticsDefaultHint", "#10B981" },
          default = { "Identifier", "#7C3AED" }
        }
      }
    end
  }
  use "folke/twilight.nvim"
  use { 'gen740/SmoothCursor.nvim',
    config = function()
      require('smoothcursor').setup()
    end
  }
  use {
    "glepnir/zephyr-nvim",
    requires = { 'nvim-treesitter/nvim-treesitter', opt = true },
    config = function()
      vim.cmd [[
        colorscheme zephyr
      ]]
    end
  }
  use { "kyazdani42/nvim-web-devicons" }
  use {
    "karb94/neoscroll.nvim",
    config = function()
      require("neoscroll").setup(
        {
          mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
          easing_function = "quadratic" -- Default easing function
        }
      )
    end
  }
  use "MunifTanjim/nui.nvim"
  use {
    "nvim-lualine/lualine.nvim",
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      require 'lualine'.setup {
        options = {
          theme = "everforest"
        }
      }
    end
  }
  use "nvim-lua/popup.nvim"
  use {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require "colorizer".setup()
    end
  }
  use {
    "rcarriga/nvim-notify",
    config = function()
      vim.notify = require("notify")
    end
  }
  use {
    "sindrets/winshift.nvim",
    config = function()
      -- Lua
      require("winshift").setup({
        highlight_moving_win = true, -- Highlight the window being moved
        focused_hl_group = "Visual", -- The highlight group used for the moving window
        moving_win_options = {
          -- These are local options applied to the moving window while it's
          -- being moved. They are unset when you leave Win-Move mode.
          wrap = false,
          cursorline = false,
          cursorcolumn = false,
          colorcolumn = "",
        },
        keymaps = {
          disable_defaults = false, -- Disable the default keymaps
          win_move_mode = {
            ["h"] = "left",
            ["j"] = "down",
            ["k"] = "up",
            ["l"] = "right",
            ["H"] = "far_left",
            ["J"] = "far_down",
            ["K"] = "far_up",
            ["L"] = "far_right",
            ["<left>"] = "left",
            ["<down>"] = "down",
            ["<up>"] = "up",
            ["<right>"] = "right",
            ["<S-left>"] = "far_left",
            ["<S-down>"] = "far_down",
            ["<S-up>"] = "far_up",
            ["<S-right>"] = "far_right",
          },
        },
        window_picker = function()
          return require("winshift.lib").pick_window({
            picker_chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
            filter_rules = {
              cur_win = true, -- Filter out the current window
              floats = true, -- Filter out floating windows
              filetype = {}, -- List of ignored file types
              buftype = {}, -- List of ignored buftypes
              bufname = {}, -- List of vim regex patterns matching ignored buffer names
            },
          })
        end,
      })
    end
  }
end

return bunt
