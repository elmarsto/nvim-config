local keyboard = {}

function keyboard.setup(use)
  use {
    "mrjones2014/legendary.nvim",
    after = { "sqlite.lua", "dressing.nvim", "telescope.nvim" },
    config = function()
      require("legendary").setup(
        {
          keymaps = {
            -- Legends, keymaps on spacebar
            {
              itemgroup = 'meta',
              description = 'Commands about commands',
              icon = '🤘',
              keymaps = {
                { "<leader><CR>",      ":Legendary<cr>",         description = "Legendary (Meta!)" },
                { "<leader><C-Space>", ":Telescope keymaps<cr>", description = "Telescope Keymap" },
                { "<leader>T",         ":Telescope<cr>",         description = "Telescope" },
                { "<leader>C",         ":PackerCompile<cr>",     description = "Telescope" },
              }
            },
            {
              itemgroup = 'window',
              description = 'Use windows',
              icon = '🪟',
              keymaps = {
                { '<C-W>"',    ":sp<cr>",             description = "Horiz split" },
                { '<C-W>%',    ":vs<cr>",             description = "Vert split" },
                { '<C-W>m',    ":WinShift<cr>",       description = "Activate Winshift Mode" },
                { '<C-W>x',    ":WinShift swap<cr>",  description = "Swap two windows" },
                { '<C-M-H>',   ":WinShift left<cr>",  description = "Shift window left" },
                { '<C-M-J>',   ":WinShift down<cr>",  description = "Shfift window down" },
                { '<C-M-K>',   ":WinShift up<cr>",    description = "Shift window up" },
                { '<C-M-L>',   ":WinShift right<cr>", description = "Shift window right" },
                { "<C-Left>",  ":wincmd h<cr>",       description = "Select window on the left" },
                { "<C-Down>",  ":wincmd j<cr>",       description = "Select window on the light" },
                { "<C-Up>",    ":wincmd k<cr>",       description = "Select window above" },
                { "<C-Right>", ":wincmd l<cr>",       description = "Select window below" },
                -- not shown: M-j etc. all works for resizing thanks to smart-splits (see bunt.lua)
              }
            },
            {
              itemgroup = 'tab',
              description = 'Use tabs',
              icon = '▬',
              keymaps = {
                {
                  "<leader>t",
                  ":Telescope telescope-tabs list_tabs theme=dropdown<cr>",
                  description =
                  "Browse tabs"
                },
                {
                  "<leader>tn",
                  ":tabnew<cr>",
                  description =
                  "New Tab"
                },
                {
                  "<leader>td",
                  ":tabclose<cr>",
                  description =
                  "Del Tab"
                },
                {
                  "<M-Home>",
                  ":tabfirst<cr>",
                  description =
                  "First Tab"
                },
                {
                  "<M-PageUp>",
                  ":tabprev<cr>",
                  description =
                  "Prev Tab"
                },
                {
                  "<M-PageDown>",
                  ":tabnext<cr>",
                  description =
                  "Next Tab"
                },
                {
                  "<leader>to",
                  ":tabonly<cr>",
                  description =
                  "Only Tab"
                },
                {
                  "<leader>tc",
                  ":tabedit %<cr>",
                  description =
                  "Clone Tab"
                },
                {
                  "<M-End>",
                  ":tablast<cr>",
                  description =
                  "Last Tab"
                },
                {
                  "<M-S-PageUp>",
                  ":-tabmove<cr>",
                  description =
                  "Move Tab -"
                },
                {
                  "<M-S-PageDown>",
                  ":+tabmove<cr>",
                  description =
                  "Move Tab +"
                },
                {
                  "<M-S-Home>",
                  ":tabmove 0<cr>",
                  description =
                  "Move Tab ^"
                },
                {
                  "<M-S-Home>",
                  ":tabmove $<cr>",
                  description =
                  "Move Tab ^"
                },
              }
            },
            {
              itemgroup = 'jump',
              description = 'Use the jumplist',
              icon = '🏀',
              keymaps = {
                { "<leader>j",     ":Telescope jumplist<cr>",           description = "Browse Jumps" },
                { "<leader><tab>", ":Telescope jumplist theme=ivy<cr>", description = "Browse Jumps" },
                { "[j",            "<C-I>",                             description = "Prev Jump" },
                { "]j",            "<C-O>",                             description = "Next Jump" },
              }
            },
            {
              itemgroup = 'buffer',
              description = 'Use the buffer list',
              icon = '',
              keymaps = {
                { "<leader>b", ":Telescope buffers<cr>", description = "Browse Buffers" },
                { "]b",        ":bp<cr>",                description = "Prev Buffer" },
                { "[b",        ":bn<cr>",                description = "Next Buffer" },
              }
            },
            {
              itemgroup = 'quickfix',
              description = 'Use the quickfix list',
              icon = '🩹',
              keymaps = {
                { "<leader>c", ":Telescope quickfix<cr>", description = "Browse CList" },
                { "[c",        ":cp<cr>",                 description = "Prev Quickfix" },
                { "]c",        ":cn<cr>",                 description = "Next Quickfix" },
              }
            },
            {
              itemgroup = 'loclist',
              description = 'Use the loclist',
              icon = '',
              keymaps = {
                { "<leader>l", ":Telescope loclist<cr>", description = "Browse Loclist" },
                { "[l",        ":lp<cr>",                description = "Prev Loclist" },
                { "]l",        ":ln<cr>",                description = "Next Loclist" },
              }
            },
            {
              itemgroup = 'diagnostics',
              description = 'Use the list of diagnostics',
              icon = '',
              keymaps = {
                { "<F8>",        ":TroubleToggle<cr>",                    description = "Open Trouble" },
                { "<leader>T",   ":TroubleToggle<cr>",                    description = "Open Trouble" },
                { "<leader>d",   ":Telescope diagnostics<cr>",            description = "Browse Diagnostics" },
                { "[d",          ":lua vim.diagnostic.goto_prev()<cr>",   description = "Prev Diagnostic" },
                { "]d",          ":lua vim.diagnostic.goto_next()<cr>",   description = "Next Diagnostic" },
                { "<leader>d2l", ":lua vim.diagnostic.set_loclist()<cr>", description = "Diagnostics -> Ll" },
              }
            },
            -- TODO: keybindings for walking TODOs as per https://github.com/folke/todo-comments.nvim
            {
              itemgroup = 'quot',
              description = 'Use registers and marks',
              icon = '®',
              keymaps = {
                { "<M-\">", ":Telescope registers theme=cursor<cr>", description = "Put from register" },
                { "<M-\'>", ":Telescope marks<cr>",                  description = "Navigate to mark" },
              }
            },
            {
              itemgroup = 'find',
              description = 'Find files and text',
              icon = '🔍',
              keymaps = {
                -- TODO: git grep (plugin opportunity??)
                { "<M-/>",         ":Telescope live_grep prompt_prefix=🔍<cr>", description = "Ripgrep" },
                { "<M-.>",         ":Telescope find_files<cr>",                   description = "Find Files" },
                { "<leader><M-.>", ":Telescope git_files<cr>",                    description = "Find Files (Git)" },
              }
            },
            {
              itemgroup = 'sesh',
              description = 'Browse sessions and projects',
              icon = '📽️',
              keymaps = {
                { "<F1>",         ":Telescope persisted<cr>", description = "Browse Sessions" },
                { "<leader><F1>", ":Telescope project<cr>",   description = "Browse Projects" },
                { "<leader>s",    ":Telescope persisted<cr>", description = "Browse Sessions" },
                { "<leader>sv",   ":SessionSave<cr>",         description = "Save Session" },
                { "<leader>so",   ":SessionStop<cr>",         description = "Stop Session" },
                { "<leader>sa",   ":SessionStart<cr>",        description = "Start Session" },
                { "<leader>st",   ":SessionToggle<cr>",       description = "Toggle Session" },
                { "<leader>sd",   ":SessionDelete<cr>",       description = "Delete Session" },
                { "<leader>sl",   ":SessionLoad<cr>",         description = "Load Session" },
                { "<leader>sla",  ":SessionLoadLast<cr>",     description = "Load Last Session" },
                { "<leader>slf",  ":SessionLoadFromFile<cr>", description = "Load Session from File" },
              }
            },

            {
              itemgroup = 'files',
              description = 'Browse files and directories',
              icon = '',
              keymaps = {
                { "<F2>",         ":Telescope file_browser<cr>", description = "Browse files" },
                { "<leader><F2>", ":Telescope zoxide list<cr>",  description = "Browse directories" },
              }
            },

            {
              itemgroup = 'file_history',
              description = 'Browse history of current file',
              icon = '',
              keymaps = {
                { "<F3>",         ":DiffviewFileHistory %<cr>", description = "Git History (file)" },
                { "<leader><F3>", ":UndotreeToggle<cr>",        description = "Undo History" },
              }
            },

            {
              itemgroup = 'branch_history',
              description = 'Browse history of current branch',
              icon = '',
              keymaps = {
                { "<F4>", ":DiffviewFileHistory<cr>", description = "Git History (branch)" },
              }
            },
            {
              itemgroup = 'branch_status',
              description = 'Browse staged and recent changes',
              icon = '🍵',
              keymaps = {
                -- Navigate project changes
                { "<F5>",         ":DiffviewOpen<cr>",        description = "Git diff HEAD" },
                { "<leader><F5>", ":DiffviewOpen HEAD~1<cr>", description = "Git diff HEAD~1" },
              }
            },

            {
              itemgroup = 'repo',
              description = 'Browse commits, branches, and stashes',
              icon = '',
              keymaps = {
                { "<F6>",           ":Telescope git_commits<cr>",     description = "Git Commits" },
                { "<leader><F6>",   ":Telescope git_branches<space>", description = "Git Branches" },
                { "<leader><S-F6>", ":Telescope git_stash<space>",    description = "Git Stash" },
              }
            },


            {
              itemgroup = 'repl',
              description = 'Manage a repl or terminal',
              icon = '',
              keymaps = {
                { "<leader>rs", ":IronRepl<cr>",  description = "Start Repl" },
                {
                  "<leader>rr",
                  ":IronRestart<cr>",
                  description =
                  "Restart Repl"
                },
                { "<leader>rf", ":IronFocus<cr>", description = "Focus Repl" },
                { "<leader>rh", ":IronHide<cr>",  description = "Hide Repl" },
                {
                  "<C-z>",
                  ":split | wincmd j | resize 20 | startinsert | terminal<cr>",
                  description =
                  "Open terminal"
                },
              }
            },
            {
              itemgroup = 'draw',
              description = 'Ascii art',
              icon = '🎨',
              keymaps = {
                { "<leader>v", ":VennToggle<cr>", description = "Toggle Venn diagram mode" }
              }
            },
            {
              itemgroup = 'lsp',
              description = 'Language-aware commands (LSP & Treesitter)',
              icon = '',
              keymaps = {
                -- LSP: Rename
                { "gR", ":IncRename<cr>",                             description = "LSP IncRename" },
                { "gr", ":Telescope lsp_references theme=cursor<cr>", description = "LSP References" },
                {
                  "gD",
                  ":lua vim.lsp.buf.declaration()<cr>",
                  description =
                  "Go to symbol declaration"
                },
                {
                  "gd",
                  ":lua vim.lsp.buf.definition()<cr>",
                  description =
                  "Go to symbol definition"
                },
                {
                  "gi",
                  ":lua vim.lsp.buf.implementation()<cr>",
                  description =
                  "Go to symbol implementation"
                },
                {
                  "gtd",
                  ":lua vim.lsp.buf.type_definition()<cr>",
                  description =
                  "Go to type definition"
                },
                {
                  "<leader>k",
                  ":lua vim.lsp.buf.hover()<cr>",
                  description =
                  "Show (hover) info for current symbol"
                },
                {
                  "g!",
                  ":lua vim.lsp.buf.code_action()<cr>",
                  description =
                  "Do code action for current symbol"
                },
                -- TODO: add treesitter shortcuts here and remove from tresitter.lua
              }
            },

          },
          commands = {
            {
              ':VennToggle', -- based on code in README
              function()
                local venn_enabled = vim.inspect(vim.b.venn_enabled)
                if venn_enabled == "nil" then
                  vim.b.venn_enabled = true
                  vim.cmd [[setlocal ve=all]]
                  -- draw a line on HJKL keystokes
                  vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", { noremap = true })
                  vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", { noremap = true })
                  vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", { noremap = true })
                  vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", { noremap = true })
                  -- draw a box by pressing "f" with visual selection
                  vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", { noremap = true })
                else
                  -- TODO: clean up
                  vim.cmd [[setlocal ve=]]
                  vim.cmd [[mapclear <buffer>]]
                  vim.b.venn_enabled = nil
                end
              end
            }
          },
          funcs = {
            {
              function()
                require("notify")("hello world")
              end,
              description = "Hello world!",
              itemgroup = 'lsp'
            }
          },
          autocmds = {},
          extensions = {
            diffview = true,
            smart_splits = {},
          }
        })
    end
  }
  use "tpope/vim-repeat"
end

return keyboard
