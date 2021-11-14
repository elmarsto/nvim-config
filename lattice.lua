local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
  vim.cmd "packadd packer.nvim"
end
local packer = require "packer"
require "packer.luarocks".install_commands()
packer.startup {
  function(use)
    -- packer.use_rocks {"penlight"}
    use "APZelos/blamer.nvim"
    use "bfredl/nvim-luadev"
    use "chrisbra/csv.vim"
    use "David-Kunz/jester"
    use "dmix/elvish.vim"
    use "ellisonleao/glow.nvim"
    use "embear/vim-localvimrc"
    use "folke/lsp-colors.nvim"
    use {
      "folke/todo-comments.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("todo-comments").setup {
          signs = true, -- show icons in the signs column
          keywords = {
            DONE = {icon = " ", color = "info"},
            TODO = {icon = "⭕", color = "info"},
            IDEA = {icon = "💡", color = "idea"}
          },
          merge_keywords = true, -- when true, custom keywords will be merged with the defaults
          colors = {
            idea = {"IdeaMsg", "#FDFF74"},
            error = {"LspDiagnosticsDefaultError", "ErrorMsg", "#DC2626"},
            warning = {"LspDiagnosticsDefaultWarning", "WarningMsg", "#FBBF24"},
            info = {"LspDiagnosticsDefaultInformation", "#2563EB"},
            hint = {"LspDiagnosticsDefaultHint", "#10B981"},
            default = {"Identifier", "#7C3AED"}
          }
        }
      end
    }
    use "LnL7/vim-nix"
    -- use {
    --   "mhartington/formatter.nvim",
    --   config = function()
        -- require("formatter").setup(
        --   {
        --     logging = true,
        --     filetype = {
        --       typescriptreact = {
        --         function()
        --           return {
        --             exe = lattice_local.,
        --             args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)},
        --             stdin = true
        --           }
        --         end
        --       },
        --       typescript = {
        --         function()
        --           return {
        --             exe = "prettier",
        --             args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)},
        --             stdin = true
        --           }
        --         end
        --       },
        --       javascript = {
        --         function()
        --           return {
        --             exe = "prettier",
        --             args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)},
        --             stdin = true
        --           }
        --         end
        --       },
        --       javascriptreact = {
        --         function()
        --           return {
        --             exe = "prettier",
        --             args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)},
        --             stdin = true
        --           }
        --         end
        --       },
        --       json = {
        --         function()
        --           return {
        --             exe = "prettier",
        --             args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)},
        --             stdin = true
        --           }
        --         end
        --       },
        --       lua = {
        --         -- luafmt
        --         function()
        --           return {
        --             exe = "luafmt",
        --             args = {"--indent-count", 2, "--stdin"},
        --             stdin = true
        --           }
        --         end
        --       }
        --     }
        --   }
        --)
        -- vim.api.nvim_exec(
        --   [[
        --   augroup FormatAutogroup
        --     autocmd!
        --     autocmd BufWritePost *.js,*.rs,*.ts,*.tsx,*.jsx,*.lua FormatWrite
        --   augroup END
        -- ]],
        --   true
        -- )
    --   end
    -- }
    use {
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require "trouble".setup {}
      end
    }
    use { 'glepnir/lspsaga.nvim', config =
      function ()
        require'lspsaga'.init_lsp_saga()
      end
    }
    use {
      "glacambre/firenvim",
      run = function()
        vim.fn["firenvim#install"](0)
      end
    }

    use {
      "glepnir/galaxyline.nvim",
      requires = {"kyazdani42/nvim-web-devicons"},
      config = function()
        require "lattice_line"
      end
    }
    use "godlygeek/tabular"
    use {
      "L3MON4D3/LuaSnip",
      config = function()
        require "luasnip".config.set_config(
          {
            history = true,
            -- Update more often, :h events for more info.
            updateevents = "TextChanged,TextChangedI",
            -- treesitter-hl has 100, use something higher (default is 200).
            ext_base_prio = 300,
            -- minimal increase in priority.
            ext_prio_increase = 1,
            enable_autosnippets = true,
            store_selection_keys = "<Tab>"
          }
        )
      end
    }
    use {
      "hrsh7th/nvim-cmp",
      config = function()
        local luasnip = require "luasnip"
        local cmp = require "cmp"
        local has_words_before = function()
          local line, col = unpack(vim.api.nvim_win_get_cursor(0))
          return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end
        cmp.setup(
          {
            mapping = {
              ["<C-d>"] = cmp.mapping.scroll_docs(-4),
              ["<C-f>"] = cmp.mapping.scroll_docs(4),
              ["<C-Space>"] = cmp.mapping.complete(),
              ["<C-e>"] = cmp.mapping.close(),
              ["<Tab>"] = cmp.mapping(
                function(fallback)
                  if cmp.visible() then
                    cmp.select_next_item()
                  elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                  elseif has_words_before() then
                    cmp.complete()
                  else
                    fallback()
                  end
                end,
                {"i", "s"}
              ),
              ["<S-Tab>"] = cmp.mapping(
                function(fallback)
                  if cmp.visible() then
                    cmp.select_prev_item()
                  elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                  else
                    fallback()
                  end
                end,
                {"i", "s"}
              )
              --   ["<CR>"] = cmp.mapping.confirm({select = true})
            },
            sources = {
              {name = "nvim_lsp"},
              {name = "luasnip"},
              {name = "buffer"}
            }
          }
        )
      end
    }
    use {"ibhagwan/fzf-lua", requires = {"vijaymarupudi/nvim-fzf", "kyazdani42/nvim-web-devicons"}}
    use {
      "jghauser/follow-md-links.nvim",
      config = function()
        require "follow-md-links"
        vim.api.nvim_set_keymap("", "<bs>", ":edit #<cr>", {noremap = true, silent = true})
      end
    }
    use {
      "jose-elias-alvarez/null-ls.nvim",
      config = function()
        require("null-ls").config(
          {
            sources = {require("null-ls").builtins.formatting.stylua}
          }
        )
        require("lspconfig")["null-ls"].setup({})
      end,
      requires = {"nvim-lua/plenary.nvim", "neovim/nvim-lspconfig"}
    }
    use "junegunn/goyo.vim"
    use "junegunn/limelight.vim"
    use "junegunn/seoul256.vim"
    use "kana/vim-textobj-user"
    use {
      "karb94/neoscroll.nvim",
      config = function()
        require("neoscroll").setup(
          {
            mappings = {"<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb"},
            easing_function = "quadratic" -- Default easing function
          }
        )
      end
    }
    use "nvim-lua/plenary.nvim"
    -- use "madskjeldgaard/reaper-nvim"
    use "mbbill/undotree"
    use "mfussenegger/nvim-dap"
    use {
      "norcalli/nvim-colorizer.lua",
      config = function()
        require "colorizer".setup()
      end
    }
    use {
      "norcalli/nvim-terminal.lua",
      config = function()
        require "terminal".setup()
      end
    }
    use "neomake/neomake"
    use {
      "neovim/nvim-lspconfig",
      config = function()
        local lattice_local = require "lattice_local"
        local nvim_lsp = require("lspconfig")
        _G.lsp_organize_imports = function()
          local params = {
            command = "_typescript.organizeImports",
            arguments = {vim.api.nvim_buf_get_name(0)},
            title = ""
          }
          vim.lsp.buf.execute_command(params)
        end
        local on_attach = function(client, bufnr)
          local buf_map = vim.api.nvim_buf_set_keymap
          vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
          vim.cmd("command! LspFormatting lua vim.lsp.buf.formatting()")
          vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
          vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
          vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
          vim.cmd("command! LspOrganize lua lsp_organize_imports()")
          vim.cmd("command! LspRefs lua vim.lsp.buf.references()")
          vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
          vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
          vim.cmd("command! LspDiagPrev lua vim.lsp.diagnostic.goto_prev()")
          vim.cmd("command! LspDiagNext lua vim.lsp.diagnostic.goto_next()")
          vim.cmd("command! LspDiagLine lua vim.lsp.diagnostic.show_line_diagnostics()")
          vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")
          buf_map(bufnr, "n", "gd", ":LspDef<CR>", {silent = true})
          buf_map(bufnr, "n", "gr", ":LspRename<CR>", {silent = true})
          buf_map(bufnr, "n", "gR", ":LspRefs<CR>", {silent = true})
          buf_map(bufnr, "n", "gy", ":LspTypeDef<CR>", {silent = true})
          buf_map(bufnr, "n", "K", ":LspHover<CR>", {silent = true})
          buf_map(bufnr, "n", "gs", ":LspOrganize<CR>", {silent = true})
          buf_map(bufnr, "n", "[a", ":LspDiagPrev<CR>", {silent = true})
          buf_map(bufnr, "n", "]a", ":LspDiagNext<CR>", {silent = true})
          buf_map(bufnr, "n", "ga", ":LspCodeAction<CR>", {silent = true})
          buf_map(bufnr, "n", "<Leader>a", ":LspDiagLine<CR>", {silent = true})
          buf_map(bufnr, "i", "<C-x><C-x>", "<cmd> LspSignatureHelp<CR>", {silent = true})
          if client.resolved_capabilities.document_formatting then
            vim.api.nvim_exec(
              [[
             augroup LspAutocommands
                 autocmd! * <buffer>
                autocmd BufWritePost <buffer> LspFormatting
           augroup END
           ]],
              true
            )
          end
        end
        -- diagnosticls
        local filetypes = {
          javascript = "eslint",
          javascriptreact = "eslint",
          typescript = "eslint",
          typescriptreact = "eslint",
          json = "eslint"
        }
        local linters = {
          eslint = {
            sourceName = "eslint",
            command = lattice_local.eslint.bin,
            rootPatterns = {"package-lock.json", "yarn.lock"},
            debounce = 100,
            args = {"--stdin", "--stdin-filename", "%filepath", "--format", "json"},
            parseJson = {
              errorsRoot = "[0].messages",
              line = "line",
              column = "column",
              endLine = "endLine",
              endColumn = "endColumn",
              message = "${message} [${ruleId}]",
              security = "severity"
            },
            securities = {[2] = "error", [1] = "warning"}
          }
        }
        local formatters = {
           prettier = {command = lattice_local.prettier.bin, args = {"--stdin-filepath", "%filepath", "--use-tabs", "false", "--tab-width", "2"}}
        }
        local formatFiletypes = {
          typescript = "prettier",
          typescriptreact = "prettier"
        }
        nvim_lsp.diagnosticls.setup {
          on_attach = on_attach,
          filetypes = vim.tbl_keys(filetypes),
          init_options = {
            filetypes = filetypes,
            linters = linters,
            formatters = formatters,
            formatFiletypes = formatFiletypes
          }
        } -- end diagnosticls
        nvim_lsp.cssls.setup {
          cmd = {lattice_local.cssls.bin, "--stdio"}
        }
        nvim_lsp.gopls.setup {}
        nvim_lsp.hls.setup {}
        nvim_lsp.html.setup {
          cmd = {lattice_local.htmlls.bin, "--stdio"}
        }
        nvim_lsp.jsonls.setup {
          cmd = {lattice_local.jsonls.bin, "--stdio"}
        }
        nvim_lsp.pyright.setup {}
        nvim_lsp.rnix.setup {}
        -- using simrat39/rust-tools now, which does this for us
        -- nvim_lsp.rust_analyzer.setup {
        --   settings = {
        --     rust = {
        --       unstable_features = true,
        --       build_on_save = false,
        --       all_features = true
        --     }
        --   }
        -- }
        local sumneko_runtime_path = vim.split(package.path, ";")
        table.insert(sumneko_runtime_path, "lua/?.lua")
        table.insert(sumneko_runtime_path, "lua/?/init.lua")
        nvim_lsp.sumneko_lua.setup {
          cmd = {lattice_local.sumneko.bin, "-E", lattice_local.sumneko.main},
          settings = {
            Lua = {
              runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
                -- Setup your lua path
                path = sumneko_runtime_path
              },
              diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {"vim"}
              },
              workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true)
              },
              -- Do not send telemetry data containing a randomized but unique identifier
              telemetry = {
                enable = false
              }
            }
          }
        }
        nvim_lsp.svelte.setup {}
        nvim_lsp.taplo.setup {}
        nvim_lsp.tsserver.setup {
          cmd = {lattice_local.tsls.bin, "--stdio"},
          on_attach = function(client)
            client.resolved_capabilities.document_formatting = false
            on_attach(client)
          end
        }
        nvim_lsp.vimls.setup {}
        nvim_lsp.yamlls.setup {}
        if vim.fn.has("win32") == 0 then
          nvim_lsp.zk.setup {
            cmd = {lattice_local.zk.bin, "lsp"},
            filetypes = {"markdown", "PANDOC", "pandoc"}
          }
        end
      end
    }
    use {
      "numToStr/Comment.nvim",
      config = function()
        require("Comment").setup()
      end
    }
    use "nvim-lua/lsp-status.nvim"
    use {
      "nvim-telescope/telescope.nvim",
      requires = {
        "nvim-lua/plenary.nvim",
        "nvim-lua/popup.nvim",
        "nvim-telescope/telescope-arecibo.nvim",
        "nvim-telescope/telescope-cheat.nvim",
        "nvim-telescope/telescope-node-modules.nvim",
        "nvim-telescope/telescope-frecency.nvim",
        "nvim-telescope/telescope-project.nvim",
        "nvim-telescope/telescope-dap.nvim",
        "nvim-telescope/telescope-github.nvim",
        "nvim-telescope/telescope-media-files.nvim",
        "nvim-telescope/telescope-hop.nvim",
        "TC72/telescope-tele-tabby.nvim",
        {"nvim-telescope/telescope-fzf-native.nvim", run = require "lattice_local".telescope_fzf_native.run},
        {"nvim-telescope/telescope-packer.nvim", requires = "wbthomason/packer.nvim"},
        {"nvim-telescope/telescope-project.nvim", requires = "wbthomason/packer.nvim"},
        "nvim-telescope/telescope-symbols.nvim",
        "nvim-telescope/telescope-z.nvim"
      },
      config = function()
        local tscope = require("telescope")
        tscope.setup {
          defaults = {
            mappings = {
              i = {
                ["<C-h>"] = function(prompt_bufnr)
                  require("telescope").extensions.hop.hop(prompt_bufnr)
                end,
                ["<C-space>"] = function(prompt_bufnr)
                  local opts = {
                    callback = tscope.actions.toggle_selection,
                    loop_callback = tscope.actions.send_selected_to_qflist
                  }
                  require("telescope").extensions.hop._hop_loop(prompt_bufnr, opts)
                end
              }
            }
          },
          extensions = {
            media_files = {
              filetypes = {"png", "webp", "jpg", "jpeg"},
              find_cmd = "rg"
            },
            project = {
              base_dirs = {
                "~/code/"
                --{path = "~/dev/src5", max_depth = 2}
              },
              hidden_files = true -- default: false
            },
            hop = {
              -- the shown `keys` are the defaults, no need to set `keys` if defaults work for you ;)
              keys = {
                "a",
                "s",
                "d",
                "f",
                "g",
                "h",
                "j",
                "k",
                "l",
                ";",
                "q",
                "w",
                "e",
                "r",
                "t",
                "y",
                "u",
                "i",
                "o",
                "p",
                "A",
                "S",
                "D",
                "F",
                "G",
                "H",
                "J",
                "K",
                "L",
                ":",
                "Q",
                "W",
                "E",
                "R",
                "T",
                "Y",
                "U",
                "I",
                "O",
                "P"
              },
              -- Highlight groups to link to signs and lines; the below configuration refers to demo
              -- sign_hl typically only defines foreground to possibly be combined with line_hl
              sign_hl = {"WarningMsg", "Title"},
              -- optional, typically a table of two highlight groups that are alternated between
              line_hl = {"CursorLine", "Normal"},
              -- options specific to `hop_loop`
              -- true temporarily disables Telescope selection highlighting
              clear_selection_hl = false,
              -- highlight hopped to entry with telescope selection highlight
              -- note: mutually exclusive with `clear_selection_hl`
              trace_entry = true,
              -- jump to entry where hoop loop was started from
              reset_selection = true
            }
          }
        }
        tscope.load_extension "arecibo"
        tscope.load_extension "cheat"
        tscope.load_extension "dap"
        if vim.fn.has("win32") == 0 then
          tscope.load_extension "fzf"
        end
        tscope.load_extension "gh"
        if vim.fn.has("unix") then
          tscope.load_extension "media_files"
        end
        tscope.load_extension "hop"
        tscope.load_extension "node_modules"
        -- tscope.load_extension "frecency"
        -- tscope.load_extension "symbols"
        tscope.load_extension "packer"
        tscope.load_extension "project"
        tscope.load_extension "z"
      end
    }
    use {
      "nvim-telescope/telescope-vimspector.nvim",
      requires = "puremourning/vimspector"
    }
    use {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      config = function()
        local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
        parser_config.diff = {
          install_info = {
            url = "https://github.com/vigoux/tree-sitter-diff",
            files = {"src/parser.c"}
          },
          filetype = "diff"
        }
        parser_config.markdown = {
          install_info = {
            url = "https://github.com/ikatyang/tree-sitter-markdown",
            files = {"src/parser.c", "src/scanner.cc"}
          },
          filetype = "markdown"
        }
        require "nvim-treesitter.configs".setup {
          ensure_installed = {
            "c",
            "cpp",
            "css",
            "diff",
            "html",
            "javascript",
            "json",
            "ledger",
            "lua",
            "markdown",
            "nix",
            "python",
            "rust",
            "svelte",
            "typescript",
            "tsx",
            "toml"
          },
          highlight = {
            enable = true, -- false will disable the whole extension
            additional_vim_regex_highlighting = true
          },
          indent = {
            enable = true
          },
          incremental_selection = {
            enable = true,
            keymaps = {
              init_selection = "gnn",
              node_incremental = "grn",
              scope_incremental = "grc",
              node_decremental = "grm"
            }
          }
        }
      end
    }
    use "nvim-treesitter/nvim-treesitter-textobjects"
    use {
      "phaazon/hop.nvim",
      branch = "v1",
      as = "hop",
      config = function()
        require "hop".setup {keys = "etovxqpdygfblzhckisuran"}
        -- place this in one of your configuration file(s)
        vim.api.nvim_set_keymap(
          "n",
          "f",
          "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>",
          {}
        )
        vim.api.nvim_set_keymap(
          "n",
          "F",
          "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>",
          {}
        )
        vim.api.nvim_set_keymap(
          "n",
          "s",
          "<cmd>lua require'hop'.hint_char2({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = false })<cr>",
          {}
        )
        vim.api.nvim_set_keymap(
          "n",
          "S",
          "<cmd>lua require'hop'.hint_char2({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = false })<cr>",
          {}
        )
        vim.api.nvim_set_keymap(
          "n",
          "t",
          "<cmd>lua require'hop'.hint_lines({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = false })<cr>",
          {}
        )
        vim.api.nvim_set_keymap(
          "n",
          "T",
          "<cmd>lua require'hop'.hint_lines({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = false })<cr>",
          {}
        )
        vim.api.nvim_set_keymap(
          "n",
          "m",
          "<cmd>lua require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = false })<cr>",
          {}
        )
        vim.api.nvim_set_keymap(
          "n",
          "M",
          "<cmd>lua require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = false })<cr>",
          {}
        )
        vim.api.nvim_set_keymap(
          "n",
          "<leader>/",
          "<cmd>lua require'hop'.hint_patterns({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = false })<cr>",
          {}
        )
        vim.api.nvim_set_keymap(
          "n",
          "<leader>?",
          "<cmd>lua require'hop'.hint_patterns({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = false })<cr>",
          {}
        )
      end
    }
    use "preservim/vim-colors-pencil"
    use "preservim/vim-lexical"
    use "preservim/vim-litecorrect"
    use "preservim/vim-pencil"
    use "preservim/vim-textobj-quote"
    use "preservim/vim-textobj-sentence"
    use "preservim/vim-wordy"
    use {
      "ptzz/lf.vim",
      requires = "voldikss/vim-floaterm",
      config = function()
        vim.g.lf_map_keys = 0
      end
    }
    use "puremourning/vimspector"
    use {
      "rcarriga/nvim-dap-ui",
      requires = {"mfussenegger/nvim-dap"},
      config = function()
        require("dapui").setup()
      end
    }
    use {
      "rmagatti/auto-session",
      config = function()
        require("auto-session").setup(
          {
            log_level = "error",
            auto_session_enabled = true,
            auto_save_enabled = true,
            auto_restore_enabled = true
          }
        )
        vim.o.sessionoptions = "blank,localoptions,buffers,curdir,folds,help,tabpages,winsize"
      end
    }
    use "simrat39/symbols-outline.nvim"
    use {
      "simrat39/rust-tools.nvim",
      requires = {
        "mfussenegger/nvim-dap",
        "neovim/nvim-lspconfig",
        "nvim-lua/popup.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim"
      },
      config = function()
        require("rust-tools").setup()
      end
    }

    use "rafcamlet/nvim-luapad"
    use {
      "romariorobby/taskell.nvim",
      config = function()
        vim.api.nvim_set_keymap("n", "<leader>tt", ":Taskell<CR>", {silent = true})
      end
    }
    use "sindrets/diffview.nvim"

    use {
      "TimUntersberger/neogit",
      requires = {
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim"
      },
      config = function()
        require "neogit".setup(
          {
            integrations = {
              diffview = true
            }
          }
        )
      end
    }
    use {
      "tami5/sqlite.lua",
      config = function()
        local lattice_local = require "lattice_local"
        vim.g.sqlite_clib_path = lattice_local.sqlite.lib
      end
    }
    use {
      "tanvirtin/vgit.nvim",
      requires = "nvim-lua/plenary.nvim",
      event = "BufWinEnter",
      config = function()
        require("vgit").setup()
      end
    }
    use "tpope/vim-abolish"
    use "tpope/vim-fugitive"
    use "tpope/vim-surround"
    use "tversteeg/registers.nvim"

    use "tyru/open-browser.vim"
    use {
      "voldikss/vim-floaterm",
      config = function()
        vim.g.floaterm_shell = require'lattice_local'.shell.bin
      end
    }

    use "wannesm/wmgraphviz.vim"
    use "wbthomason/packer.nvim" -- self-control
  end
}
vim.api.nvim_set_keymap("n", "", "<CMD>FloatermNew<cr>", {})
