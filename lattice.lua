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
    use "f3fora/cmp-spell"
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
    use {
      -- TODO: figure out if lua and json below can be handled via lsp
      -- TODO: figure out other languages to add here
      -- NOTE: you should prefer installing LSP formatters when available
      "mhartington/formatter.nvim",
      config = function()
        local ll = require "lattice_local"
        local pretty = {
          function()
            return {
              exe = ll.prettier.bin,
              args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)},
              stdin = true
            }
          end
        }

        require("formatter").setup(
          {
            logging = true,
            filetype = {
              javascript = pretty,
              javascriptreact = pretty,
              typescript = pretty,
              typescriptreact = pretty,
              json = pretty,
              lua = {
                -- luafmt
                function()
                  return {
                    exe = ll.luafmt.bin,
                    args = {"--indent-count", 2, "--stdin"},
                    stdin = true
                  }
                end
              }
            }
          }
        )
        vim.api.nvim_exec(
          -- ignore .js* and .ts* formats (we prefer diagnosticls, which also does this, see lspconfig stanza)
          [[
          augroup FormatAutogroup
            autocmd!
            autocmd BufWritePost *.json,*.lua FormatWrite
          augroup END
        ]],
          true
        )
      end
    }
    use {
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require "trouble".setup {}
      end
    }
    use {
      "glepnir/lspsaga.nvim",
      config = function()
        require "lspsaga".init_lsp_saga()
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
    use "hrsh7th/cmp-nvim-lsp"
    use {
      "hrsh7th/nvim-cmp",
      requires = {"L3MON4D3/LuaSnip"},
      config = function()
        local luasnip = require "luasnip"
        local cmp = require "cmp"
        local has_words_before = function()
          local line, col = unpack(vim.api.nvim_win_get_cursor(0))
          return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end

        cmp.setup(
          {
            completion = {
              autocomplete = false
            },
            snippet = {
              expand = function(args)
                require("luasnip").lsp_expand(args.body)
              end
            },
            mapping = {
              ["<C-n>"] = cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Insert}),
              ["<C-p>"] = cmp.mapping.select_prev_item({behavior = cmp.SelectBehavior.Insert}),
              ["<Down>"] = cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Select}),
              ["<Up>"] = cmp.mapping.select_prev_item({behavior = cmp.SelectBehavior.Select}),
              ["<C-b>"] = cmp.mapping.scroll_docs(-4),
              ["<C-f>"] = cmp.mapping.scroll_docs(4),
              ["<C-e>"] = cmp.mapping.close(),
              ["<CR>"] = cmp.mapping.confirm(
                {
                  behavior = cmp.ConfirmBehavior.Replace,
                  select = true
                }
              ),
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
              {name = "rg"},
              {name = "emoji"},
              {name = "spell"},
              {name = "neorg"},
              {name = "cmp_git"},
              {name = "buffer"},
              {
                name = "dictionary",
                keyword_length = 2
              }
            }
          }
        )
        vim.api.nvim_exec(
          [[
           autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} }) 
          ]],
          false
        )
        vim.opt.spell = true
        vim.opt.spelllang = {"en_us"}
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
    use "kristijanhusak/vim-dadbod-completion"
    use "lambdalisue/suda.vim"
    use "lukas-reineke/cmp-rg"
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
      "nvim-neorg/neorg",
      config = function()
        require("neorg").setup {
          load = {
            ["core.defaults"] = {},
            ["core.norg.concealer"] = {},
            ["core.norg.completion"] = {
              config = {
                engine = "nvim-cmp"
              }
            },
            ["core.norg.dirman"] = {
              config = {
                workspaces = {
                  navaruk = "~/navaruk",
                  vault = "~/vault"
                }
              }
            }
          }
        }
        -- https://github.com/nvim-neorg/neorg/wiki/User-Keybinds
        local neorg_callbacks = require("neorg.callbacks")
        neorg_callbacks.on_event(
          "core.keybinds.events.enable_keybinds",
          function(_, keybinds)
            keybinds.map_event_to_mode(
              "norg",
              {
                n = {
                  {"gtd", "core.norg.qol.todo_items.todo.task_done"},
                  {"gtu", "core.norg.qol.todo_items.todo.task_undone"},
                  {"gtp", "core.norg.qol.todo_items.todo.task_pending"},
                  {"<C-Space>", "core.norg.qol.todo_items.todo.task_cycle"}
                }
              },
              {silent = true, noremap = true}
            )
          end
        )
      end,
      requires = "nvim-lua/plenary.nvim"
    }
    use {
      "neovim/nvim-lspconfig",
      requires = {"hrsh7th/cmp-nvim-lsp"},
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
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
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
          prettier = {
            command = lattice_local.prettier.bin,
            args = {"--stdin-filepath", "%filepath", "--use-tabs", "false", "--tab-width", "2"}
          }
        }
        local formatFiletypes = {
          typescript = "prettier",
          typescriptreact = "prettier"
        }
        nvim_lsp.diagnosticls.setup {
          on_attach = on_attach,
          filetypes = vim.tbl_keys(filetypes),
          capabilities = capabilities,
          init_options = {
            filetypes = filetypes,
            linters = linters,
            formatters = formatters,
            formatFiletypes = formatFiletypes
          }
        } -- end diagnosticls
        nvim_lsp.bashls.setup {
          capabilities = capabilities,
          cmd = {lattice_local.bashls.bin, "start"}
        }
        nvim_lsp.ccls.setup {
          capabilities = capabilities,
          cmd = {lattice_local.ccls.bin}
        }
        nvim_lsp.cmake.setup {
          capabilities = capabilities,
          cmd = {lattice_local.cmake.bin}
        }
        nvim_lsp.cssls.setup {
          capabilities = capabilities,
          cmd = {lattice_local.cssls.bin, "--stdio"}
        }
        nvim_lsp.dotls.setup {
          capabilities = capabilities,
          cmd = {lattice_local.dotls.bin}
        }
        -- nvim_lsp.eslint.setup {
        --   capabilities = capabilities,
        --   cmd = {lattice_local.eslint.bin, "--stdio"}
        -- }
        nvim_lsp.gopls.setup {
          capabilities = capabilities,
          cmd = {lattice_local.gopls.bin}
        }
        nvim_lsp.graphql.setup {
          capabilities = capabilities,
          cmd = {lattice_local.graphql.bin, "server", "-m", "stream"}
        }
        nvim_lsp.hls.setup {
          capabilities = capabilities,
          cmd = {lattice_local.haskellls.bin, "--lsp"}
        }
        nvim_lsp.html.setup {
          capabilities = capabilities,
          cmd = {lattice_local.htmlls.bin, "--stdio"}
        }
        nvim_lsp.jsonls.setup {
          capabilities = capabilities,
          cmd = {lattice_local.jsonls.bin, "--stdio"}
        }
        nvim_lsp.powershell_es.setup {
          capabilities = capabilities,
          bundle = {lattice_local.powershell_es.bundle, "--stdio"}
        }
        nvim_lsp.pyright.setup {
          capabilities = capabilities,
          cmd = {lattice_local.pyls.bin, "--stdio"}
        }
        nvim_lsp.rnix.setup {
          capabilities = capabilities,
          cmd = {lattice_local.rnix.bin}
        }
        -- see above, under simrat39/rust-tools, for embedded lsp config for rust-analyzer
        -- nvim_lsp.stylelint_lsp.setup {
        --   capabilities = capabilities,
        --   cmd = {lattice_local.stylelint_lsp.bin}
        -- }
        local sumneko_runtime_path = vim.split(package.path, ";")
        table.insert(sumneko_runtime_path, "lua/?.lua")
        table.insert(sumneko_runtime_path, "lua/?/init.lua")
        nvim_lsp.sumneko_lua.setup {
          cmd = {lattice_local.sumneko.bin, "-E", lattice_local.sumneko.main},
          capabilities = capabilities,
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
        nvim_lsp.sqls.setup {
          capabilities = capabilities,
          cmd = {lattice_local.sqls.bin, "-config", "~/.config/sqls/sqls.yml"}
        }
        nvim_lsp.svelte.setup {
          capabilities = capabilities,
          cmd = {lattice_local.sveltels.bin}
        }
        nvim_lsp.taplo.setup {
          capabilities = capabilities,
          cmd = {lattice_local.taplo.bin, "run"}
        }
        nvim_lsp.terraformls.setup {
          capabilities = capabilities,
          cmd = {lattice_local.terraformls.bin}
        }
        nvim_lsp.texlab.setup {
          capabilities = capabilities,
          cmd = {lattice_local.texlab.bin}
        }
        nvim_lsp.tsserver.setup {
          capabilities = capabilities,
          cmd = {lattice_local.tsls.bin, "--stdio"},
          filetypes = {
            "javascript",
            "javascriptreact",
            "javascript.jsx",
            "typescript",
            "typescriptreact",
            "typescript.tsx"
          },
          on_attach = function(client)
            client.resolved_capabilities.document_formatting = false
            on_attach(client)
          end
        }

        nvim_lsp.vimls.setup {
          capabilities = capabilities,
          cmd = {lattice_local.vimls.bin}
        }
        nvim_lsp.yamlls.setup {
          capabilities = capabilities,
          cmd = {lattice_local.yamlls.bin}
        }
        nvim_lsp.zeta_note.setup {
          capabilities = capabilities,
          cmd = {lattice_local.zeta_note.bin}
        }
        if vim.fn.has("win32") == 0 then
          nvim_lsp.zk.setup {
            capabilities = capabilities,
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
      "tami5/sqlite.lua",
      config = function()
        local lattice_local = require "lattice_local"
        vim.g.sqlite_clib_path = lattice_local.sqlite.lib -- I also set this below (race condition?)
      end
    }
    use {
      "nvim-telescope/telescope.nvim",
      requires = {
        "nvim-lua/plenary.nvim",
        "nvim-lua/popup.nvim",
        "nvim-telescope/telescope-project.nvim",
        "nvim-telescope/telescope-dap.nvim",
        "nvim-telescope/telescope-hop.nvim",
        "TC72/telescope-tele-tabby.nvim",
        {"nvim-telescope/telescope-fzf-native.nvim", run = require "lattice_local".telescope_fzf_native.run},
        "nvim-telescope/telescope-project.nvim",
        "tami5/sqlite.lua",
        "nvim-telescope/telescope-frecency.nvim",
        "luissimas/telescope-nodescripts.nvim"
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
          pickers = {
            find_files = {
              theme = "dropdown" -- TODO: see https://github.com/nvim-telescope/telescope.nvim#themes
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
        if vim.fn.has("win32") == 0 then
          tscope.load_extension "fzf"
        end
        vim.g.sqlite_clib_path = require "lattice_local".sqlite.lib
        tscope.load_extension "dap"
        tscope.load_extension "frecency"
        tscope.load_extension "hop"
        tscope.load_extension "nodescripts"
        tscope.load_extension "project"
      end
    }
    use {
      "nvim-treesitter/nvim-treesitter",
      config = function()
        local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
        parser_config.diff = {
          install_info = {
            url = "https://github.com/vigoux/tree-sitter-diff",
            files = {"src/parser.c"}
          },
          filetype = "diff"
        }
        parser_config.norg = {
          install_info = {
            url = "https://github.com/nvim-neorg/tree-sitter-norg",
            files = {"src/parser.c", "src/scanner.cc"},
            branch = "main"
          }
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
            "bash",
            "c",
            "c_sharp",
            "cmake",
            "comment",
            "cpp",
            "css",
            "diff",
            "dockerfile",
            "dot",
            "elixir",
            "elm",
            "erlang",
            "go",
            "gomod",
            "graphql",
            "haskell",
            "hjson",
            "html",
            "http",
            "java",
            "javascript",
            "jsdoc",
            "json5",
            "jsonc",
            "julia",
            "latex",
            "ledger",
            "lua",
            "markdown",
            "nix",
            "norg",
            "ocaml",
            "ocaml_interface",
            "perl",
            "php",
            "python",
            "ql",
            "query",
            "regex",
            "rst",
            "ruby",
            "rust",
            "scss",
            "svelte",
            "toml",
            "tsx",
            "typescript",
            "vim",
            "vue",
            "yaml",
            "zig"
          },
          highlight = {
            enable = true, -- false will disable the whole extension
            additional_vim_regex_highlighting = false
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
          },
          textobjects = {
            lsp_interop = {
              enable = true
            },
            move = {
              enable = true
            },
            select = {
              enable = true
            },
            swap = {
              enable = true
            }
          }
        }
      end
    }
    use "nvim-treesitter/nvim-treesitter-textobjects"
    use {"petertriho/cmp-git", requires = "nvim-lua/plenary.nvim"}
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
          "<leader>m",
          "<cmd>lua require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = false })<cr>",
          {}
        )
        vim.api.nvim_set_keymap(
          "n",
          "<leader>M",
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
    use {
      "rcarriga/nvim-dap-ui",
      requires = {"mfussenegger/nvim-dap"},
      config = function()
        require("dapui").setup()
      end
    }
    use {
      "rcarriga/nvim-notify",
      config = function()
        vim.notify = require("notify")
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
        vim.o.sessionoptions = "blank,localoptions,buffers,curdir,tabpages"
      end
    }
    use "saadparwaiz1/cmp_luasnip"
    use "simrat39/symbols-outline.nvim"
    use {
      "simrat39/rust-tools.nvim",
      requires = {
        "mfussenegger/nvim-dap",
        "neovim/nvim-lspconfig",
        "nvim-lua/popup.nvim",
        "nvim-lua/plenary.nvim"
      },
      config = function()
        require("rust-tools").setup(
          {
            -- from https://github.com/simrat39/rust-tools.nvim/issues/72
            server = {
              settings = {
                ["rust-analyzer"] = {
                  unstable_features = true,
                  build_on_save = false,
                  all_features = true,
                  checkOnSave = {
                    enable = true,
                    command = "check",
                    extraArgs = {"--target-dir", "/tmp/rust-analyzer-check"}
                  }
                }
              }
            }
          }
        )
      end
    }

    use "rafcamlet/nvim-luapad"
    use "ray-x/cmp-treesitter"
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
      "tanvirtin/vgit.nvim",
      requires = "nvim-lua/plenary.nvim",
      event = "BufWinEnter",
      config = function()
        require("vgit").setup()
      end
    }
    use "tpope/vim-abolish"
    use "tpope/vim-dadbod"
    use "tpope/vim-fugitive"
    use "tpope/vim-surround"
    use "tversteeg/registers.nvim"
    use "tyru/open-browser.vim"
    use "uga-rosa/cmp-dictionary"
    use {
      "voldikss/vim-floaterm",
      config = function()
        -- shell is other people
        local lls = require "lattice_local".shell
        vim.g.floaterm_shell = lls.bin
        vim.o.shell = lls.bin
        vim.o.shellredir = lls.redir
        vim.o.shellcmdflag = lls.cmdflag
        vim.o.shellpipe = lls.pipe
        vim.o.shellquote = lls.quote
        vim.o.shellxquote = lls.xquote
        vim.api.nvim_set_keymap("n", "", "<CMD>terminal <cr>", {})
      end
    }

    use "wbthomason/packer.nvim" -- self-control
  end
}
