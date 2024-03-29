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
                { 'g"',     ":Regedit open<cr>",        description = "Edit all registers" },
                { 'g"*',    ':Regedit *<cr>',           description = 'Edit register *' },
                { 'g"+',    ':Regedit +<cr>',           description = 'Edit register +' },
                { 'g"a',    ':Regedit a<cr>',           description = 'Edit register a' },
                { 'g"b',    ':Regedit b<cr>',           description = 'Edit register b' },
                { 'g"c',    ':Regedit c<cr>',           description = 'Edit register c' },
                { 'g"d',    ':Regedit d<cr>',           description = 'Edit register d' },
                { 'g"e',    ':Regedit e<cr>',           description = 'Edit register e' },
                { 'g"f',    ':Regedit f<cr>',           description = 'Edit register f' },
                { 'g"g',    ':Regedit g<cr>',           description = 'Edit register g' },
                { 'g"h',    ':Regedit h<cr>',           description = 'Edit register h' },
                { 'g"i',    ':Regedit i<cr>',           description = 'Edit register i' },
                { 'g"j',    ':Regedit j<cr>',           description = 'Edit register j' },
                { 'g"k',    ':Regedit k<cr>',           description = 'Edit register k' },
                { 'g"l',    ':Regedit l<cr>',           description = 'Edit register l' },
                { 'g"m',    ':Regedit m<cr>',           description = 'Edit register m' },
                { 'g"n',    ':Regedit n<cr>',           description = 'Edit register n' },
                { 'g"o',    ':Regedit o<cr>',           description = 'Edit register o' },
                { 'g"p',    ':Regedit p<cr>',           description = 'Edit register p' },
                { 'g"q',    ':Regedit q<cr>',           description = 'Edit register q' },
                { 'g"r',    ':Regedit r<cr>',           description = 'Edit register r' },
                { 'g"t',    ':Regedit t<cr>',           description = 'Edit register t' },
                { 'g"u',    ':Regedit u<cr>',           description = 'Edit register u' },
                { 'g"v',    ':Regedit v<cr>',           description = 'Edit register v' },
                { 'g"w',    ':Regedit w<cr>',           description = 'Edit register w' },
                { 'g"x',    ':Regedit x<cr>',           description = 'Edit register x' },
                { 'g"y',    ':Regedit y<cr>',           description = 'Edit register y' },
                { 'g"z',    ':Regedit z<cr>',           description = 'Edit register z' },
              }
            },
            {
              itemgroup = 'find',
              description = 'Find files and text',
              icon = '🔍',
              keymaps = {
                -- TODO: git grep (plugin opportunity??)
                { "<M-/>", ":Telescope current_buffer_fuzzy_find theme=ivy prompt_prefix=🔍<cr>", description = "Ripgrep" },
                { "<M-?>", ":Telescope egrepify theme=ivy prompt_prefix=🔍<cr>", description = "Ripgrep" },
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
                { "<F3>",         ":Telescope undo<cr>", description = "Undo History" },
                { "<leader><F3>", ":UndotreeToggle<cr>", description = "Undo History" },
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
                { "<F7>", ":Navbuddy<cr>",     description = "LSP Symbols (document)" },
                { "gr",   ":LspUI rename<cr>", description = "IncRename" },
                { "gri",  ":IncRename<cr>",    description = "IncRename" },
                {
                  "grf",
                  ":LspUI reference<cr>",
                  description =
                  "Go to symbol definition"
                },
                {
                  "gd",
                  ":LspUI definition<cr>",
                  description =
                  "Go to symbol definition"
                },
                {
                  "gdi",
                  ":LspUI diagnostic<cr>",
                  description =
                  "Go to symbol definition"
                },
                {
                  "gde",
                  ":LspUI declaration<cr>",
                  description =
                  "Go to symbol definition"
                },
                {
                  "gi",
                  ":LspUI implementation<cr>",
                  description =
                  "Go to symbol implementation"
                },
                {
                  "gy",
                  ":LspUI type_definition<cr>",
                  description =
                  "Go to type definition"
                },
                {
                  "<leader>k",
                  ":LspUI hover<cr>",
                  description =
                  "Show (hover) info for current symbol"
                },
                {
                  "g!",
                  ":LspUI code_action<cr>",
                  description =
                  "Do code action for current symbol"
                },
                -- TODO: add treesitter shortcuts here and remove from treesitter.lua
              }
            },
            {
              itemgroup = 'todo',
              description = 'Todos',
              icon = '',
              keymaps = {
                { "<F8>",         ":TodoTelescope keywords=CHALLENGE,DECIDE,FIXME,LOOKUP,RESEARCH,TODO<cr>", description = "Telescope todos" },
                { "<leader><F8>", ":TodoTrouble keywords=CHALLENGE,DECIDE,FIXME,LOOKUP,RESEARCH,TODO<cr>",   description = "Trouble todos" },
                { "]t",
                  function()
                    require("todo-comments").jump_next({ keywords = { "CHALLENGE", "DECIDE", "FIXME", "LOOKUP", "RESEARCH", "TODO" } })
                  end
                },
                { "[t",
                  function()
                    require("todo-comments").jump_prev({ keywords = { "CHALLENGE", "DECIDE", "FIXME", "LOOKUP", "RESEARCH", "TODO" } })
                  end
                },
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
            {
              itemgroup = 'symbols',
              description = 'Use the symbol thingy',
              icon = 'æ',
              keymaps = {
                {
                  "<F10>",
                  {
                    n = function()
                      -- Wow this was disappointing. It almost worked. Leaving it here as a future enticement
                      -- local LizGroup = vim.api.nvim_create_augroup('LizGroup', { clear = true })
                      -- vim.api.nvim_create_autocmd(
                      --   "BufLeave",
                      --   {
                      --     pattern = "*",
                      --     group = LizGroup,
                      --     callback = function(events)
                      --       local ft = vim.api.nvim_buf_get_option(events.buf, 'filetype')
                      --       if ft == 'TelescopePrompt' then
                      --   🦶      vim.notify("should def have worked")
                      --       end
                      --     end
                      --   }
                      -- )
                      --
                      vim.cmd("Telescope symbols theme=dropdown")
                    end,
                    i = "<C-O>:Telescope symbols theme=cursor<cr>",
                    v = "d:Telescope symbols theme=cursor<cr>"
                  },
                  description = "Symbols"
                },
              }
            },
            {
              itemgroup = 'copilot',
              description = 'Copilot',
              icon = '🤖',
              keymaps = {
                { "<F11>", ":Copilot panel<cr>", description = "Copilot panel" },
              },
            },
            {
              itemgroup = 'cut/copy/paste',
              description = 'system clipboard integration',
              icon = '✂️',
              keymaps = {
                { "<leader>c", { x = '"+y' },                               description = "Copy" },
                { "<leader>x", { x = '"+d' },                               description = "Cut" },
                { "<leader>v", { n = '<leader>p"+p<leader>p', x = 'd"+p' }, description = "Paste" },
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
