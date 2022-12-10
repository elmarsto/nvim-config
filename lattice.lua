-- FIXME: break this file up into logical morsels

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
    use "APZelos/blamer.nvim"
    use "bfredl/nvim-luadev"
    use "b0o/mapx.nvim"
    use "David-Kunz/jester"
    use "dmix/elvish.vim"
    use "ellisonleao/glow.nvim"
    use {
      "edluffy/specs.nvim",
      config = function()
        require "specs".setup {
          show_jumps = true,
          min_jump = 30,
          popup = {
            delay_ms = 0, -- delay before popup displays
            inc_ms = 10, -- time increments used for fade/resize effects
            blend = 10, -- starting blend, between 0-100 (fully transparent), see :h winblend
            width = 10,
            winhl = "PMenu",
            fader = require("specs").linear_fader,
            resizer = require("specs").shrink_resizer
          },
          ignore_filetypes = {},
          ignore_buftypes = {
            nofile = true
          }
        }
      end
    }
    use "f3fora/cmp-spell"
    use {
      "feline-nvim/feline.nvim",
      config = function()
        local feline = require "feline"
        feline.setup()
        feline.winbar.setup()
      end
    }
    use "folke/lsp-colors.nvim"
    use {
      "folke/todo-comments.nvim",
      config = function()
        require("todo-comments").setup {
          signs = true, -- show icons in the signs column
          keywords = {
            DONE = {icon = " ", color = "success"},
            TODO = {icon = "⭕", color = "warning"},
            IDEA = {icon = "💡", color = "idea"},
            FIXME = {color = "error"}, -- default ladybug emoji
            BUG = {color = "error"}, -- default ladybug emoji
            WARNING = {icon = "⚠️", color = "warning"},
            WARN = {icon = "⚠️", color = "warning"},
            YIKES = {icon = "💢", color = "warning"},
            CONTEXT = {icon = "🌐", color = "info"},
            CHALLENGE = {icon = "👊", color = "default"},
            PITCH = {icon = "✍️", color = "default"},
            FIX = {icon = "⚕️", color = "success"}, -- default ladybug emoji
            FEAT = {icon = "🏆", color = "success"}, -- default ladybug emoji
            NOTE = {color = "info"}
          },
          merge_keywords = true, -- when true, custom keywords will be merged with the defaults
          colors = {
            idea = {"IdeaMsg", "#FDFF74"},
            success = {"SuccessMsg", "#10B981"},
            error = {"LspDiagnosticsDefaultError", "ErrorMsg", "#DC2626"},
            warning = {"LspDiagnosticsDefaultWarning", "WarningMsg", "#FBBF24"},
            info = {"LspDiagnosticsDefaultInformation", "#2563EB"},
            hint = {"LspDiagnosticsDefaultHint", "#10B981"},
            default = {"Identifier", "#7C3AED"}
          }
        }
      end
    }
    use "folke/which-key.nvim"
    use "folke/twilight.nvim"
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
      config = function()
        require "trouble".setup {}
      end
    }
    use "github/copilot.vim"
    use "kristijanhusak/vim-dadbod-ui"
    use {
      "kristijanhusak/vim-dadbod-completion",
      config = function()
        vim.api.nvim_exec(
          [[
            autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })
          ]],
          true
        )
      end
    }
    use {"kyazdani42/nvim-web-devicons"}
    use {
      "lewis6991/gitsigns.nvim",
      config = function()
        require("gitsigns").setup()
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
      requires = {"L3MON4D3/LuaSnip", "kristijanhusak/vim-dadbod-completion"},
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
              {name = "buffer"},
              {name = "cmp_git"},
              {name = "vim-dadbod-completion"},
              {
                name = "dictionary",
                keyword_length = 2
              },
              {name = "digraphs"},
              {name = "emoji"},
              {name = "luasnip"},
              {name = "neorg"},
              {name = "nvim_lsp"},
              {name = "rg"},
              {name = "spell"}
            }
          }
        )
        vim.opt.spell = false
        vim.opt.spelllang = {"en_us"}
      end
    }
    use {"ibhagwan/fzf-lua", requires = {"vijaymarupudi/nvim-fzf"}}
    use {
      "jakewvincent/mkdnflow.nvim",
      config = function()
        vim.cmd("autocmd Filetype markdown set autowriteall")
        require("mkdnflow").setup(
          {
            filetypes = {md = true, rmd = true, markdown = true},
            create_dirs = true,
            perspective = {
              priority = "root",
              fallback = "current",
              root_tell = ".git",
              nvim_wd_heel = true
            },
            wrap = false,
            bib = {
              default_path = nil,
              find_in_root = true
            },
            silent = false,
            links = {
              style = "markdown",
              conceal = false,
              implicit_extension = nil,
              transform_implicit = false,
              transform_explicit = function(text)
                text = text:gsub(" ", "-")
                text = text:lower()
                text = os.date("%Y-%m-%d_") .. text
                return (text)
              end
            },
            to_do = {
              symbols = {" ", ".", "x"},
              update_parents = true,
              not_started = " ",
              in_progress = ".",
              complete = "x"
            },
            tables = {
              trim_whitespace = true,
              format_on_move = true
            },
            use_mappings_table = true,
            mappings = {
              MkdnNextLink = {"n", "<Tab>"},
              MkdnPrevLink = {"n", "<S-Tab>"},
              MkdnNextHeading = {"n", "<leader>]"},
              MkdnPrevHeading = {"n", "<leader>["},
              MkdnGoBack = {"n", "<BS>"},
              MkdnGoForward = {"n", "<Del>"},
              MkdnFollowLink = {{"n", "v"}, "<CR>"},
              MkdnDestroyLink = {"n", "<M-CR>"},
              MkdnMoveSource = {"n", "<F2>"},
              MkdnYankAnchorLink = {"n", "ya"},
              MkdnYankFileAnchorLink = {"n", "yfa"},
              MkdnIncreaseHeading = {"n", "+"},
              MkdnDecreaseHeading = {"n", "-"},
              MkdnToggleToDo = {{"n", "v"}, "<C-Space>"},
              MkdnNewListItem = false,
              MkdnExtendList = false,
              MkdnUpdateNumbering = {"n", "<leader>nn"},
              MkdnTableNextCell = {"i", "<Tab>"},
              MkdnTablePrevCell = {"i", "<S-Tab>"},
              MkdnTableNextRow = false,
              MkdnTablePrevRow = {"i", "<M-CR>"},
              MkdnTableNewRowBelow = {{"n", "i"}, "<leader>ir"},
              MkdnTableNewRowAbove = {{"n", "i"}, "<leader>iR"},
              MkdnTableNewColAfter = {{"n", "i"}, "<leader>ic"},
              MkdnTableNewColBefore = {{"n", "i"}, "<leader>iC"},
              MkdnCR = false,
              MkdnTab = false,
              MkdnSTab = false
            }
          }
        )
      end
    }
    use {
      "jose-elias-alvarez/null-ls.nvim",
      config = function()
        local nls = require "null-ls"
        -- this seemingly-pointless stanza keeps LSP from complaining
        -- in LSP-supported editing sessions where the dominant LS
        -- does not offer Code Actions, e.g. JSON.
        -- Suppresses recurrent/annoying error msg.

        local nullAction = {
          name = "null-action",
          filetypes = {}, -- all filetypes
          method = nls.methods.CODE_ACTION,
          generator = {
            fn = function()
              return {
                {
                  title = "do-nothing",
                  action = function()
                    -- do nothing
                  end
                }
              }
            end
          }
        }
        require("null-ls").setup(
          {
            sources = {
              nullAction
              -- require("null-ls").builtins.formatting.stylua,
              -- require("null-ls").builtins.diagnostics.eslint,
              -- require("null-ls").builtins.completion.spell
            }
          }
        )
      end
    }
    use "junegunn/goyo.vim"
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
    use "lukas-reineke/cmp-rg"
    use "nvim-lua/plenary.nvim"
    use "nvim-lua/popup.nvim"
    -- use "madskjeldgaard/reaper-nvim"
    use "mbbill/undotree"
    use {
      "mfussenegger/nvim-ts-hint-textobject",
      config = function()
        vim.api.nvim_set_keymap("o", "m", "<cmd><C-U>lua require('tsht').nodes()<CR>", {})
        vim.api.nvim_set_keymap("v", "m", "<cmd>lua require('tsht').nodes()<CR>", {})
      end
    }
    use {
      "mrjones2014/legendary.nvim",
      requires = "kkarji/sqlite.lua",
      config = function()
        require("legendary").setup(
          {
            keymaps = {
              {"<leader>tgf", ":Telescope git_files", description = "Telescope Git Files"},
              {"<leader>tgbc", ":Telescope git_bcommits", description = "Telescope Git BCommits"},
              {"<leader>tgc", ":Telescope git_commits", description = "Telescope Git Commits"},
              {"<leader>tgb", ":Telescope git_branches", description = "Telescope Git Branches"},
              {"<leader>tgf", ":Telescope git_files", description = "Telescope Git Files"},
              {"<leader>tld", ":Telescope lsp_definitions", description = "Telescope LSP Definitions"},
              {"<leader>tli", ":Telescope lsp_implementations", description = "Telescope LSP Implementations"},
              {"<leader>tlca", ":Telescope lsp_code_actions", description = "Telescope LSP Code Actions"},
              {"<leader>tlic", ":Telescope lsp_incoming_calls", description = "Telescope LSP Incoming Calls"},
              {"<leader>tloc", ":Telescope lsp_outgoing_calls", description = "Telescope LSP Outgoing Calls"},
              {"<leader>tlr", ":Telescope lsp_references", description = "Telescope LSP References "},
              {"<leader>tltd", ":Telescope lsp_type_definitions", description = "Telescope LSP Type Definitions"},
              {"<leader>tj", ":Telescope jumplist", description = "Telescope Jumplist"},
              {"<leader>tf", ":Telescope frecency", description = "Telescope Frecency"},
              {"<leader>tk", ":Telescope keymaps", description = "Telescope Keymaps"},
              {"<leader>tr", ":Telescope registers", description = "Telescope Registers"},
              {"<leader>tm", ":Telescope marks", description = "Telescope Marks"},
              {"<leader>tp", ":Telescope projects", description = "Telescope Projects"},
              {"<leader>tq", ":Telescope quickfix", description = "Telescope Quickfix"},
              {"<leader>tb", ":Telescope buffers", description = "Telescope Buffers"},
              {"<leader>flf", ":FzfLua files", description = "Fzf Files"},
              {"<leader>flm", ":FzfLua marks", description = "Fzf Marks"},
              {"<leader>flM", ":FzfLua man pages", description = "Fzf Man Pages"},
              {
                "<leader>tldws",
                ":Telescope lsp_dynamic_workspace_symbols",
                description = "Telescope LSP Dynamic Workspace Symbols"
              },
              {
                "<leader>tlws",
                ":Telescope lsp_workspace_symbols",
                description = "Telescope LSP Workspace Symbols"
              },
              {
                "<leader>tlds",
                ":Telescope lsp_document_symbols",
                description = "Telescope LSP Document Symbols"
              },
              {"<leader>Space", ":WhichKey", description = "WhichKey"},
              {"<leader>mc", ":Code", description = "Mode Code"},
              {"<leader>mh", ":Human", description = "Mode Human"},
              {"<leader>mp", ":Prose", description = "Mode Prose"},
              {"<leader>mv", ":Verse", description = "Mode Verse"}
              -- map keys to a function
              -- {
              --   "<leader>h",
              --   function()
              --     print("hello world!")
              --   end,
              --   description = "Say hello"
              -- },
              -- keymaps have opts.silent = true by default, but you can override it
              -- {"<leader>s", ":SomeCommand<CR>", description = "Non-silent keymap", opts = {silent = false}},
              -- create keymaps with different implementations per-mode
              -- {
              --   "<leader>c",
              --   {n = ":LinewiseCommentToggle<CR>", x = ":'<,'>BlockwiseCommentToggle<CR>"},
              --   description = "Toggle comment"
              -- }
              -- -- create item groups to create sub-menus in the finder
              -- -- note that only keymaps, commands, and functions
              -- -- can be added to item groups
              -- {
              --   -- groups with same itemgroup will be merged
              --   itemgroup = "short ID",
              --   description = "A submenu of items...",
              --   icon = "",
              --   keymaps = {}
              -- }
            },
            commands = {},
            funcs = {},
            autocmds = {}
          }
        )
      end
    }
    use {
      "norcalli/nvim-colorizer.lua",
      config = function()
        require "colorizer".setup()
      end
    }
    use {
      "neovim/nvim-lspconfig",
      requires = {"b0o/schemastore.nvim"},
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
        local opts = {noremap = true, silent = true}
        vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
        vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

        local on_attach = function(client, bufnr)
          vim.api.nvim_buf_set_option(bufnr or 0, "omnifunc", "v:lua.vim.lsp.omnifunc")

          -- Mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local bufopts = {noremap = true, silent = true, buffer = bufnr}
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
          vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
          vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
          vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
          vim.keymap.set(
            "n",
            "<space>wl",
            function()
              print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end,
            bufopts
          )
          vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
          vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
          vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
          vim.keymap.set(
            "n",
            "<space>f",
            function()
              vim.lsp.buf.format {async = true}
            end,
            bufopts
          )
        end
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
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
        -- nvim_lsp.dotls.setup {
        --   capabilities = capabilities,
        --   cmd = {lattice_local.dotls.bin}
        -- }
        -- nvim_lsp.eslint.setup {
        --   capabilities = capabilities,
        --   cmd = {lattice_local.eslint.bin, "--stdio"}
        -- }
        -- nvim_lsp.graphql.setup {
        --   capabilities = capabilities,
        --   cmd = {lattice_local.graphql.bin, "server", "-m", "stream"}
        -- }
        nvim_lsp.html.setup {
          capabilities = capabilities,
          cmd = {lattice_local.htmlls.bin, "--stdio"}
        }
        nvim_lsp.jsonls.setup {
          capabilities = capabilities,
          cmd = {lattice_local.jsonls.bin, "--stdio"},
          settings = {
            schemas = require "schemastore".json.schemas(),
            validate = {enable = true}
          }
        }
        -- nvim_lsp.powershell_es.setup {
        --   capabilities = capabilities,
        --   bundle = {lattice_local.powershell_es.bundle, "--stdio"}
        -- }
        nvim_lsp.prosemd_lsp.setup {
          capabilities = capabilities,
          cmd = {lattice_local.prosemd.bin, "--stdio"},
          filetypes = {"markdown"},
          -- root_dir = function(fname)
          --   return vim.lsp.util.find_git_ancestor(fname) or vim.fn.getcwd()
          -- end,
          settings = {}
        }
        nvim_lsp.pyright.setup {
          capabilities = capabilities,
          cmd = {lattice_local.prosemd.bin, "--stdio"}
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
          cmd = {lattice_local.sqls.bin},
          settings = {
            sqls = {
              connections = {lattice_local.sqls.config}
            }
          }
        }
        nvim_lsp.svelte.setup {
          capabilities = capabilities,
          cmd = {lattice_local.sveltels.bin}
        }
        nvim_lsp.taplo.setup {
          capabilities = capabilities,
          cmd = {lattice_local.taplo.bin, "run"}
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
            client.server_capabilities.document_formatting = false
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
      end
    }
    use {
      "numToStr/Comment.nvim",
      config = function()
        require("Comment").setup()
      end
    }
    use "pirmd/gemini.vim"
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
        "elmarsto/telescope-nodescripts.nvim",
        "elmarsto/telescope-symbols.nvim",
        "nvim-telescope/telescope-file-browser.nvim",
        "nvim-telescope/telescope-frecency.nvim",
        "nvim-telescope/telescope-project.nvim",
        "tami5/sqlite.lua",
        "TC72/telescope-tele-tabby.nvim"
      },
      config = function()
        local tscope = require("telescope")
        local ll = require("lattice_local")
        tscope.setup {
          pickers = {},
          extensions = {
            media_files = {
              filetypes = {"png", "webp", "jpg", "jpeg"},
              find_cmd = "rg"
            },
            project = ll.project
          }
        }
        vim.g.sqlite_clib_path = require "lattice_local".sqlite.lib
        tscope.load_extension "file_browser"
        tscope.load_extension "frecency"
        tscope.load_extension "nodescripts"
        tscope.load_extension "project"
      end
    }
    use {
      "nvim-neorg/neorg",
      run = ":Neorg sync-parsers",
      config = function()
        require("neorg").setup {}
      end
    }
    use {
      "nvim-treesitter/nvim-treesitter",
      requires = {
        "danymat/neogen",
        "nvim-treesitter/playground"
      },
      config = function()
        require "neogen".setup {}
        require "nvim-treesitter.configs".setup {
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
          autotag = {
            enable = true
          },
          context_commentstring = {
            enable = true
          },
          highlight = {
            enable = true, -- false will disable the whole extension
            additional_vim_regex_highlighting = false
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
                smart_rename = "grr"
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
              enable = true,
              border = "none",
              peek_definition_code = {
                ["<leader>pf"] = "@function.outer",
                ["<leader>pc"] = "@class.outer"
              }
            },
            textsubjects = {
              enable = true,
              keymaps = {
                ["."] = "textsubjects-smart",
                [";"] = "textsubjects-container-outer"
              }
            },
            move = {
              enable = true,
              set_jumps = true,
              goto_next_start = {
                ["]m"] = "@function.outer",
                ["]]"] = "@class.outer"
              },
              goto_next_end = {
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer"
              },
              goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer"
              },
              goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer"
              }
            },
            select = {
              enable = true,
              lookahead = true,
              keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner"
              }
            },
            swap = {
              enable = true,
              swap_next = {["<leader>xp"] = "@parameter.inner"},
              swap_previous = {["<leader>xP"] = "@parameter.inner"}
            }
          },
          rainbow = {
            enable = true,
            extended_mode = true,
            max_file_lines = nil
          },
          playground = {
            enable = true,
            disable = {},
            updatetime = 25,
            persist_queries = false
          }
        }
      end
    }
    use "petertriho/cmp-git"
    use {
      "phaazon/hop.nvim",
      branch = "v2",
      as = "hop",
      config = function()
        local hop = require("hop")
        hop.setup {keys = "etovxqpdygfblzhckisuran"}
        local directions = require("hop.hint").HintDirection
        vim.keymap.set(
          "",
          "f",
          function()
            hop.hint_char1({direction = directions.AFTER_CURSOR, current_line_only = true})
          end,
          {remap = true}
        )
        vim.keymap.set(
          "",
          "F",
          function()
            hop.hint_char1({direction = directions.BEFORE_CURSOR, current_line_only = true})
          end,
          {remap = true}
        )
        vim.keymap.set(
          "",
          "t",
          function()
            hop.hint_char1({direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1})
          end,
          {remap = true}
        )
        vim.keymap.set(
          "",
          "T",
          function()
            hop.hint_char1({direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1})
          end,
          {remap = true}
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
      "rcarriga/nvim-notify",
      config = function()
        vim.notify = require("notify")
      end
    }
    use {
      "romgrk/nvim-treesitter-context",
      config = function()
        require "treesitter-context".setup {
          enable = true,
          throttle = true,
          max_lines = 0,
          patterns = {
            default = {
              "class",
              "function",
              "method",
              "for",
              "while",
              "if",
              "switch",
              "case"
            }
            -- e.g. of lang-specific
            -- rust = { 'impl_item' }
          }
        }
        vim.cmd [[
          highlight TreesitterContext cterm=italic gui=italic
        ]]
      end
    }
    use "saadparwaiz1/cmp_luasnip"
    use {
      "simrat39/symbols-outline.nvim",
      config = function()
        require("symbols-outline").setup()
      end
    }
    use {
      "simrat39/rust-tools.nvim",
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
    use {
      "smjonas/inc-rename.nvim",
      config = function()
        require "inc_rename".setup()
      end
    }
    use "rafcamlet/nvim-luapad"
    use "ray-x/cmp-treesitter"
    use {
      "ruifm/gitlinker.nvim",
      config = function()
        require "gitlinker".setup()
      end
    }
    use "sindrets/diffview.nvim"
    use {
      "stevearc/aerial.nvim",
      config = function()
        require("aerial").setup(
          {
            on_attach = function(bufnr) -- copypasta https://github.com/stevearc/aerial.nvim
              -- Toggle the aerial window with <leader>a
              vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>a", "<cmd>AerialToggle!<CR>", {})
              -- Jump forwards/backwards with '{' and '}'
              vim.api.nvim_buf_set_keymap(bufnr, "n", "{", "<cmd>AerialPrev<CR>", {})
              vim.api.nvim_buf_set_keymap(bufnr, "n", "}", "<cmd>AerialNext<CR>", {})
              -- Jump up the tree with '[[' or ']]'
              vim.api.nvim_buf_set_keymap(bufnr, "n", "[[", "<cmd>AerialPrevUp<CR>", {})
              vim.api.nvim_buf_set_keymap(bufnr, "n", "]]", "<cmd>AerialNextUp<CR>", {})
            end
          }
        )
      end
    }
    use {
      "TimUntersberger/neogit",
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
    use "tpope/vim-abolish"
    use "tpope/vim-dadbod"
    use "tpope/vim-fugitive"
    use "tpope/vim-surround"
    use "tversteeg/registers.nvim"
    use "tyru/open-browser.vim"
    -- -- TODO: get dictionary file so this is useful
    -- use {
    --   "uga-rosa/cmp-dictionary",
    --   config = function()
    --     local ll = require "lattice_local"
    --     require("cmp_dictionary").setup(
    --       {
    --         dic = {
    --           ["*"] = ll.dictionary.file
    --         }
    --       }
    --     )
    --   end
    -- }
    use "wbthomason/packer.nvim" -- self-control
    use {
      "zegervdv/settle.nvim",
      opt = true,
      cmd = {"SettleInit"},
      config = function()
        require("settle").setup {
          wrap = true,
          symbol = "!",
          keymaps = {
            next_conflict = "-n",
            prev_conflict = "-N",
            use_ours = "-u1",
            use_theirs = "-u2",
            close = "-q"
          }
        }
      end
    }
  end
}
local lls = require "lattice_local".shell
vim.o.shell = lls.bin
vim.o.shellredir = lls.redir
vim.o.shellcmdflag = lls.cmdflag
vim.o.shellpipe = lls.pipe
vim.o.shellquote = lls.quote
vim.o.shellxquote = lls.xquote
vim.wo.foldlevel = 6
vim.api.nvim_set_keymap("n", "<leader>z", "<CMD>terminal <cr>", {})
if vim.fn.has("win32") == 1 then
  vim.api.nvim_set_keymap("n", "", "<CMD>terminal <cr>", {})
end

local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node

local date_input = function(_, _, fmt)
  local form = fmt or "%Y-%m-%d"
  return sn(nil, i(1, os.date(form)))
end

-- TODO: dry out; can we have the user choose the register
ls.add_snippets(
  "all",
  {
    s("now", {d(1, date_input, {})}),
    s(
      "ln",
      {
        t "[",
        i(1),
        t("]("),
        i(2),
        t(")"),
        i(0)
      }
    ),
    s(
      "ln.",
      {
        t "[",
        i(1),
        t("]("),
        f(
          function(_)
            local dotreg = vim.fn.getreg(".") or "."
            return vim.fn.getreg(dotreg) or {}
          end,
          {}
        ),
        t(")"),
        i(0)
      }
    ),
    s(
      "ln*",
      {
        t "[",
        i(1),
        t("]("),
        f(
          function(_)
            return vim.fn.getreg("*") or {}
          end,
          {}
        ),
        t(")"),
        i(0)
      }
    ),
    s(
      "ln-",
      {
        t "[",
        i(1),
        t("]("),
        f(
          function(_)
            return vim.fn.getreg("-") or {}
          end,
          {}
        ),
        t(")"),
        i(0)
      }
    ),
    s(
      "ln/",
      {
        t "[",
        i(1),
        t("]("),
        f(
          function(_)
            return vim.fn.getreg("/") or {}
          end,
          {}
        ),
        t(")"),
        i(0)
      }
    ),
    s(
      "ln0",
      {
        t "[",
        i(1),
        t("]("),
        f(
          function(_)
            return vim.fn.getreg("0") or {}
          end,
          {}
        ),
        t(")"),
        i(0)
      }
    ),
    s(
      "ln+",
      {
        t "[",
        i(1),
        t("]("),
        f(
          function(_)
            return vim.fn.getreg("+") or {}
          end,
          {}
        ),
        t(")"),
        i(0)
      }
    ),
    s(
      'ln"',
      {
        t "[",
        i(1),
        t("]("),
        f(
          function(_)
            return vim.fn.getreg('"') or {}
          end,
          {}
        ),
        t(")"),
        i(0)
      }
    ),
    s(
      "Xx",
      {
        t "- [",
        i(0),
        t "] ",
        i(1)
      }
    ),
    s(
      "ln://",
      {
        t('<a href="'),
        f(
          function(_, snip)
            return snip.env.TM_SELECTED_TEXT[1] or {}
          end,
          {}
        ),
        t('">'),
        i(1),
        t("</a>"),
        i(0)
      }
    )
  }
)

vim.cmd [[
  autocmd BufWinEnter *.html iabbrev --- &mdash;
  autocmd BufWinEnter *.svelte iabbrev --- &mdash;
  autocmd BufWinEnter *.jsx iabbrev --- &mdash;
  autocmd BufWinEnter *.tsx iabbrev --- &mdash;
  autocmd BufWinEnter *.norg inoremap <M-CR> <End><CR>- [ ] 
  autocmd BufWinEnter *.md inoremap <M-CR> <End><CR>- [ ] 
]]
