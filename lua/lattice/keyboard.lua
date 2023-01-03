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
            { "<C-Space>", ":Legendary<cr>", description = "Legendary (Meta!)" },
            { "<leader><C-Space>", ":Telescope keymap<cr>", description = "Telescope Keymap" },
            { "<leader>e",
              function()
                require 'telescope.builtin'.symbols { sources = { "emoji" } }
              end,
              description = "Emojis"
            },
            description = "Telescope Current Buffer Fuzzy Find"
          },
          -- meta is on CR
          { "<C-CR>", ":Telescope<cr>", description = "Telescope Telescope" },
          { "<CR>", ":Telescope <tab>", description = "Telescope" },
          -- help is on F1
          { "<F1>", ":Telescope help_tags", description = "Telescope Help Tags" },
          { "<S-F1>", ":Telescope man_pages", description = "Telescope Man Pages" },
          -- buffer, tab, window mgmt on F2 (TODO)
          { "<F2>", ":Telescope buffers<cr>", description = "Buffers" },
          { "<S-F2>", ":Telescope tagstack<cr>", description = "Tagstack" },
          { "<S-F2>", ":Telescope tagstack<cr>", description = "Tagstack" },
          -- undo on F3
          { "<F3>", ":Telescope undo<cr>", description = "Undo" },
          { "<S-F3>", ":UndotreeToggle<cr>", description = "UndoTree" },
          -- Diagnostics on F4
          { "<F4>", ":Telescope diagnostics<cr>", description = "Diagnostics" },
          { "<S-F4>", ":Trouble<cr>", description = "Trouble" },
          -- Actions on F5
          { "<F5>", ":Telescope commands<cr>", description = "Commands" },
          { "<S-F5>", ":Telescope builtins<cr>", description = "Builtins" },
          { "<C-F5>", ":Telescope vim_options<cr>", description = "Vim Options" },
          { "<leader><F5>", ":Telescope nodescripts<cr>", description = "Vim Options" },

          -- History on F6
          { "<F6>", ":Telescope command_history", description = "Command History" },
          { "<C-F6>", ":Telescope quickfix_history", description = "Search History" },
          { "<S-F6>", ":Telescope search_history", description = "Search History" },
          --- Lists of locations on F7
          { "<F7>", ":Telescope jumplist", description = "Jumplist" },
          { "<C-F7>", ":Telescope quickfix", description = "Jumplist" },
          { "<S-F7>", ":Telescope loclist", description = "Jumplist" },
          --- Symbols on F8
          { "<F8>", ":Telescope lsp_document_symbols", description = "LSP Document Symbols" },
          { "<C-F8>", ":Telescope lsp_dynamic_workspace_symbols", description = "LSP Dynamic Workspace Symbols" },
          { "<S-F8>", ":Telescope lsp_workspace_symbols", description = "LSP Workspace Symbols" },
          -- non-LSP symbols on F8 but after leader
          { "<leader><F8>", ":Telescope treesitter<cr>", description = "Treesitter" },
          { "<leader><S-F8>", ":Telescope symbols<cr>", description = "Symbols" },
          { "<leader><C-F8>", ":Telescope tags<cr>", description = "CTags" },
          -- definitions, refeerences, implementations on F9
          { "<F9>", ":Telescope lsp_definitions", description = "LSP Definitions" },
          { "<S-F9>", ":Telescope lsp_references", description = "LSP References" },
          { "<C-F9>", ":Telescope lsp_implementations", description = "LSP Implementations" },
          { "<leader><F9>", ":Telescope lsp_type_definitions", description = "LSP Type Definitions" },
          { "<leader><C-F9>", ":Telescope lsp_incoming_calls", description = "LSP Incoming Calls" },
          { "<leader><S-F9>", ":Telescope lsp_outgoing_calls", description = "LSP Outgoing Calls" },
          -- git on F10
          { "<F10>", ":Telescope git_status", description = "Git Status" },
          { "<S-F10>", ":Telescope git_commits", description = "Git Commits" },
          { "<C-F10>", ":Telescope git_bcommits", description = "Git BCommits" },
          { "<leader><F10>", ":Telescope git_branches", description = "Git Branches" },
          { "<leader><C-F10>", ":Telescope git_stash", description = "Git Stash" },
          { "<leader><S-F10>", ":Telescope git_status", description = "Git Status" },


          { "<M-,>", ":Telescope git_files<cr>", description = "Git Files" },
          { "<M-.>", ":Telescope find_files<cr>", description = "Find Files" },
          { "<M-/>", ":Telescope live_grep<cr>", description = "Live Grep" },
          { "<M-Down>", ":tablast<cr>", description = "Last Tab" },
          { "<M-Left>", ":tabprev<cr>", description = "Prev Tab" },
          { "<M-Right>", ":tabnext<cr>", description = "Next Tab" },
          { "<M-Up>", ":tabfirst<cr>", description = "First Tab" },
          { "<M-\">", ":Telescope registers<cr>", description = "Registers" },
          { "<M-\'>", ":Telescope marks<cr>", description = "Marks" },
          { "<M-lt>", ":Telescope git_branches<cr>", description = "Git Branches" },
          { "<leader>z", ":Telescope current_buffer_fuzzy_find<cr>",
            { '<C-W>"', ":sp<cr>", description = "Split along X axis" },
            { '<C-W>%', ":vs<cr>", description = "Split along Y axis" },
          },
          commands = {},
          funcs = {},
          autocmds = {},
        })
    end
  }
end

return keyboard
