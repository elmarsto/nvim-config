local keyboard = {}

function keyboard.setup(use)
  use {
    "b0o/mapx.nvim",
    config = function()
      require 'mapx'.setup { global = "force", whichkey = true }
    end
  }
  use "folke/which-key.nvim"
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
            { "<C-P>", ":Legendary<cr>", description = "Legendary (Meta!)" },
            { "<leader>te",
              function()
                require 'telescope.builtin'.symbols { sources = { "emoji" } }
              end,
              description = "Emojis"
            },
            { "<C-Space>", ":WhichKey<cr>", description = "WhichKey" },
            { "<M-Left>", ":tabprev<cr>", description = "Prev Tab" },
            { "<M-Right>", ":tabnext<cr>", description = "Next Tab" },
            { "<M-Down>", ":tablast<cr>", description = "Last Tab" },
            { "<M-Up>", ":tabfirst<cr>", description = "First Tab" },
            { "<M-/>", ":Telescope live_grep<cr>", description = "Live Grep" },
            { "<M-?>", ":Telescope search_history<cr>", description = "Search History" },
            { "<M-;>", ":Telescope command_history<cr>", description = "Command History" },
            { "<M-,>", ":Telescope vim_options<cr>", description = "Vim Options" },
            { "<M-.>", ":Telescope commands<cr>", description = "Telescope Commands" },
            { "<leader>,", ":Telescope loclist<cr>", description = "Telescope Loclist" },
            { "<leader>z", ":Telescope current_buffer_fuzzy_find<cr>",
              description = "Telescope Current Buffer Fuzzy Find" },
            { "<M-CR>", ":Telescope find_files<cr>", description = "Telescope Git_Files" },
            { "<leader><CR>", ":Telescope git_files<cr>", description = "Git Files" },
            { "<leader><leader><CR>", ":Telescope git_branches<cr>", description = "Git Branches" },
            { "<C-M>", ":Telescope find_files<cr>", description = "Git Files" },
            { "<leader><Space>", ":Trouble<cr>", description = "Trouble" },
            { "<F3>", ":UndotreeToggle<cr>", description = "UndoTree" },
            { "<leader>jrf", require 'jester'.run_last, description = "Jester Run File" },
            { "<leader>jra", require 'jester'.run_last, description = "Jester Run Again" },
            { "<leader>jrA", require 'jester'.run, description = "Jester Run All" },
            { "<leader>tgf", ":Telescope git_files<cr>", description = "Telescope Git Files" },
            { "<leader>tgbc", ":Telescope git_bcommits<cr>", description = "Telescope Git BCommits" },
            { "<leader>tgc", ":Telescope git_commits<cr>", description = "Telescope Git Commits" },
            { "<leader>tR", ":Telescope reloader<cr>", description = "Telescope Reloader" },
            { "<leader>tgb", ":Telescope git_branches<cr>", description = "Telescope Git Branches" },
            { "<leader>tgf", ":Telescope git_files<cr>", description = "Telescope Git Files" },
            { "<leader>tld", ":Telescope lsp_definitions<cr>", description = "Telescope LSP Definitions" },
            { "<leader>tli", ":Telescope lsp_implementations<cr>", description = "Telescope LSP Implementations" },
            { "<leader>tlca", ":Telescope lsp_code_actions<cr>", description = "Telescope LSP Code Actions" },
            { "<leader>tlic", ":Telescope lsp_incoming_calls<cr>", description = "Telescope LSP Incoming Calls" },
            { "<leader>tloc", ":Telescope lsp_outgoing_calls<cr>", description = "Telescope LSP Outgoing Calls" },
            { "<leader>tlr", ":Telescope lsp_references<cr>", description = "Telescope LSP References " },
            { "<leader>tltd", ":Telescope lsp_type_definitions<cr>", description = "Telescope LSP Type Definitions" },
            { "<leader>tj", ":Telescope jumplist<cr>", description = "Telescope Jumplist" },
            { "<leader>tf", ":Telescope frecency<cr>", description = "Telescope Frecency" },
            { "<leader>tk", ":Telescope keymaps<cr>", description = "Telescope Keymaps" },
            { "<leader>tr", ":Telescope registers<cr>", description = "Telescope Registers" },
            { "<leader>tm", ":Telescope marks<cr>", description = "Telescope Marks" },
            { "<leader>tp", ":Telescope projects<cr>", description = "Telescope Projects" },
            { "<leader>tq", ":Telescope quickfix<cr>", description = "Telescope Quickfix" },
            { "<C-tab>", ":Telescope buffers<cr>", description = "Telescope Buffers" },
            {
              "<leader>tldws",
              ":Telescope lsp_dynamic_workspace_symbols<cr>",
              description = "Telescope LSP Dynamic Workspace Symbols"
            },
            {
              "<leader>tlws",
              ":Telescope lsp_workspace_symbols<cr>",
              description = "Telescope LSP Workspace Symbols"
            },
            {
              "<leader>tlds",
              ":Telescope lsp_document_symbols<cr>",
              description = "Telescope LSP Document Symbols"
            },
            { "<leader>mc", ":Code<cr>", description = "Mode Code" },
            { "<leader>mh", ":Human<cr>", description = "Mode Human" },
            { "<leader>mp", ":Prose<cr>", description = "Mode Prose" },
            { "<leader>mv", ":Verse<cr>", description = "Mode Verse" },
            { "<leader>mb", ":Boethius<cr>", description = "Mode Boethius" },
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
