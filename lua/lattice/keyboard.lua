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
              itemgroup = 'Frecency',
              description = 'Use the Frecencer',
              icon = '📶',
              keymaps = {
                { "<leader>f", ":Telescope frecency<cr>",           description = "Browse Frecency" },
                { "<M-,>",     ":Telescope frecency theme=ivy<cr>", description = "Browse Frecency (syn)" },
              }
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
            -- TODO: keybindings for walking TODOs as per https://github.com/folke/todo-comments.nvim
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
              itemgroup = 'files',
              description = 'Browse files and directories',
              icon = '',
              keymaps = {
                { "<F2>",         ":Telescope file_browser path=%:p:h select_buffer=true<cr>", description = "Browse directory of current file" },
                { "<leader><F2>", ":Telescope file_browser<cr>",                               description = "Browse CWD" },
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
                { "<F7>",  ":Telescope lsp_references<cr>",        description = "LSP References" },
                { "<F7>s", ":Telescope lsp_document_symbols<cr>",  description = "LSP Symbols (document)" },
                { "<F7>S", ":Telescope lsp_workspace_symbols<cr>", description = "LSP Symbols (workspace)" },
                { "<F7>d", ":Telescope lsp_definitions<cr>",       description = "LSP Definitions" },
                { "<F7>D", ":Telescope lsp_type_definitions<cr>",  description = "LSP Definitions (type)" },
                { "<F7>c", ":Telescope lsp_declarations<cr>",      description = "LSP Declarations" },
                { "<F7>i", ":Telescope lsp_implementations<cr>",   description = "LSP Implementations" },
                { "gr",    ":IncRename<cr>",                       description = "IncRename" },
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
                -- TODO: add treesitter shortcuts here and remove from treesitter.lua
              }
            },
            {
              itemgroup = 'treesitter',
              description = 'Treesitter',
              icon = '',
              keymaps = {
                { "<F8>", ":Telescope treesitter<cr>", description = "Treesitter" },
                -- TODO: add treesitter shortcuts here and remove from treesitter.lua
              }
            },


          },
          commands = {
            -- {
            --   ':VennToggle', -- based on code in README
            --   function()
            --     local venn_enabled = vim.inspect(vim.b.venn_enabled)
            --     if venn_enabled == "nil" then
            --       vim.b.venn_enabled = true
            --       vim.cmd [[setlocal ve=all]]
            --       -- draw a line on HJKL keystrokes
            --       vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", { noremap = true })
            --       vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", { noremap = true })
            --       vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", { noremap = true })
            --       vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", { noremap = true })
            --       -- draw a box by pressing "f" with visual selection
            --       vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", { noremap = true })
            --     else
            --       -- TODO: clean up
            --       vim.cmd [[setlocal ve=]]
            --       vim.cmd [[mapclear <buffer>]]
            --       vim.b.venn_enabled = nil
            --     end
            --   end
            -- }
          },
          funcs = {
            -- {
            --   function()
            --     require("notify")("hello world")
            --   end,
            --   description = "Hello world!",
            --   itemgroup = 'lsp'
            -- }
          },
          autocmds = {
            -- FIXME: this next thing does not work and I do not know why.
            -- I think the problem is that there are two things that need to happen, 1. lua reload and 2. packer recompile
            -- This code AFAIK just recompiles the already loaded lua, without refresh.
            -- {
            --   'BufWritePost',
            --   function()
            --     require 'packer'.compile()
            --   end,
            --   opts = {
            --     pattern = { '/home/lattice/lattice-nix/nvim-config/lua/lattice/*.lua' }
            --   },
            --   description = 'Recompile lua config upon ch-ch-changes',
            -- },
          },
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
