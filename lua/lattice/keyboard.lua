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
      require("legendary").setup(-- TODO extract shortcuts below, redo w mapx, remove legendary
        {
          keymaps = {
            { "<C-Space>", ":Legendary<cr>", description = "Legendary (Meta!)" },
            { "<leader><C-Space>", ":Legendary<cr>", description = "Telescope Keymap" },
            { "<leader>e",
              function()
                require 'telescope.builtin'.symbols { sources = { "emoji" } }
              end,
              description = "Emojis"
            },
            { "<leader><Space>", ":Trouble<cr>", description = "Trouble" },
            { "<F3>", ":UndotreeToggle<cr>", description = "UndoTree" },
            { "<M-Left>", ":tabprev<cr>", description = "Prev Tab" },
            { "<M-Right>", ":tabnext<cr>", description = "Next Tab" },
            { "<M-Down>", ":tablast<cr>", description = "Last Tab" },
            { "<M-Up>", ":tabfirst<cr>", description = "First Tab" },
            { "<M-/>", ":Telescope live_grep<cr>", description = "Live Grep" },
            { "<M-\'>", ":Telescope marks<cr>", description = "Marks" },
            { "<M-\">", ":Telescope registers<cr>", description = "Registers" },
            { "<M-,>", ":Telescope git_files<cr>", description = "Git Files" },
            { "<M-lt>", ":Telescope git_branches<cr>", description = "Git Branches" },
            { "<M-.>", ":Telescope find_files<cr>", description = "Find Files" },
            { "<Tab><Tab>", ":Telescope buffers<cr>", description = "Buffers" },
            { "<leader>z", ":Telescope current_buffer_fuzzy_find<cr>",
              description = "Telescope Current Buffer Fuzzy Find" },
            { "<Home>", ":Telescope<cr>", description = "Telescope (tout seul)" },
            { "<CR>", ":Telescope treesitter<cr>", description = "Telescope Treesitter Symbols" },
            {
              "<M-CR>",
              ":Telescope lsp_document_symbols<cr>",
              description = "Telescope LSP Document Symbols"
            },
            {
              "<leader><M-CR>",
              ":Telescope lsp_workspace_symbols<cr>",
              description = "Telescope LSP Workspace Symbols"
            },
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
