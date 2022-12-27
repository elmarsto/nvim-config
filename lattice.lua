-- FIXME: break this file up into logical morsels

local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
  vim.cmd "packadd packer.nvim"
end
local packer = require "packer"
require "packer.luarocks".install_commands()
packer.startup {
  function(use)
    use "APZelos/blamer.nvim"
    use "bfredl/nvim-luadev"
    use {
      "b0o/mapx.nvim",
      config = function()
        require 'mapx'.setup { global = "force", whichkey = true }
      end
    }
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
    use "folke/lsp-colors.nvim"
    use {
      "folke/todo-comments.nvim",
      config = function()
        require("todo-comments").setup {
          signs = true, -- show icons in the signs column
          keywords = {
            DONE = { icon = " ", color = "success" },
            TODO = { icon = "⭕", color = "warning" },
            IDEA = { icon = "💡", color = "idea" },
            FIXME = { color = "error" }, -- default ladybug emoji
            BUG = { color = "error" }, -- default ladybug emoji
            WARNING = { icon = "⚠️", color = "warning" },
            WARN = { icon = "⚠️", color = "warning" },
            YIKES = { icon = "💢", color = "warning" },
            CONTEXT = { icon = "🌐", color = "info" },
            CHALLENGE = { icon = "👊", color = "default" },
            PITCH = { icon = "✍️", color = "default" },
            FIX = { icon = "⚕️", color = "success" }, -- default ladybug emoji
            FEAT = { icon = "🏆", color = "success" }, -- default ladybug emoji
            NOTE = { color = "info" }
          },
          merge_keywords = true, -- when true, custom keywords will be merged with the defaults
          colors = {
            idea = { "IdeaMsg", "#FDFF74" },
            success = { "SuccessMsg", "#10B981" },
            error = { "LspDiagnosticsDefaultError", "ErrorMsg", "#DC2626" },
            warning = { "LspDiagnosticsDefaultWarning", "WarningMsg", "#FBBF24" },
            info = { "LspDiagnosticsDefaultInformation", "#2563EB" },
            hint = { "LspDiagnosticsDefaultHint", "#10B981" },
            default = { "Identifier", "#7C3AED" }
          }
        }
      end
    }
    use "folke/which-key.nvim"
    use "folke/twilight.nvim"
    use {
      "folke/trouble.nvim",
      config = function()
        require "trouble".setup {}
      end
    }
    use { "GCBallesteros/vim-textobj-hydrogen",
      config = function()
        -- https://www.maxwellrules.com/misc/nvim_jupyter.html
        vim.cmd [[
           nmap ]x ctrih/^# %%<CR><CR> 
        ]]
      end
    }
    use {
      "GCBallesteros/jupytext.vim",
      config = function()
        -- https://www.maxwellrules.com/misc/nvim_jupyter.html
        vim.cmd [[
          let g:jupytext_fmt = 'py'
          let g:jepytext_style = 'hydrogen'
        ]]
      end
    }
    use "github/copilot.vim"
    use { "hkupty/iron.nvim",
      config = function()
        require 'iron.core'.setup {
          config = {
            -- Whether a repl should be discarded or not
            scratch_repl = true,
            -- Your repl definitions come here
            repl_definition = {
              sh = {
                -- Can be a table or a function that
                -- returns a table (see https://github.com/hkupty/iron.nvim)
                command = { "nsh" }
              },
              -- https://www.maxwellrules.com/misc/nvim_jupyter.html
              python = {
                command = { "ipython" },
                format = require("iron.fts.common").bracketed_paste
              }

            },
            -- How the repl window will be displayed
            -- See below for more information
            repl_open_cmd = require('iron.view').bottom(40),
          },
          -- Iron doesn't set keymaps by default anymore.
          -- You can set them here or manually add keymaps to the functions in iron.core
          keymaps = {
            send_motion = "<space>sc",
            visual_send = "<space>sc",
            send_file = "<space>sf",
            send_line = "<space>sl",
            send_mark = "<space>sm",
            mark_motion = "<space>mc",
            mark_visual = "<space>mc",
            remove_mark = "<space>md",
            cr = "<space>s<cr>",
            interrupt = "<space>s<space>",
            exit = "<space>sq",
            clear = "<space>cl",
          },
          -- If the highlight is on, you can change how it looks
          -- For the available options, check nvim_set_hl
          highlight = {
            italic = true
          },
          ignore_blank_lines = true,

        }
        -- iron also has a list of commands, see :h iron-commands for all available commands
        vim.keymap.set('n', '<space>rs', '<cmd>IronRepl<cr>')
        vim.keymap.set('n', '<space>rr', '<cmd>IronRestart<cr>')
        vim.keymap.set('n', '<space>rf', '<cmd>IronFocus<cr>')
        vim.keymap.set('n', '<space>rh', '<cmd>IronHide<cr>')
      end
    }

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
    use { "kyazdani42/nvim-web-devicons" }
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
      "lewis6991/gitsigns.nvim",
      config = function()
        require("gitsigns").setup()
      end
    }
    use "hrsh7th/cmp-nvim-lsp"
    use {
      "hrsh7th/nvim-cmp",
      requires = { "L3MON4D3/LuaSnip", "kristijanhusak/vim-dadbod-completion" },
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
              ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
              ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
              ["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
              ["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
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
                { "i", "s" }
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
                { "i", "s" }
              )
              --   ["<CR>"] = cmp.mapping.confirm({select = true})
            },
            sources = {
              { name = "buffer" },
              { name = "cmp_git" },
              { name = "vim-dadbod-completion" },
              {
                name = "dictionary",
                keyword_length = 2
              },
              { name = "digraphs" },
              { name = "emoji" },
              { name = "luasnip" },
              { name = "neorg" },
              { name = "nvim_lsp" },
              { name = "rg" },
              { name = "spell" }
            }
          }
        )
        vim.opt.spell = false
        vim.opt.spelllang = { "en_us" }
      end
    }
    use {
      "jakewvincent/mkdnflow.nvim",
      config = function()
        vim.cmd("autocmd Filetype markdown set autowriteall")
        require("mkdnflow").setup(
          {
            filetypes = { md = true, rmd = true, markdown = true },
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
              symbols = { " ", ".", "x" },
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
              MkdnNextLink = { "n", "<Tab>" },
              MkdnPrevLink = { "n", "<S-Tab>" },
              MkdnNextHeading = { "n", "<leader>]" },
              MkdnPrevHeading = { "n", "<leader>[" },
              MkdnGoBack = { "n", "<BS>" },
              MkdnGoForward = { "n", "<Del>" },
              MkdnFollowLink = { { "n", "v" }, "<CR>" },
              MkdnDestroyLink = { "n", "<M-CR>" },
              MkdnMoveSource = { "n", "<F2>" },
              MkdnYankAnchorLink = { "n", "ya" },
              MkdnYankFileAnchorLink = { "n", "yfa" },
              MkdnIncreaseHeading = { "n", "+" },
              MkdnDecreaseHeading = { "n", "-" },
              MkdnToggleToDo = { { "n", "v" }, "<C-Space>" },
              MkdnNewListItem = false,
              MkdnExtendList = false,
              MkdnUpdateNumbering = { "n", "<leader>nn" },
              MkdnTableNextCell = { "i", "<Tab>" },
              MkdnTablePrevCell = { "i", "<S-Tab>" },
              MkdnTableNextRow = false,
              MkdnTablePrevRow = { "i", "<M-CR>" },
              MkdnTableNewRowBelow = { { "n", "i" }, "<leader>ir" },
              MkdnTableNewRowAbove = { { "n", "i" }, "<leader>iR" },
              MkdnTableNewColAfter = { { "n", "i" }, "<leader>ic" },
              MkdnTableNewColBefore = { { "n", "i" }, "<leader>iC" },
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
    use "kana/vim-textobj-line"
    use {
      "karb94/neoscroll.nvim",
      config = function()
        require("neoscroll").setup(
          {
            mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
            easing_function = "quadratic" -- Default easing function
          }
        )
      end
    }
    use "lukas-reineke/cmp-rg"
    use {
      "nvim-lualine/lualine.nvim",
      requires = { 'kyazdani42/nvim-web-devicons', opt = true },
      config = function()
        require 'lualine'.setup {
          options = {
            theme = "everforest"
          }
        }
      end
    }
    use "nvim-lua/plenary.nvim"
    use "nvim-lua/popup.nvim"
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
        require("legendary").setup(
          {
            keymaps = {
              { "<C-P>", ":Legendary<cr>", description = "Legendary (Meta!)" },
              { "<leader>te",
                function()
                  require 'telescope.builtin'.symbols { sources = { "emoji" } }
                end,
                description = "Emojis"
              },
              { "<C-Space>", ":WhichKey<cr>", description = "WhichKey" },
              { "<M-Left>", ":tabprev<cr>", description = "Prev Tab" },
              { "<M-Right>", ":tabnext<cr>", description = "Next Tab" },
              { "<M-Down>", ":tablast<cr>", description = "Last Tab" },
              { "<M-Up>", ":tabfirst<cr>", description = "First Tab" },
              { "<M-/>", ":Telescope live_grep<cr>", description = "Live Grep" },
              { "<M-?>", ":Telescope search_history<cr>", description = "Search History" },
              { "<M-;>", ":Telescope command_history<cr>", description = "Command History" },
              { "<M-,>", ":Telescope vim_options<cr>", description = "Vim Options" },
              { "<M-.>", ":Telescope commands<cr>", description = "Telescope Commands" },
              { "<leader>,", ":Telescope loclist<cr>", description = "Telescope Loclist" },
              { "<leader>z", ":Telescope current_buffer_fuzzy_find<cr>",
                description = "Telescope Current Buffer Fuzzy Find" },
              { "<M-CR>", ":Telescope find_files<cr>", description = "Telescope Git_Files" },
              { "<leader><CR>", ":Telescope git_files<cr>", description = "Git Files" },
              { "<leader><leader><CR>", ":Telescope git_branches<cr>", description = "Git Branches" },
              { "<C-M>", ":Telescope find_files<cr>", description = "Git Files" },
              { "<leader><Space>", ":Trouble<cr>", description = "Trouble" },
              { "<F3>", ":UndotreeToggle<cr>", description = "UndoTree" },
              { "<leader>jrf", require 'jester'.run_last, description = "Jester Run File" },
              { "<leader>jra", require 'jester'.run_last, description = "Jester Run Again" },
              { "<leader>jrA", require 'jester'.run, description = "Jester Run All" },
              { "<leader>tgf", ":Telescope git_files<cr>", description = "Telescope Git Files" },
              { "<leader>tgbc", ":Telescope git_bcommits<cr>", description = "Telescope Git BCommits" },
              { "<leader>tgc", ":Telescope git_commits<cr>", description = "Telescope Git Commits" },
              { "<leader>tR", ":Telescope reloader<cr>", description = "Telescope Reloader" },
              { "<leader>tgb", ":Telescope git_branches<cr>", description = "Telescope Git Branches" },
              { "<leader>tgf", ":Telescope git_files<cr>", description = "Telescope Git Files" },
              { "<leader>tld", ":Telescope lsp_definitions<cr>", description = "Telescope LSP Definitions" },
              { "<leader>tli", ":Telescope lsp_implementations<cr>", description = "Telescope LSP Implementations" },
              { "<leader>tlca", ":Telescope lsp_code_actions<cr>", description = "Telescope LSP Code Actions" },
              { "<leader>tlic", ":Telescope lsp_incoming_calls<cr>", description = "Telescope LSP Incoming Calls" },
              { "<leader>tloc", ":Telescope lsp_outgoing_calls<cr>", description = "Telescope LSP Outgoing Calls" },
              { "<leader>tlr", ":Telescope lsp_references<cr>", description = "Telescope LSP References " },
              { "<leader>tltd", ":Telescope lsp_type_definitions<cr>", description = "Telescope LSP Type Definitions" },
              { "<leader>tj", ":Telescope jumplist<cr>", description = "Telescope Jumplist" },
              { "<leader>tf", ":Telescope frecency<cr>", description = "Telescope Frecency" },
              { "<leader>tk", ":Telescope keymaps<cr>", description = "Telescope Keymaps" },
              { "<leader>tr", ":Telescope registers<cr>", description = "Telescope Registers" },
              { "<leader>tm", ":Telescope marks<cr>", description = "Telescope Marks" },
              { "<leader>tp", ":Telescope projects<cr>", description = "Telescope Projects" },
              { "<leader>tq", ":Telescope quickfix<cr>", description = "Telescope Quickfix" },
              { "<C-tab>", ":Telescope buffers<cr>", description = "Telescope Buffers" },
              {
                "<leader>tldws",
                ":Telescope lsp_dynamic_workspace_symbols<cr>",
                description = "Telescope LSP Dynamic Workspace Symbols"
              },
              {
                "<leader>tlws",
                ":Telescope lsp_workspace_symbols<cr>",
                description = "Telescope LSP Workspace Symbols"
              },
              {
                "<leader>tlds",
                ":Telescope lsp_document_symbols<cr>",
                description = "Telescope LSP Document Symbols"
              },
              { "<leader>mc", ":Code<cr>", description = "Mode Code" },
              { "<leader>mh", ":Human<cr>", description = "Mode Human" },
              { "<leader>mp", ":Prose<cr>", description = "Mode Prose" },
              { "<leader>mv", ":Verse<cr>", description = "Mode Verse" },
              { "<leader>mb", ":Boethius<cr>", description = "Mode Boethius" },
              { '<C-W>"', ":sp<cr>", description = "Split along X axis" },
              { '<C-W>%', ":vs<cr>", description = "Split along Y axis" },
            },
            commands = {},
            funcs = {},
            autocmds = {},
          })
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
      requires = {
        { "b0o/schemastore.nvim" },
        { "lukas-reineke/lsp-format.nvim" },
      },
      config = function()
        local lattice_local = require "lattice_local"
        local nvim_lsp = require("lspconfig")
        _G.lsp_organize_imports = function()
          local params = {
            command = "_typescript.organizeImports",
            arguments = { vim.api.nvim_buf_get_name(0) },
            title = ""
          }
          vim.lsp.buf.execute_command(params)
        end
        local opts = { noremap = true, silent = true }
        vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
        vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

        require 'lsp-format'.setup {}
        -- declare local in this scope so we don't `require` every run of on_attach below
        local formatAttach = require "lsp-format".on_attach
        local on_attach = function(client, bufnr)
          client.server_capabilities.document_formatting = true
          formatAttach(client)

          vim.api.nvim_buf_set_option(bufnr or 0, "omnifunc", "v:lua.vim.lsp.omnifunc")

          -- Mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local bufopts = { noremap = true, silent = true, buffer = bufnr }
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
              vim.lsp.buf.format { async = true }
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
            rootPatterns = { "package-lock.json", "yarn.lock" },
            debounce = 100,
            args = { "--stdin", "--stdin-filename", "%filepath", "--format", "json" },
            parseJson = {
              errorsRoot = "[0].messages",
              line = "line",
              column = "column",
              endLine = "endLine",
              endColumn = "endColumn",
              message = "${message} [${ruleId}]",
              security = "severity"
            },
            securities = { [2] = "error", [1] = "warning" }
          }
        }
        local formatters = {
          prettier = {
            command = lattice_local.prettier.bin,
            args = { "--stdin-filepath", "%filepath", "--use-tabs", "false", "--tab-width", "2" }
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
          on_attach = on_attach,
          capabilities = capabilities,
          cmd = { lattice_local.bashls.bin, "start" }
        }
        nvim_lsp.ccls.setup {
          on_attach = on_attach,
          capabilities = capabilities,
          cmd = { lattice_local.ccls.bin }
        }
        nvim_lsp.cmake.setup {
          on_attach = on_attach,
          capabilities = capabilities,
          cmd = { lattice_local.cmake.bin }
        }
        nvim_lsp.cssls.setup {
          on_attach = on_attach,
          capabilities = capabilities,
          cmd = { lattice_local.cssls.bin, "--stdio" }
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
          on_attach = on_attach,
          capabilities = capabilities,
          cmd = { lattice_local.htmlls.bin, "--stdio" }
        }
        nvim_lsp.jsonls.setup {
          on_attach = on_attach,
          capabilities = capabilities,
          cmd = { lattice_local.jsonls.bin, "--stdio" },
          settings = {
            schemas = require "schemastore".json.schemas(),
            validate = { enable = true }
          }
        }
        -- nvim_lsp.powershell_es.setup {
        --   capabilities = capabilities,
        --   bundle = {lattice_local.powershell_es.bundle, "--stdio"}
        -- }
        nvim_lsp.prosemd_lsp.setup {
          on_attach = on_attach,
          capabilities = capabilities,
          cmd = { lattice_local.prosemd.bin, "--stdio" },
          filetypes = { "markdown" },
          -- root_dir = function(fname)
          --   return vim.lsp.util.find_git_ancestor(fname) or vim.fn.getcwd()
          -- end,
          settings = {}
        }
        nvim_lsp.pyright.setup {
          on_attach = on_attach,
          capabilities = capabilities,
          cmd = { lattice_local.prosemd.bin, "--stdio" }
        }
        nvim_lsp.rnix.setup {
          on_attach = on_attach,
          capabilities = capabilities,
          cmd = { lattice_local.rnix.bin }
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
          on_attach = on_attach,
          cmd = { lattice_local.sumneko.bin, "-E", lattice_local.sumneko.main },
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
                globals = { "vim" }
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
          on_attach = on_attach,
          cmd = { lattice_local.sqls.bin },
          settings = {
            sqls = {
              connections = { lattice_local.sqls.config }
            }
          }
        }
        nvim_lsp.svelte.setup {
          capabilities = capabilities,
          cmd = { lattice_local.sveltels.bin }
        }
        nvim_lsp.taplo.setup {
          capabilities = capabilities,
          cmd = { lattice_local.taplo.bin, "lsp", "stdio" }
        }
        nvim_lsp.tsserver.setup {
          capabilities = capabilities,
          cmd = { lattice_local.tsls.bin, "--stdio" },
          filetypes = {
            "javascript",
            "javascriptreact",
            "javascript.jsx",
            "typescript",
            "typescriptreact",
            "typescript.tsx"
          },
          on_attach = on_attach,
        }

        nvim_lsp.vimls.setup {
          on_attach = on_attach,
          capabilities = capabilities,
          cmd = { lattice_local.vimls.bin }
        }
        nvim_lsp.yamlls.setup {
          on_attach = on_attach,
          capabilities = capabilities,
          cmd = { lattice_local.yamlls.bin }
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
        "protex/better-digraphs.nvim",
        "tami5/sqlite.lua",
      },
      config = function()
        local tscope = require("telescope")
        local ll = require("lattice_local")
        tscope.setup {
          pickers = {},
          extensions = {
            media_files = {
              filetypes = { "png", "webp", "jpg", "jpeg" },
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
        vim.cmd [[
          inoremap <C-k><C-k> <Cmd>lua require'better-digraphs'.digraphs("insert")<CR>
          nnoremap r<C-k><C-k> <Cmd>lua require'better-digraphs'.digraphs("normal")<CR>
          vnoremap r<C-k><C-k> <ESC><Cmd>lua require'better-digraphs'.digraphs("visual")<CR>
        ]]

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
    use "petertriho/cmp-git"
    use {
      "phaazon/hop.nvim",
      branch = "v2",
      as = "hop",
      config = function()
        local hop = require("hop")
        hop.setup { keys = "etovxqpdygfblzhckisuran" }
        local directions = require("hop.hint").HintDirection
        vim.keymap.set(
          "",
          "f",
          function()
            hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
          end,
          { remap = true }
        )
        vim.keymap.set(
          "",
          "F",
          function()
            hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
          end,
          { remap = true }
        )
        vim.keymap.set(
          "",
          "t",
          function()
            hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
          end,
          { remap = true }
        )
        vim.keymap.set(
          "",
          "T",
          function()
            hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
          end,
          { remap = true }
        )
      end
    }
    use "preservim/vim-colors-pencil"
    use "preservim/vim-pencil"
    use { "preservim/vim-textobj-quote",
      config = function()
        -- from https://github.com/preservim/vim-textobj-quote README.md
        vim.cmd [[
          filetype plugin on

          augroup textobj_quote
            autocmd!
            autocmd FileType markdown call textobj#quote#init()
            autocmd FileType textile call textobj#quote#init()
            autocmd FileType text call textobj#quote#init({'educate': 0})
          augroup END
        ]]
      end
    }
    use { "preservim/vim-textobj-sentence",
      config = function()
        -- from https://github.com/preservim/vim-textobj-sentence README.md
        vim.cmd [[
          filetype plugin indent on

          augroup textobj_sentence
            autocmd!
            autocmd FileType markdown call textobj#sentence#init()
            autocmd FileType textile call textobj#sentence#init()
          augroup END
        ]]
      end }
    use "preservim/vim-wordy"
    use {
      "rcarriga/nvim-notify",
      config = function()
        vim.notify = require("notify")
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
                    extraArgs = { "--target-dir", "/tmp/rust-analyzer-check" }
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
      cmd = { "SettleInit" },
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
    s("now", { d(1, date_input, {}) }),
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
  nnoremap <leader><Tab> :Telescope frecency <cr>
  " I tend to mash so 
  nnoremap <Tab><leader> :Telescope frecency <cr>
  autocmd BufWinEnter *.html iabbrev --- &mdash;
  autocmd BufWinEnter *.svelte iabbrev --- &mdash;
  autocmd BufWinEnter *.jsx iabbrev --- &mdash;
  autocmd BufWinEnter *.tsx iabbrev --- &mdash;
  autocmd BufWinEnter *.norg inoremap <M-CR> <End><CR>- [ ] 
  autocmd BufWinEnter *.md inoremap <M-CR> <End><CR>- [ ] 
]]
