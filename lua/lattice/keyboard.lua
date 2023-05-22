local keyboard = {}

function keyboard.setup(use)
  use {
    "mrjones2014/legendary.nvim",
    after = "sqlite.lua",
    config = function()
      require("legendary").setup(
        {
          keymaps = {
            -- Legends, keymaps on spacebar
            { "<C-Space>",         ":Legendary<cr>",                              description = "Legendary (Meta!)" },
            { "<leader><C-Space>", ":Telescope keymaps<cr>",                      description = "Telescope Keymap" },

            -- Registers, Marks
            { "<M-\">",            ":Telescope registers theme=cursor<cr>",       description = "Registers" },
            { "<M-\'>",            ":Telescope marks<cr>",                        description = "Marks" },

            -- Movements between files and on the jumplist is on the RHS pinkie cluster
            { "<M-,>",             ":Telescope git_files<cr>",                    description = "Git Files" },
            { "<M-.>",             ":Telescope find_files<cr>",                   description = "Find Files" },

            -- Search on /
            { "<M-/>",             ":Telescope live_grep prompt_prefix=🔍<cr>", description = "Live Grep" },
            { "<leader>/",         ":Telescope current_buffer_fuzzy_find<cr>",    "Fuzzy find current buffer" },

            -- Tmux-alike window controls
            { '<C-W>"',            ":sp<cr>",                                     description = "Split along X axis" },
            { '<C-W>%',            ":vs<cr>",                                     description = "Split along Y axis" },

            -- Meta arrows do nav between tabs
            { "<M-Down>",          ":tablast<cr>",                                description = "Last Tab" },
            { "<M-Left>",          ":tabprev<cr>",                                description = "Prev Tab" },
            { "<M-Right>",         ":tabnext<cr>",                                description = "Next Tab" },
            { "<M-Up>",            ":tabfirst<cr>",                               description = "First Tab" },

            -- Inter-file navigation is on F2
            { "<F2>",              ":Telescope file_browser<cr>",                 description = "Telescope file browser" },
            { "<leader><F2>",      ":Telescope zoxide list<cr>",                  description = "Telescope zoxide" },

            -- Buffer, tab, session, project mgmt on F3
            { "<F3>",              ":Telescope persisted<cr>",                    description = "Telescope Sessions" },
            { "<leader><F3>",      ":Telescope project<cr>",                      description = "Telescope Projects" },

            -- Undo on F4
            { "<F4>",              ":Telescope undo<cr>",                         description = "Undo" },
            { "<leader><F4>",      ":UndotreeToggle<cr>",                         description = "UndoTree" },

            -- Git integration on F5
            { "<F5>",              ":Telescope git_status<cr>",                   description = "Git Status" },
            { "<S-F5>",            ":Telescope git_bcommits<cr>",                 description = "Git Buffer Commits" },
            { "<C-F5>",            ":Telescope git_commits<cr>",                  description = "Git Commits" },
            { "<leader><F5>",      ":Telescope git_branches<cr>",                 description = "Git Branches" },
            { "<leader><C-F5>",    ":Telescope git_stash<cr>",                    description = "Git Stash" },
            -- TODO: diffview stuff on F6


            --- LSP Part A. Symbols on F7.
            { "<F7>",              ":Telescope lsp_document_symbols<cr>",         description = "Document Symbols" },
            { "<leader><F7>",      ":Telescope lsp_workspace_symbols<cr>",        description = "Workspace Symbols" },

            -- LSP part B, definitions, refeerences, implementations on F8
            { "<F8>",              ":Telescope lsp_definitions theme=cursor<cr>", description = "LSP Definitions" },
            { "<S-F8>",            ":Telescope lsp_references theme=cursor<cr>",  description = "LSP References" },
            {
              "<C-F8>",
              ":Telescope lsp_implementations theme=cursor<cr>",
              description =
              "LSP Implementations"
            },
            {
              "<leader><F8>",
              ":Telescope lsp_type_definitions theme=cursor<cr>",
              description =
              "LSP Type Definitions"
            },
            { "<leader><C-F8>", ":Telescope lsp_incoming_calls theme=cursor<cr>", description = "LSP Incoming Calls" },
            { "<leader><S-F8>", ":Telescope lsp_outgoing_calls theme=cursor<cr>", description = "LSP Outgoing Calls" },



          },
          commands = {},
          funcs = {},
          autocmds = {},
        })
    end
  }
end

return keyboard
