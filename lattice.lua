local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
  vim.cmd "packadd packer.nvim"
end
require("packer").startup {
  function(use)
    use {
      "AckslD/nvim-neoclip.lua",
      requires = "tami5/sqlite.lua",
      config = function()
        require("neoclip").setup(
          {
            enable_persistant_history = true -- sic
          }
        )
      end
    }
    use {
      "APZelos/blamer.nvim",
      config = function()
      end
    }
    use "bfredl/nvim-luadev"
    use "chrisbra/csv.vim"
    use "dmix/elvish.vim"
    use {
      "ellisonleao/glow.nvim",
      config = function()
      end
    }
    use "embear/vim-localvimrc"
    use "folke/lsp-colors.nvim"
    use {
      "mhartington/formatter.nvim",
      config = function()
        require("formatter").setup(
          {
            logging = true,
            filetype = {
              typescriptreact = {
                function()
                  return {
                    exe = "prettier",
                    args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)},
                    stdin = true
                  }
                end
              },
              typescript = {
                function()
                  return {
                    exe = "prettier",
                    args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)},
                    stdin = true
                  }
                end
              },
              javascript = {
                function()
                  return {
                    exe = "prettier",
                    args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)},
                    stdin = true
                  }
                end
              },
              javascriptreact = {
                function()
                  return {
                    exe = "prettier",
                    args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)},
                    stdin = true
                  }
                end
              },
              json = {
                function()
                  return {
                    exe = "prettier",
                    args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)},
                    stdin = true
                  }
                end
              },
              lua = {
                -- luafmt
                function()
                  return {
                    exe = "luafmt",
                    args = {"--indent-count", 2, "--stdin"},
                    stdin = true
                  }
                end
              }
            }
          }
        )
        vim.api.nvim_exec(
          [[
          augroup FormatAutogroup
            autocmd!
            autocmd BufWritePost *.js,*.rs,*.ts,*.tsx,*.jsx,*.lua FormatWrite
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
    -- use { 'glepnir/lspsaga.nvim', config =
    --   function ()
    --     require'lspsaga'.init_lsp_saga()
    --   end
    -- }
    use {
      "glepnir/galaxyline.nvim",
      requires = {"kyazdani42/nvim-web-devicons"},
      config = function()
        require "lattice_line"
      end
    }
    use "godlygeek/tabular"
    use {"saadparwaiz1/cmp_luasnip", requires = "L3MON4D3/LuaSnip"}
    use "L3MON4D3/LuaSnip"
    use {
      "hrsh7th/nvim-cmp",
      requires = "saadparwaiz1/cmp_luasnip",
      config = function()
        local cmp = require "cmp"
        cmp.setup(
          {
            snippet = {
              expand = function(args)
                require "luasnip".lsp_expand(args.body)
              end
            },
            mapping = {
              ["<C-d>"] = cmp.mapping.scroll_docs(-4),
              ["<C-f>"] = cmp.mapping.scroll_docs(4),
              ["<C-Space>"] = cmp.mapping.complete(),
              ["<C-e>"] = cmp.mapping.close(),
              ["<CR>"] = cmp.mapping.confirm({select = true})
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
    use(
      {
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
    )
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
    use "mbbill/undotree"
    use {
      "mfussenegger/nvim-dap",
      config = function()
      end
    }
    use {
      "glepnir/dashboard-nvim",
      config = function()
        -- lifted w love+respect from https://github.com/johnsci911/nvim-ide/blob/lua/lua/config/nvim-dashboard.lua
        vim.g.dashboard_custom_header = {
            "╻  ┏━┓╺┳╸╺┳╸╻┏━╸┏━╸   ╻ ╻╻┏┳┓",
            "┃  ┣━┫ ┃  ┃ ┃┃  ┣╸    ┃┏┛┃┃┃┃",
            "┗━╸╹ ╹ ╹  ╹ ╹┗━╸┗━╸   ┗┛ ╹╹ ╹",
        }

        vim.g.dashboard_default_executive = "telescope"

        vim.g.dashboard_custom_section = {
          a = {description = {"  Find File           "}, command = "FzfLua files"},
          b = {description = {"  Recently Used Files "}, command = "FzfLua oldfiles"},
          p = {description = {"  Projects            "}, command = "Telescope project"},
          e = {description = {"  Marks              "}, command = "Telescope marks"}
        }
      end
    }
    use {
      "norcalli/nvim-colorizer.lua",
      config = function()
        require "colorizer".setup()
      end
    }
    use "neomake/neomake"
    use {
      "neovim/nvim-lspconfig",
      config = function()
        local lattice_local = require "lattice_local"
        local nvim_lsp = require("lspconfig")
        -- paste https://jose-elias-alvarez.medium.com/configuring-neovims-lsp-client-for-typescript-development-5789d58ea9c
        -- local format_async = function(err, _, result, _, bufnr)
        -- if err ~= nil or result == nil then
        --   return
        -- end
        -- if not vim.api.nvim_buf_get_option(bufnr, "modified") then
        --   local view = vim.fn.winsaveview()
        --   vim.lsp.util.apply_text_edits(result, bufnr)
        --   vim.fn.winrestview(view)
        --   if bufnr == vim.api.nvim_get_current_buf() then
        --     vim.api.nvim_command("noautocmd :update")
        --   end
        -- end
        -- end
        -- broken in nightly
        -- vim.lsp.handlers["textDocument/formatting"] = format_async
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
          typescript = "eslint",
          typescriptreact = "eslint"
        }
        local linters = {
          eslint = {
            sourceName = "eslint",
            command = "eslint_d",
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
          prettier = {command = "prettier", args = {"--stdin-filepath", "%filepath"}}
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
        nvim_lsp.rust_analyzer.setup {
          settings = {
            rust = {
              unstable_features = true,
              build_on_save = false,
              all_features = true
            }
          }
        }
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
          on_attach = function(client)
            client.resolved_capabilities.document_formatting = false
            on_attach(client)
          end
        }
        nvim_lsp.vimls.setup {}
        nvim_lsp.yamlls.setup {}
        nvim_lsp.zk.setup {}
      end
    }
    use {
      "numToStr/Comment.nvim",
      config = function()
        require("Comment").setup()
      end
    }
    use "nvim-lua/lsp-status.nvim"
    use {"ibhagwan/fzf-lua", requires = {"vijaymarupudi/nvim-fzf", "kyazdani42/nvim-web-devicons"}}
    use {
      "nvim-telescope/telescope.nvim",
      requires = {
        "nvim-lua/plenary.nvim",
        {"nvim-telescope/telescope-packer.nvim", requires = "wbthomason/packer.nvim"},
        {"nvim-telescope/telescope-fzf-native.nvim", run = require "lattice_local".telescope_fzf_native.run}
      },
      config = function()
        local tscope = require("telescope")
        tscope.setup {}
        tscope.load_extension "packer"
        tscope.load_extension "fzf"
      end
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
    use {
      "nvim-treesitter/nvim-treesitter-textobjects",
      config = function()
      end
    }
    use "preservim/vim-colors-pencil"
    use "preservim/vim-lexical"
    use "preservim/vim-pencil"
    use "preservim/vim-textobj-quote"
    use "preservim/vim-textobj-sentence"
    use {
      "rcarriga/nvim-dap-ui",
      config = function()
      end
    }
    use {
      "simrat39/symbols-outline.nvim",
      config = function()
      end
    }
    use "rafcamlet/nvim-luapad"
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
      config = function()
        require("vgit").setup()
      end
    }
    use "tpope/vim-abolish"
    use "tpope/vim-surround"
    use "tpope/vim-obsession"
    use "tyru/open-browser.vim"
    use "vim-pandoc/vim-pandoc"
    use "vim-pandoc/vim-pandoc-syntax"
    use "wannesm/wmgraphviz.vim"
    use "wbthomason/packer.nvim" -- self-control
  end
}
