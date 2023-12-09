local bunt = {}

function bunt.setup(use)
  use "MunifTanjim/nui.nvim"
  use "amadeus/vim-convert-color-to"
  use {
    "edluffy/specs.nvim",
    config = function()
      require "specs".setup {
        show_jumps = true,
        min_jump = 30,
        popup = {
          delay_ms = 0, -- delay before popup displays
          inc_ms = 10,  -- time increments used for fade/resize effects
          blend = 10,   -- starting blend, between 0-100 (fully transparent), see :h winblend
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
        signs = true,          -- show icons in the signs column
        merge_keywords = true, -- when true, custom keywords will be merged with the defaults
        keywords = {
          BECAUSE = { icon = "∵", color = "argumentation" },
          BUG = { color = "error" }, -- default ladybug emoji
          CHALLENGE = { icon = "🏆", color = "actionItem" },
          CONTEXT = { icon = "❄", color = "info" },
          CONCLUSION = { icon = "∴", color = "default" },
          DEF = { icon = "∆", color = "info" },
          DEFINITION = { icon = "∆", color = "info" },
          EXPLANATION = { icon = "∵", color = "argumentation" },
          FIXME = { color = "error" }, -- default ladybug emoji
          IDEA = { icon = "☀", color = "idea" },
          JUSTIFICATION = { icon = "∵", color = "argumentation" },
          LOOKUP = { icon = "⚯", color = "actionItem" },
          NOMENCLATURE = { icon = "∆", color = "info" },
          NOTE = { icon = "❦", color = "info" },
          PITCH = { icon = "♮", color = "argumentation" },
          PROMISE = { icon = "✪", color = "actionItem" },
          REASON = { icon = "∵", color = "argumentation" },
          RESEARCH = { icon = "⚗", color = "actionItem" },
          SECTION = { icon = "§", color = "info" },
          TODO = { icon = "★", color = "actionItem" },
          THEREFORE = { icon = "∴", color = "argumentation" },
          QED = { icon = "∴", color = "argumentation" },
          WARN = { icon = "⚠️", color = "warning" },
          WARNING = { icon = "⚠️", color = "warning" },
          WORRY = { icon = "⌇", color = "warning" },
          YIKES = { icon = "⁉", color = "error" }
        },
        colors = {
          actionItem = { "ActionItem", "#A0CC00" },
          argumentation = { "Argument", "#8C268C" },
          default = { "Identifier", "#999999" },
          error = { "LspDiagnosticsDefaultError", "ErrorMsg", "#DC2626" },
          idea = { "IdeaMsg", "#FDFF74" },
          info = { "LspDiagnosticsDefaultInformation", "#2563EB" },
          warning = { "LspDiagnosticsDefaultWarning", "WarningMsg", "#FB8F24" },
        }
      }
    end
  }
  use { 'gen740/SmoothCursor.nvim',
    config = function()
      require('smoothcursor').setup()
    end
  }
  use {
    "ray-x/aurora",
    config = function()
      vim.cmd [[
        set termguicolors
        let g:aurora_italic = 1
        let g:aurora_transparent = 1
        let g:aurora_bold = 1
        let g:aurora_darker = 1

        colorscheme aurora

        " " customize your own highlight
        " hi Normal guibg=NONE ctermbg=NONE "remove background
        " hi String guibg=#339922 ctermbg=NONE "remove background

        " " customize your own highlight with lua
        " lua <<EOF
        "   vim.api.nvim_set_hl(0, '@string', {fg='#59E343'})
        "   vim.api.nvim_set_hl(0, '@field', {fg='#f93393'})
        "   vim.api.nvim_set_hl(0, '@number', {fg='#e933e3'})
        " EOF
      ]]
    end
  }
  use "kyazdani42/nvim-web-devicons"
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
    "mrjones2014/smart-splits.nvim",
    config = function()
      require("smart-splits").setup()
    end
  }
  use {
    "nvim-lualine/lualine.nvim",
    after = 'nvim-web-devicons',
    config = function()
      require("lualine").setup({
        options = {
          theme = "everforest"
        },
        sections = {
          lualine_b = {
            'vim.loop.cwd()',
            'branch',
            'diff',
            'diagnostics',
          },
          lualine_c = { {
            'filename',
            file_status = true,
            newfile_status = true,
            path = 1,
            shorting_target = 40,
            symbols = {
              modified = '⊙',
              readonly = '⊘',
              unnamed = '⊚',
              newfile = '⊛',
            }
          } },
          lualine_y = {
            "progress",
          },
          lualine_z = {
            "location",
            function()
              return tostring(vim.fn.wordcount().words)
            end,
          }
        }
      })
    end
  }
  use {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require "colorizer".setup()
    end
  }
  use {
    "onsails/lspkind.nvim",
    config = function()
      require('lspkind').init({
        preset = 'default'
      })
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
      require("winshift").setup({
        highlight_moving_win = true,
        focused_hl_group = "Visual",
        moving_win_options = {
          wrap = false,
          cursorline = false,
          cursorcolumn = false,
          colorcolumn = "",
        },
        keymaps = {
          disable_defaults = false,
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
              floats = true,  -- Filter out floating windows
              filetype = {},  -- List of ignored file types
              buftype = {},   -- List of ignored buftypes
              bufname = {},   -- List of vim regex patterns matching ignored buffer names
            },
          })
        end,
      })
    end
  }
  use {
    "petertriho/nvim-scrollbar",
    config = function()
      require("scrollbar").setup()
    end
  }
  use {
    "stevearc/dressing.nvim",
    after = { "telescope.nvim", "nui.nvim" },
  }
end

return bunt
