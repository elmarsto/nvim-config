local treesitter = {}

function treesitter.setup(use)
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require "nvim-treesitter.configs".setup {
        ensure_installed = {
          -- "arduino",
          -- "awk",
          "bash",
          -- "bibtex",
          "c",
          -- "c_sharp",
          -- "capnp",
          -- "clojure",
          -- "cmake",
          -- "comment",
          -- "commonlisp",
          "cpp",
          "css",
          -- "cuda",
          -- "dart",
          "diff",
          "dockerfile",
          -- "dot",
          -- "ebnf",
          -- "elixir",
          -- "elm",
          -- "elvish",
          -- "erlang",
          -- "fennel",
          -- "fish",
          "git_config",
          "git_rebase",
          "gitattributes",
          "gitcommit",
          "gitignore",
          -- "go",
          -- "gomod",
          -- "gosum",
          -- "gowork",
          "graphql",
          -- "haskell_persistent",
          -- "hcl",
          -- "hjson",
          "html",
          "http",
          "hurl",
          "ini",
          -- "janet_simple",
          -- "java",
          "javascript",
          "jq",
          "jsdoc",
          "json",
          -- "json5",
          -- "jsonc",
          -- "jsonnet",
          -- "julia",
          -- "kdl",
          -- "kotlin",
          -- "latex",
          -- "ledger",
          -- "llvm",
          "lua",
          "luadoc",
          "luap",
          "make",
          "markdown",
          "markdown_inline",
          "mermaid",
          "nix",
          -- "norg",
          -- "objc",
          -- "ocaml",
          "passwd",
          "pem",
          -- "perl",
          -- "php",
          -- "phpdoc",
          -- "prisma",
          -- "proto",
          "python",
          "ql",
          -- "qmldir",
          -- "qmljs",
          -- "query",
          -- "racket",
          "regex",
          -- "robot",
          "rst",
          -- "ruby",
          "rust",
          -- "scala",
          -- "scheme",
          "scss",
          -- "solidity",
          "svelte",
          -- "swift",
          -- "tablegen",
          "toml",
          "tsx",
          "typescript",
          "vim",
          "vimdoc",
          -- "vue",
          "yaml",
          -- "zig"
        },
        highlight = {
          enable = true, -- false will disable the whole extension
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            -- TODO: figure out how to move these into keyboard.lua (look up function associated?)
            init_selection = "<CR>",
            node_incremental = "<CR>",
            scope_incremental = "<Tab>",
            scope_decremental = "<S-Tab>",
            node_decremental = "<S-CR>"
          }
        }
      }
      vim.cmd [[
          set foldmethod=expr
          set foldexpr=nvim_treesitter#foldexpr()
          set nofoldenable
      ]]
    end
  }
  use {
    "kylechui/nvim-surround",
    after = {
      "nvim-treesitter",
      "nvim-treesitter-textobjects",
      "leap.nvim" -- This needs to be here so that nvim-surround gets precedence over leap for 'ds*' sequences
    },
    tag = "*",
    config = function()
      require "nvim-surround".setup()
    end
  }
  use { "RRethy/nvim-treesitter-textsubjects",
    after = "nvim-treesitter",
    requires = "nvim-treesitter/nvim-treesitter",
    config = function()
      require 'nvim-treesitter.configs'.setup {
        textsubjects = {
          enable = true,
          prev_selection = ',',
          keymaps = {
            -- TODO: figure out how to move these into keyboard.lua (look up function associated?)
            ["."] = "textsubjects-smart",
            [";"] = "textsubjects-container-outer",
            ["i;"] = "textsubjects-container-inner"
          }
        }
      }
    end
  }
  use { "nvim-treesitter/nvim-treesitter-context",
    after = "nvim-treesitter",
    requires = "nvim-treesitter/nvim-treesitter",
    config = function()
      require 'treesitter-context'.setup {
        enable = true,            -- Enable this plugin (Can be enabled/disabled later via commands)
        max_lines = 0,            -- How many lines the window should span. Values <= 0 mean no limit.
        min_window_height = 0,    -- Minimum editor window height to enable context. Values <= 0 mean no limit.
        line_numbers = true,
        multiline_threshold = 20, -- Maximum number of lines to collapse for a single context line
        trim_scope = 'outer',     -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        mode = 'cursor',          -- Line used to calculate context. Choices: 'cursor', 'topline'
        -- Separator between context and content. Should be a single character string, like '-'.
        -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
        separator = nil,
        zindex = 20,     -- The Z-index of the context window
        on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
      }
    end
  }
  use { "nvim-treesitter/nvim-treesitter-refactor",
    after = "nvim-treesitter",
    requires = "nvim-treesitter/nvim-treesitter",
    config = function()
      require 'nvim-treesitter.configs'.setup {
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
              -- TODO: figure out how to move these into keyboard.lua (look up function associated?)
              smart_rename = "gR"
            }
          },
          navigation = {
            enable = true,
            keymaps = {
              -- TODO: figure out how to move these into keyboard.lua (look up function associated?)
              goto_definition = "gD",
              list_definitions = "gF",
              list_definitions_toc = "go",
              goto_next_usage = "g*",
              goto_previous_usage = "g#"
            }
          }
        },
        indent = {
          enable = true
        },
      }
    end
  }
  use {
    "andymass/vim-matchup",
    after = "nvim-treesitter",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
      require 'nvim-treesitter.configs'.setup {
        matchup = {
          enable = true
        }
      }
    end
  }
  use({
    "nvim-treesitter/nvim-treesitter-textobjects",
    after = { "nvim-treesitter", "nvim-lspconfig" },
    -- requires = { "nvim-treesitter/nvim-treesitter", "neovim/nvim-lspconfig" },
    config = function()
      local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"

      -- Repeat movement with ; and ,
      -- ensure ; goes forward and , goes backward regardless of the last direction
      vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
      vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
      -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
      vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
      vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
      vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
      vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)
      require 'nvim-treesitter.configs'.setup {
        textobjects = {
          lsp_interop = {
            enable = true,
            border = 'none',
            floating_preview_opts = {},
            peek_definition_code = {
              ["<leader>df"] = "@function.outer",
              ["<leader>dF"] = "@class.outer",
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]]"] = { query = "@class.outer", desc = "Next class start" },
              ["]o"] = "@loop.*",
              ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
              ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
              ["]["] = "@class.outer",
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["[["] = "@class.outer",
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              ["[]"] = "@class.outer",
            },
            goto_next = {
              ["]d"] = "@conditional.outer",
            },
            goto_previous = {
              ["[d"] = "@conditional.outer",
            }
          },
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
              ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
            },
            selection_modes = {
              ['@parameter.outer'] = 'v', -- charwise
              ['@function.outer'] = 'V',  -- linewise
              ['@class.outer'] = '<c-v>', -- blockwise
            },
            include_surrounding_whitespace = false,
          },
          swap = {
            enable = true,
            swap_next = {
              ["gs"] = "@parameter.inner",
            },
            swap_previous = {
              ["gS"] = "@parameter.inner",
            },
          },
        }
      }
    end
  })
  use { "Wansmer/treesj",
    after = "nvim-treesitter",
    config = function()
      require('treesj').setup()
      vim.keymap.set(
        'n',
        'gm',
        require('treesj').toggle
      )
      vim.keymap.set('n', 'gM', function()
        require('treesj').toggle({ split = { recursive = true } })
      end)
    end
  }
end

return treesitter
