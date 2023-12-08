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
              itemgroup = 'meta & existential',
              description = 'Commands about commands',
              icon = '🤘',
              keymaps = {
                { "<leader><CR>",      ":Legendary<cr>",         description = "Legendary (Metal!)" },
                { "<leader><C-Space>", ":Telescope keymaps<cr>", description = "Telescope Keymap" },
                { "<leader>T",         ":Telescope<cr>",         description = "Telescope" },
                { "<leader>L",         ":luafile %<cr>",         description = "Reload current luafile" },
                {
                  "ZC",
                  function()
                    vim.
                        vim.cmd [[
                     luafile /home/lattice/lattice-nix/nvim-config/init.lua
                     PackerCompile
                    ]]
                  end,
                  description = "Recompile neovim packages"
                },
                {
                  "ZZ",
                  ":wqa<cr>",
                  description =
                  "Close everything but keep tabs and windows in sesh"
                },
                {
                  "ZQ",
                  ":qa!<cr>",
                  description =
                  "Close everything and don't save, but keep tabs and windows in sesh"
                },
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
                { '<C-M-J>',   ":WinShift down<cr>",  description = "Shift window down" },
                { '<C-M-K>',   ":WinShift up<cr>",    description = "Shift window up" },
                { '<C-M-L>',   ":WinShift right<cr>", description = "Shift window right" },
                { "<C-Left>",  ":wincmd h<cr>",       description = "Select window on the left" },
                { "<C-Down>",  ":wincmd j<cr>",       description = "Select window on the light" },
                { "<C-Up>",    ":wincmd k<cr>",       description = "Select window above" },
                { "<C-Right>", ":wincmd l<cr>",       description = "Select window below" },
                -- not shown: M-j etc. All works for resizing thanks to smart-splits (see bunt.lua)
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
              itemgroup = 'quot',
              description = 'Use registers and marks',
              icon = '®',
              keymaps = {
                { "<M-\">", ":Telescope registers<cr>", description = "Put from register" },
                { "<M-\'>", ":Telescope marks<cr>",     description = "Navigate to mark" },
              }
            },
            {
              itemgroup = 'find',
              description = 'Find files and text',
              icon = '🔍',
              keymaps = {
                -- TODO: git grep (plugin opportunity??)
                { "<M-/>", ":Telescope current_buffer_fuzzy_find theme=ivy prompt_prefix=🔍<cr>", description = "Ripgrep" },
                { "<M-?>", ":Telescope live_grep theme=ivy prompt_prefix=🔍<cr>", description = "Ripgrep" },
                { "<M-.>", ":Telescope find_files theme=ivy prompt_prefix=🔍<cr>", description = "Find Files" },
                {
                  "<leader><M-.>",
                  ":Telescope git_files theme=ivy<cr>",
                  description =
                  "Find Files (Git)"
                },
              }
            },
            {
              itemgroup = 'buffer',
              description = 'Use the buffer list',
              icon = '',
              keymaps = {
                { "<leader><Tab>", ":Telescope buffers<cr>", description = "Browse Buffers" },
                { "<leader>b",     ":Telescope buffers<cr>", description = "Browse Buffers (syn)" },
                { "]b",            ":bp<cr>",                description = "Prev Buffer" },
                { "[b",            ":bn<cr>",                description = "Next Buffer" },
              }
            },
            {
              itemgroup = 'jump',
              description = 'Use the jumplist',
              icon = '🏀',
              keymaps = {
                { "<F1>", ":Telescope jumplist theme=ivy<cr>", description = "Browse Jumps" },
                { "[j",   "<C-I>",                             description = "Prev Jump" },
                { "]j",   "<C-O>",                             description = "Next Jump" },
              }
            },
            {
              itemgroup = 'files',
              description = 'Browse files and directories',
              icon = '',
              keymaps = {
                { "<F2>",  ":Telescope frecency<cr>",           description = "Browse Frecency" },
                { "<M-,>", ":Telescope frecency theme=ivy<cr>", description = "Browse Frecency (syn)" },
              }
            },
            {
              itemgroup = 'file_history',
              description = 'Browse history of current file',
              icon = '',
              keymaps = {
                { "<F3>", ":UndotreeToggle<cr>", description = "Undo History" },
              }
            },
            {
              itemgroup = 'branch_history',
              description = 'Browse history of current branch',
              icon = '',
              keymaps = {
                { "<F4>",         ":DiffviewFileHistory %<cr>",   description = "Git History (file)" },
                { "<leader><F4>", ":DiffviewFileHistory %:h<cr>", description = "Git History (directory of current file)" },
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
              itemgroup = 'lsp',
              description = 'LSP',
              icon = '',
              keymaps = {
                -- LSP: Rename
                { "<F7>",         ":Telescope lsp_document_symbols<cr>",  description = "LSP Symbols (document)" },
                { "<leader><F7>", ":Telescope lsp_workspace_symbols<cr>", description = "LSP Symbols (workspace)" },
                { "glr",          ":IncRename<cr>",                       description = "IncRename" },
                {
                  "glD",
                  ":Telescope lsp_declarations theme=cursor<cr>",
                  description =
                  "Go to symbol declaration"
                },
                {
                  "gld",
                  ":Telescope lsp_definitions theme=cursor<cr>",
                  description =
                  "Go to symbol definition"
                },
                {
                  "gli",
                  ":Telescope lsp_implementations theme=cursor<cr>",
                  description =
                  "Go to symbol implementation"
                },
                {
                  "gldt",
                  ":Telescope lsp_type_definitions theme=cursor<cr>",
                  description =
                  "Go to type definition"
                },
                {
                  "glk",
                  ":lua vim.lsp.buf.hover()<cr>",
                  description =
                  "Show (hover) info for current symbol"
                },
                {
                  "gl!",
                  ":lua vim.lsp.buf.code_action()<cr>",
                  description =
                  "Do code action for current symbol"
                },
                -- TODO: add treesitter shortcuts here and remove from treesitter.lua
              }
            },
            {
              itemgroup = 'treesitter',
              description = 'Treesitter',
              icon = '',
              keymaps = {
                { "<F8>", ":Telescope treesitter<cr>", description = "Treesitter" },
              },
            },
            {
              itemgroup = 'diagnostics',
              description = 'Use the list of diagnostics',
              icon = '',
              keymaps = {
                { "<F9>",        ":TroubleToggle<cr>",                    description = "Open Trouble" },
                { "<leader>T",   ":TroubleToggle<cr>",                    description = "Open Trouble (syn)" },
                { "<leader>d",   ":Telescope diagnostics<cr>",            description = "Browse Diagnostics" },
                { "[g",          ":lua vim.diagnostic.goto_prev()<cr>",   description = "Prev Diagnostic" },
                { "]g",          ":lua vim.diagnostic.goto_next()<cr>",   description = "Next Diagnostic" },
                { "<leader>d2l", ":lua vim.diagnostic.set_loclist()<cr>", description = "Diagnostics -> Ll" },
              }
            },
            {
              itemgroup = 'quickfix',
              description = 'Use the quickfix list',
              icon = '🩹',
              keymaps = {
                { "<leader><F9>", ":Telescope quickfix<cr>", description = "Browse CList" },
                { "<leader>c",    ":Telescope quickfix<cr>", description = "Browse CList (syn)" },
                { "[c",           ":cp<cr>",                 description = "Prev Quickfix" },
                { "]c",           ":cn<cr>",                 description = "Next Quickfix" },
              }
            },
          },
          commands = {},
          funcs = {},
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
