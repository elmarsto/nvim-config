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
    use "David-Kunz/jester"
    use "dmix/elvish.vim"
    use "ellisonleao/glow.nvim"
    use "f3fora/cmp-spell"
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
      config = function()
        require "trouble".setup {}
      end
    }
    -- use {
    --   "NTBBloodbath/galaxyline.nvim",
    --   config = function()
    --     require "lattice_line"
    --   end
    -- }
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
      requires = {"L3MON4D3/LuaSnip", "dmitmel/cmp-digraphs", "kristijanhusak/vim-dadbod-completion"},
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
      "jghauser/follow-md-links.nvim",
      config = function()
        require "follow-md-links"
        vim.api.nvim_set_keymap("", "<bs>", ":edit #<cr>", {noremap = true, silent = true})
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
    use "lambdalisue/suda.vim"
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

    use "mfussenegger/nvim-dap"
    use {
      "norcalli/nvim-colorizer.lua",
      config = function()
        require "colorizer".setup()
      end
    }
    use {
      "nvim-neorg/neorg",
      requires = "nvim-neorg/neorg-telescope",
      config = function()
        local ll = require "lattice_local"
        require("neorg").setup {
          load = {
            ["core.defaults"] = {},
            ["core.norg.concealer"] = {},
            ["core.gtd.base"] = {
              config = {
                workspace = ll.neorg.gtd
              }
            },
            ["core.keybinds"] = {
              config = {
                default_keybinds = false
              }
            },
            ["core.norg.completion"] = {
              config = {
                engine = "nvim-cmp"
              }
            },
            ["core.integrations.telescope"] = {},
            ["core.norg.dirman"] = {
              config = {
                workspaces = ll.neorg.workspaces
              }
            }
          },
          hook = function()
            -- https://github.com/nvim-neorg/neorg/wiki/User-Keybinds
            local neorg_callbacks = require("neorg.callbacks")
            neorg_callbacks.on_event(
              "core.keybinds.events.enable_keybinds",
              function(_, keybinds)
                keybinds.map_event_to_mode(
                  "norg",
                  {
                    n = {
                      -- Bind keys in normal mode
                      -- Keys for managing TODO items and setting their states
                      {"gtu", "core.norg.qol.todo_items.todo.task_undone"},
                      {"gtp", "core.norg.qol.todo_items.todo.task_pending"},
                      {"gtd", "core.norg.qol.todo_items.todo.task_done"},
                      {"th", "core.norg.qol.todo_items.todo.task_on_hold"},
                      {"tc", "core.norg.qol.todo_items.todo.task_cancelled"},
                      {"tr", "core.norg.qol.todo_items.todo.task_recurring"},
                      {"ti", "core.norg.qol.todo_items.todo.task_important"},
                      {"<C-Space>", "core.norg.qol.todo_items.todo.task_cycle"},
                      -- Keys for managing GTD
                      {"gtc", "core.gtd.base.capture"},
                      {"gtv", "core.gtd.base.views"},
                      {"gte", "core.gtd.base.edit"},
                      -- Keys for managing notes
                      {"nn", "core.norg.dirman.new.note"},
                      {"<CR>", "core.norg.esupports.hop.hop-link"},
                      {"<S-CR>", "core.norg.esupports.hop.hop-link", "vsplit"},
                      {"<M-k>", "core.norg.manoeuvre.item_up"},
                      {"<M-j>", "core.norg.manoeuvre.item_down"},
                      -- mnemonic: markup toggle
                      {"mt", "core.norg.concealer.toggle-markup"},
                      {"<C-s>", "core.integrations.telescope.find_linkable"}
                    },
                    o = {
                      {"ah", "core.norg.manoeuvre.textobject.around-heading"},
                      {"ih", "core.norg.manoeuvre.textobject.inner-heading"},
                      {"at", "core.norg.manoeuvre.textobject.around-tag"},
                      {"it", "core.norg.manoeuvre.textobject.inner-tag"},
                      {"al", "core.norg.manoeuvre.textobject.around-whole-list"}
                    },
                    i = {
                      {"<C-l>", "core.integrations.telescope.insert_link"}
                    }
                  },
                  {silent = true, noremap = true}
                )
              end
            )
          end
        }
      end
    }
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
      end
    }
    use {
      "numToStr/Comment.nvim",
      config = function()
        require("Comment").setup()
      end
    }
    -- use "nvim-lua/lsp-status.nvim"
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
        "nvim-telescope/telescope-dap.nvim",
        "nvim-telescope/telescope-file-browser.nvim",
        "nvim-telescope/telescope-frecency.nvim",
        {"nvim-telescope/telescope-fzf-native.nvim", run = require "lattice_local".telescope_fzf_native.run},
        "nvim-telescope/telescope-hop.nvim",
        "nvim-telescope/telescope-project.nvim",
        "tami5/sqlite.lua",
        "TC72/telescope-tele-tabby.nvim"
      },
      config = function()
        local tscope = require("telescope")
        local ll = require("lattice_local")
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
              theme = "ivy" -- TODO: see https://github.com/nvim-telescope/telescope.nvim#themes
            }
          },
          extensions = {
            media_files = {
              filetypes = {"png", "webp", "jpg", "jpeg"},
              find_cmd = "rg"
            },
            project = ll.project,
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
        tscope.load_extension "file_browser"
      end
    }
    use {
      "nvim-treesitter/nvim-treesitter",
      requires = {
        "JoosepAlviste/nvim-ts-context-commentstring",
        "p00f/nvim-ts-rainbow",
        "RRethy/nvim-treesitter-textsubjects",
        "nvim-treesitter/nvim-treesitter-textobjects",
        "nvim-treesitter/nvim-treesitter-refactor",
        "nvim-treesitter/playground",
        "windwp/nvim-ts-autotag"
      },
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
      branch = "v1",
      as = "hop",
      config = function()
        require "hop".setup {keys = "etovxqpdygfblzhckisuran"}
        -- place this in one of your configuration file(s)
        vim.api.nvim_set_keymap(
          "n",
          "<C-h>1",
          "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>",
          {}
        )
        vim.api.nvim_set_keymap(
          "n",
          "<C-h>!",
          "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>",
          {}
        )
        vim.api.nvim_set_keymap(
          "n",
          "<C-h>2",
          "<cmd>lua require'hop'.hint_char2({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = false })<cr>",
          {}
        )
        vim.api.nvim_set_keymap(
          "n",
          "<C-h>@",
          "<cmd>lua require'hop'.hint_char2({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = false })<cr>",
          {}
        )
        vim.api.nvim_set_keymap(
          "n",
          "<C-h>l",
          "<cmd>lua require'hop'.hint_lines({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = false })<cr>",
          {}
        )
        vim.api.nvim_set_keymap(
          "n",
          "<C-h>L",
          "<cmd>lua require'hop'.hint_lines({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = false })<cr>",
          {}
        )
        vim.api.nvim_set_keymap(
          "n",
          "<C-h>w",
          "<cmd>lua require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = false })<cr>",
          {}
        )
        vim.api.nvim_set_keymap(
          "n",
          "<C-h>W",
          "<cmd>lua require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = false })<cr>",
          {}
        )
        vim.api.nvim_set_keymap(
          "n",
          "<C-h>/",
          "<cmd>lua require'hop'.hint_patterns({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = false })<cr>",
          {}
        )
        vim.api.nvim_set_keymap(
          "n",
          "<C-h>?",
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
      "rcarriga/nvim-dap-ui",
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
    use "simrat39/symbols-outline.nvim"
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
