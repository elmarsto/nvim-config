local treesitter = {}
function treesitter.setup(use)
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    requires = {
      "JoosepAlviste/nvim-ts-context-commentstring",
      "RRethy/nvim-treesitter-textsubjects",
      "nvim-treesitter/nvim-treesitter-context",
      "nvim-treesitter/nvim-treesitter-refactor",
      "windwp/nvim-ts-autotag",
    },
    config = function()
      require "nvim-treesitter.configs".setup {
        highlight = {
          enable = true, -- false will disable the whole extension
          additional_vim_regex_highlighting = { "markdown" }
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
          "haskell",
          "html",
          "http",
          "javascript",
          "ledger",
          "lua",
          "markdown",
          "markdown_inline",
          "mermaid",
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
            init_selection = "<CR>",
            node_incremental = "<CR>",
            scope_incremental = "<Tab>",
            node_decremental = "<S-Tab>"
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
              smart_rename = "gsr"
            }
          },
          navigation = {
            enable = true,
            keymaps = {
              goto_definition = "gnd",
              list_definitions = "gnD",
              list_definitions_toc = "gO",
              goto_next_usage = "<a-*>",
              goto_previous_usage = "<a-#>"
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
          prev_selection = ',',
          keymaps = {
            ["."] = "textsubjects-smart",
            [";"] = "textsubjects-container-outer",
            ["i;"] = "textsubjects-container-inner"
          }
        },
      }
      vim.cmd [[
          set foldmethod=expr
          set foldexpr=nvim_treesitter#foldexpr()
          set nofoldenable                     " disable folding at startup.
        ]]
    end
  }
  use {
    "m-demare/hlargs.nvim",
    after = "nvim-treesitter",
    config = function()
      require "hlargs".setup {}
    end
  }
  use {
    "andymass/vim-matchup",
    after = "nvim-treesitter",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end
  }
end

return treesitter
