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
    "simrat39/symbols-outline.nvim",
    config = function()
      require("symbols-outline").setup()
    end
  }
end

return bunt
