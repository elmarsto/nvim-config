local keyboard = {}

function keyboard.setup(use)
  use {
    "mrjones2014/legendary.nvim",
    require = { "kkarji/sqlite.lua" },
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
            -- jumplist is on semicolon
            { ";",                 ":Telescope jumplist<cr>",                     description = "Jumplist" },

            -- Registers, Marks also nearby, and mnemonic the quote keys appropriate for both
            { "<M-\">",            ":Telescope registers theme=cursor<cr>",       description = "Registers" },
            { "<M-\'>",            ":Telescope marks<cr>",                        description = "Marks" },

            -- Tmux-alike window controls
            { '<C-W>"',            ":sp<cr>",                                     description = "Split along X axis" },
            { '<C-W>%',            ":vs<cr>",                                     description = "Split along Y axis" },

            -- Meta arrows do nav between tabs
            { "<M-Down>",          ":tablast<cr>",                                description = "Last Tab" },
            { "<M-Left>",          ":tabprev<cr>",                                description = "Prev Tab" },
            { "<M-Right>",         ":tabnext<cr>",                                description = "Next Tab" },
            { "<M-Up>",            ":tabfirst<cr>",                               description = "First Tab" },

            -- Help is on F1
            {
              "<F1>",
              ":Telescope help_tags<cr>",
              description =
              "Telescope Help Tags"
            },
            {
              "<S-F1>",
              ":Telescope man_pages<cr>",
              description =
              "Telescope Man Pages"
            },

            -- Buffer, tab, session, project mgmt on F2
            { "<F2>",           ":Telescope buffers<cr>",                   description = "Telescope Buffers" },
            { "<S-F2>",         ":Telescope telescope-tabs list_tabs<cr>",  description = "Telescope Tabs" },
            { "<C-F2>",         ":Telescope sessions_picker<cr>",           description = "Telescope Sessions" },
            { "<leader><F2>",   ":Telescope project<cr>",                   description = "Telescope Projects" },

            -- Undo on F3
            { "<F3>",           ":Telescope undo<cr>",                      description = "Undo" },
            { "<S-F3>",         ":UndotreeToggle<cr>",                      description = "UndoTree" },

            -- Vim Stuff on F4
            { "<F4>",           ":Telescope commands<cr>",                  description = "Vim Commands" },
            { "<S-F4>",         ":Telescope vim_options<cr>",               description = "Vim Options" },
            { "<C-F4>",         ":Telescope autocommands<cr>",              description = "Vim Autocommands" },

            -- Clipboard & Action history on F5
            { "<F5>",           ":Telescope neoclip theme=ivy<cr>",         description = "Clipboard History" },
            { "<S-F5>",         ":Telescope command_history theme=ivy<cr>", description = "Command History" },
            { "<C-F5>",         ":Telescope search_history theme=ivy<cr>",  description = "Search History" },

            -- Git integration on F6
            { "<F6>",           ":Telescope git_status<cr>",                description = "Git Status" },
            { "<S-F6>",         ":Telescope git_bcommits<cr>",              description = "Git Buffer Commits" },
            { "<C-F6>",         ":Telescope git_commits<cr>",               description = "Git Commits" },
            { "<leader><F6>",   ":Telescope git_branches<cr>",              description = "Git Branches" },
            { "<leader><C-F6>", ":Telescope git_stash<cr>",                 description = "Git Stash" },

            --- Quickfix on F7
            { "<F7>",           ":Telescope quickfix<cr>",                  description = "Quickfix" },
            { "<S-F7>",         ":Telescope quickfixhistory<cr>",           description = "Quickfix History" },
            { "<C-F7>",         ":Telescope loclist<cr>",                   description = "Loclist" },

            --- LSP Part A. Symbols on F8. (Trhows in Treesitter as well)
            {
              "<F8>",
              ":Telescope lsp_document_symbols<cr>",
              description =
              "LSP Document Symbols"
            },
            {
              "<C-F8>",
              ":Telescope lsp_dynamic_workspace_symbols<cr>",
              description =
              "LSP Dynamic Workspace Symbols"
            },
            {
              "<S-F8>",
              ":Telescope lsp_workspace_symbols<cr>",
              description =
              "LSP Workspace Symbols"
            },
            { "<leader><F8>", ":Telescope treesitter<cr>",                   description = "Treesitter" },
            -- LSP part B, definitions, refeerences, implementations on F9
            { "<F9>",         ":Telescope lsp_definitions theme=cursor<cr>", description = "LSP Definitions" },
            { "<S-F9>",       ":Telescope lsp_references theme=cursor<cr>",  description = "LSP References" },
            {
              "<C-F9>",
              ":Telescope lsp_implementations theme=cursor<cr>",
              description =
              "LSP Implementations"
            },
            {
              "<leader><F9>",
              ":Telescope lsp_type_definitions theme=cursor<cr>",
              description =
              "LSP Type Definitions"
            },
            { "<leader><C-F9>", ":Telescope lsp_incoming_calls theme=cursor<cr>", description = "LSP Incoming Calls" },
            { "<leader><S-F9>", ":Telescope lsp_outgoing_calls theme=cursor<cr>", description = "LSP Outgoing Calls" },
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
            { "<F12>",         ":Telescope<cr>",             description = "Telescope alone" },
            { "<leader><Tab>", ":Telescope frecency<cr>",    description = "Telescope frecency" },
            { "<leader>z",     ":Telescope zoxide list<cr>", description = "Telescope zoxide" }
          },
          commands = {},
          funcs = {},
          autocmds = {},
        })
    end
  }
end

return keyboard
