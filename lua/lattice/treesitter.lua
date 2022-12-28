local treesitter = {}

function treesitter.setup(use)
  use {
    "mfussenegger/nvim-ts-hint-textobject",
    config = function()
      vim.api.nvim_set_keymap("o", "m", "<cmd><C-U>lua require('tsht').nodes()<CR>", {})
      vim.api.nvim_set_keymap("v", "m", "<cmd>lua require('tsht').nodes()<CR>", {})
    end
  }
  use {
    "nvim-treesitter/nvim-treesitter",
    requires = {
      "andymass/vim-matchup", -- TODO: config as https://github.com/andymass/vim-matchup/
      "RRethy/nvim-treesitter-textsubjects",
      "danymat/neogen",
      "m-demare/hlargs.nvim",
      "mfussenegger/nvim-treehopper",
      "JoosepAlviste/nvim-ts-context-commentstring",
      "nvim-treesitter/nvim-treesitter-context",
      "nvim-treesitter/nvim-treesitter-refactor",
      "p00f/nvim-ts-rainbow",
      "theHamsta/nvim-treesitter-pairs",
      "windwp/nvim-ts-autotag"
    },
    config = function()
      require "neogen".setup {}
      require "hlargs".setup {}
      require "nvim-treesitter.configs".setup {
        highlight = {
          enable = true, -- false will disable the whole extension
          additional_vim_regex_highlighting = false
        },
        ensure_installed = {
          "bash",
          "c",
          "cmake",
          "comment",
          "cpp",
          "css",
          "diff",
          "dockerfile",
          "dot",
          "graphql",
          "html",
          "http",
          "javascript",
          "ledger",
          "lua",
          "markdown",
          "markdown_inline",
          "nix",
          "norg",
          "perl",
          "php",
          "python",
          "ql",
          "query",
          "regex",
          "rst",
          "ruby",
          "rust",
          "svelte",
          "toml",
          "tsx",
          "typescript",
          "vim",
          "yaml",
          "zig"
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<leader>gnn",
            node_incremental = "<leader>grn",
            scope_incremental = "<leader>grc",
            node_decremental = "<leader>grm"
          }
        },
        autotag = {
          enable = true
        },
        refactor = {
          highlight_definitions = {
            enable = true
          },
          highlight_current_scope = {
            enable = true
          },
          smart_rename = {
            enable = true,
            keymaps = {
              smart_rename = "<leader>gsr"
            }
          },
          navigation = {
            enable = true,
            keymaps = {
              goto_definition = "<leader>gnd",
              list_definitions = "<leader>gnD",
              list_definitions_toc = "<leader>gO",
              goto_next_usage = "<leader><a-*>",
              goto_previous_usage = "<leader><a-#>"
            }
          }
        },
        indent = {
          enable = true
        },
        context_commentstring = {
          enable = true
        },
        textsubjects = {
          enable = true,
          keymaps = {
            ["<leader>g."] = "textsubjects-smart",
            ["<leader>g;"] = "textsubjects-container-outer"
          }
        },
        rainbow = {
          enable = true,
          extended_mode = true,
          max_file_lines = nil
        },
      }
      vim.cmd [[
          set foldmethod=expr
          set foldexpr=nvim_treesitter#foldexpr()
          set nofoldenable                     " Disable folding at startup.
        ]]
    end
  }
end

return treesitter
