local keyboard = {}

function keyboard.setup(use)
  use {
    "b0o/mapx.nvim",
    config = function()
      require 'mapx'.setup { global = "force" }
    end
  }
  use {
    "mrjones2014/legendary.nvim",
    requires = { "kkarji/sqlite.lua", "stevearc/dressing.nvim", "b00/mapx.nvim" },
    config = function()
      require('dressing').setup({
        select = {
          get_config = function(opts)
            if opts.kind == 'legendary.nvim' then
              return {
                telescope = {
                  sorter = require('telescope.sorters').fuzzy_with_index_bias({})
                }
              }
            else
              return {}
            end
          end
        }
      })
      require("legendary").setup(
        {
          keymaps = {
            -- Legends, keymaps on spacebar
            { "<C-Space>", ":Legendary<cr>", description = "Legendary (Meta!)" },
            { "<leader><C-Space>", ":Telescope keymap<cr>", description = "Telescope Keymap" },

            -- Registers, Marks
            { "<M-\">", ":Telescope registers<cr>", description = "Registers" },
            { "<M-\'>", ":Telescope marks<cr>", description = "Marks" },

            -- Movements between files and on the jumplist is on the RHS pinkie cluster
            { "<M-,>", ":Telescope git_files<cr>", description = "Git Files" },
            { "<M-.>", ":Telescope find_files<cr>", description = "Find Files" },

            -- Search on /
            { "<M-/>", ":Telescope live_grep<cr>", description = "Live Grep" },
            { "<leader>/", ":Telescope current_buffer_fuzzy_find<cr>", "Fuzzy find current buffer" },
            -- jumplist is on semicolon
            { ";", ":Telescope jumplist<cr>", description = "Jumplist" },

            -- Registers, Marks also nearby, and mnemonic the quote keys appropriate for both
            { "<M-\">", ":Telescope registers<cr>", description = "Registers" },
            { "<M-\'>", ":Telescope marks<cr>", description = "Marks" },

            -- Tmux-alike window controls
            { '<C-W>"', ":sp<cr>", description = "Split along X axis" },
            { '<C-W>%', ":vs<cr>", description = "Split along Y axis" },

            -- Meta arrows do nav between tabs
            { "<M-Down>", ":tablast<cr>", description = "Last Tab" },
            { "<M-Left>", ":tabprev<cr>", description = "Prev Tab" },
            { "<M-Right>", ":tabnext<cr>", description = "Next Tab" },
            { "<M-Up>", ":tabfirst<cr>", description = "First Tab" },

            -- Help is on F1
            { "<F1>", ":Telescope help_tags", description = "Telescope Help Tags" },
            { "<S-F1>", ":Telescope man_pages", description = "Telescope Man Pages" },

            -- Buffer, tab, session, window mgmt on F2
            { "<F2>", ":Telescope buffers<cr>", description = "Telescope Buffers" },
            { "<S-F2>", ":Telescope windows<cr>", description = "Telescope Windows" },
            { "<C-F2>", ":Telescope tabs<cr>", description = "Telescope Tabs" },
            { "<leader><F2>", ":Telescope sessions<cr>", description = "Telescope Sessions" },
            { "<leader><S-F2>", ":Telescope projects<cr>", description = "Telescope Projects" },

            -- Undo on F3
            { "<F3>", ":Telescope undo<cr>", description = "Undo" },
            { "<S-F3>", ":UndotreeToggle<cr>", description = "UndoTree" },

            -- Vim Stuff on F4
            { "<F4>", ":Telescope commands<cr>", description = "Vim Commands" },
            { "<S-F4>", ":Telescope builtins<cr>", description = "Vim Builtins" },
            { "<C-F4>", ":Telescope vim_options<cr>", description = "Vim Options" },
            { "<leader><F4>", ":Telescope autocommands<cr>", description = "Vim Autocommands" },

            -- Clipboard & Action history on F5
            { "<F5>", ":Telescope neoclip", description = "Clipboard History" },
            { "<S-F5>", ":Telescope command_history", description = "Command History" },
            { "<C-F5>", ":Telescope search_history", description = "Search History" },

            -- Git integration on F6
            { "<F6>", ":Telescope git_status", description = "Git Status" },
            { "<S-F6>", ":Telescope git_bcommits", description = "Git Buffer Commits" },
            { "<C-F6>", ":Telescope git_commits", description = "Git Commits" },
            { "<leader><F6>", ":Telescope git_branches", description = "Git Branches" },
            { "<leader><C-F6>", ":Telescope git_stash", description = "Git Stash" },

            --- Quickfix on F7
            { "<F7>", ":Telescope quickfix", description = "Quickfix" },
            { "<S-F7>", ":Telescope quickfixhistory", description = "Quickfix History" },
            { "<C-F7>", ":Telescope loclist", description = "Loclist" },

            --- LSP Part A. Symbols on F8. (Trhows in Treesitter as well)
            { "<F8>", ":Telescope lsp_document_symbols", description = "LSP Document Symbols" },
            { "<C-F8>", ":Telescope lsp_dynamic_workspace_symbols", description = "LSP Dynamic Workspace Symbols" },
            { "<S-F8>", ":Telescope lsp_workspace_symbols", description = "LSP Workspace Symbols" },
            { "<leader><F8>", ":Telescope treesitter<cr>", description = "Treesitter" },
            -- LSP part B, definitions, refeerences, implementations on F9
            { "<F9>", ":Telescope lsp_definitions", description = "LSP Definitions" },
            { "<S-F9>", ":Telescope lsp_references", description = "LSP References" },
            { "<C-F9>", ":Telescope lsp_implementations", description = "LSP Implementations" },
            { "<leader><F9>", ":Telescope lsp_type_definitions", description = "LSP Type Definitions" },
            { "<leader><C-F9>", ":Telescope lsp_incoming_calls", description = "LSP Incoming Calls" },
            { "<leader><S-F9>", ":Telescope lsp_outgoing_calls", description = "LSP Outgoing Calls" },
            -- LSP part C, diagnostics, on F10
            { "<F10>", ":Telescope diagnostics<cr>", description = "Diagnostics" },
            { "<S-10>", ":Trouble<cr>", description = "Trouble" },

            -- Digraphs and emojis are on F11
            { "<F11>",
              function()
                require 'telescope.builtin'.symbols { sources = { "emoji" } }
              end,
              description = "Telescope Emojis"
            },
            { "<F12>", ":Telescope", description = "Telescope alone" },
            { "<leader><Tab>", ":Telescope frecency", description = "Telescope frecency" },
            { "<leader>z", ":Telescope zoxide list", description = "Telescope zoxide" }

          },
          commands = {},
          funcs = {},
          autocmds = {},
        })
    end
  }
end

return keyboard
