local lsp = {}

function lsp.setup(use)
  use "folke/lsp-colors.nvim"
  use {
    "folke/trouble.nvim",
    config = function()
      require "trouble".setup {}
    end
  }
  use "hrsh7th/cmp-nvim-lsp"
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
        vim.keymap.set("n", "<leader>K", vim.lsp.buf.hover, bufopts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
        vim.keymap.set("n", "<leader><C-k>", vim.lsp.buf.signature_help, bufopts)
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
end

return lsp
