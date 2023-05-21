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

            -- Intra-file navigation is on F1
            { "<F1>",              ":Portal jumplist forward<cr>",                description = "Jumplist" },
            { "<S-F1>",            ":Portal jumplist backward<cr>",               description = "Jumplist" },
            { "<leader><F1>",      ":Telescope jumplist<cr>",                     description = "Jumplist" },

            -- Inter-file naviagation is on F2
            { "<F2>",              ":Telescope file_browser<cr>",                 description = "Telescope file browser" },
            { "<leader><F2>",      ":Telescope frecency<cr>",                     description = "Telescope frecency" },
            { "<S-F2>",            ":Telescope zoxide list<cr>",                  description = "Telescope zoxide" },

            -- Buffer, tab, session, project mgmt on F3
            { "<F3>",              ":Telescope sessions_picker<cr>",              description = "Telescope Sessions" },
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

            -- Treesitter on F6
            { "<F6>",              ":Telescope treesitter<cr>",                   description = "Treesitter" },

            --- LSP Part A. Symbols on F7.
            {
              "<F7>",
              ":Telescope lsp_document_symbols<cr>",
              description =
              "LSP Document Symbols"
            },
            {
              "<C-F7>",
              ":Telescope lsp_dynamic_workspace_symbols<cr>",
              description =
              "LSP Dynamic Workspace Symbols"
            },
            {
              "<S-F7>",
              ":Telescope lsp_workspace_symbols<cr>",
              description =
              "LSP Workspace Symbols"
            },

            -- LSP part B, definitions, refeerences, implementations on F8
            { "<F8>",   ":Telescope lsp_definitions theme=cursor<cr>", description = "LSP Definitions" },
            { "<S-F8>", ":Telescope lsp_references theme=cursor<cr>",  description = "LSP References" },
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

            -- LSP part C, diagnostics, on F10
            { "<F10>",          ":Telescope diagnostics theme=ivy<cr>",           description = "Diagnostics" },
            { "<S-10>",         ":Trouble<cr>",                                   description = "Trouble" },

            -- Digraphs and emojis are on F11
            {
              "<F11>",
              function()
                require 'telescope.builtin'.symbols(require 'telescope.themes'.get_cursor({ sources = { "emoji" } }))
              end,
              description = "Telescope Emojis"
            },
            { "<F12>", ":Telescope<cr>", description = "Telescope alone" },


          },
          commands = {},
          funcs = {},
          autocmds = {},
        })
    end
  }
end

return keyboard
