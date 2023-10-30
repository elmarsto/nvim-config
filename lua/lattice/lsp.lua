local lsp = {}

function lsp.setup(use)
  use { "j-hui/fidget.nvim", tag = 'legacy', config = function() require "fidget".setup({}) end }
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
                title = "do-nothing"
              }
            }
          end
        }
      }
      require("null-ls").setup(
        {
          sources = {
            nullAction
          }
        }
      )
    end
  }
  -- FIXME: this does tofu with the current font? also it doesn't let me configure the symbol for the gutter?
  -- use {
  --   'kosayoda/nvim-lightbulb',
  --   requires = 'antoinemadec/FixCursorHold.nvim',
  --   config = function()
  --     require('nvim-lightbulb').setup({
  --       virtual_text = {
  --         enabled = true,
  --       },
  --       autocmd = {
  --         enabled = true,
  --       }
  --     })
  --   end
  -- }
  use {
    "neovim/nvim-lspconfig",
    after = { "null-ls.nvim", "cmp-nvim-lsp", "nvim-cmp" },
    requires = {
      "SmiteshP/nvim-navbuddy",
      "SmiteshP/nvim-navic",  -- transitive on navbuddy
      "MunifTanjim/nui.nvim", -- transitive on navbuddy
      "b0o/schemastore.nvim",
      "lukas-reineke/lsp-format.nvim",
    },
    config = function()
      local lattice_local = require "lattice_local"
      local nvim_lsp = require("lspconfig")

      require 'lsp-format'.setup {}
      -- declare local in this scope so we don't `require` every run of on_attach below
      local formatAttach = require "lsp-format".on_attach
      local standard_on_attach = function(client, bufnr)
        client.server_capabilities.document_formatting = true
        formatAttach(client)
        vim.api.nvim_buf_set_option(bufnr or 0, "omnifunc", "v:lua.vim.lsp.omnifunc")
      end
      local on_attach_w_navbuddy = function(client, bufnr)
        require 'nvim-navbuddy'.attach(client, bufnr)
        standard_on_attach(client, bufnr)
      end
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
      -- TODO: determine if this next variable is correct still? I know we use tsserver not eslint
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
        on_attach = standard_on_attach,
        filetypes = vim.tbl_keys(filetypes),
        capabilities = capabilities,
        init_options = {
          filetypes = filetypes,
          linters = linters,
          formatters = formatters,
          formatFiletypes = formatFiletypes
        }
      }
      nvim_lsp.bashls.setup {
        on_attach = standard_on_attach,
        capabilities = capabilities,
        cmd = { lattice_local.bashls.bin, "start" }
      }
      nvim_lsp.ccls.setup {
        on_attach = standard_on_attach,
        capabilities = capabilities,
        cmd = { lattice_local.ccls.bin }
      }
      nvim_lsp.cmake.setup {
        on_attach = standard_on_attach,
        capabilities = capabilities,
        cmd = { lattice_local.cmake.bin }
      }
      nvim_lsp.cssls.setup {
        on_attach = standard_on_attach,
        capabilities = capabilities,
        cmd = { lattice_local.cssls.bin, "--stdio" }
      }
      nvim_lsp.graphql.setup {
        capabilities = capabilities,
        cmd = { lattice_local.graphql.bin, "server", "-m", "stream" }
      }
      nvim_lsp.html.setup {
        on_attach = standard_on_attach,
        capabilities = capabilities,
        cmd = { lattice_local.htmlls.bin, "--stdio" }
      }
      nvim_lsp.jsonls.setup {
        on_attach = standard_on_attach,
        capabilities = capabilities,
        cmd = { lattice_local.jsonls.bin, "--stdio" },
        settings = {
          schemas = require "schemastore".json.schemas(),
          validate = { enable = true }
        }
      }
      nvim_lsp.marksman.setup {
        capabilities = capabilities,
        cmd = { lattice_local.marksman.bin, "server" }
      }
      nvim_lsp.prosemd_lsp.setup {
        on_attach = standard_on_attach,
        capabilities = capabilities,
        cmd = { lattice_local.prosemd.bin, "--stdio" },
        filetypes = { "markdown" },
        settings = {}
      }
      nvim_lsp.pyright.setup {
        on_attach = standard_on_attach,
        capabilities = capabilities,
        cmd = { lattice_local.pyls.bin, "--stdio" }
      }
      nvim_lsp.rnix.setup {
        on_attach = standard_on_attach,
        capabilities = capabilities,
        cmd = { lattice_local.rnix.bin }
      }
      nvim_lsp.lua_ls.setup {
        on_attach = on_attach_w_navbuddy,
        cmd = { lattice_local.luals.bin },
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            diagnostics = {
              globals = { "vim" }
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true)
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
              enable = false
            }
          }
        }
      }
      nvim_lsp.sqlls.setup {
        on_attach = standard_on_attach,
        cmd = { lattice_local.sqlls.bin },
        settings = {
          sqlls = {
            connections = { lattice_local.sqlls.config }
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
        on_attach = on_attach_w_navbuddy,
      }
      nvim_lsp.vimls.setup {
        on_attach = standard_on_attach,
        capabilities = capabilities,
        cmd = { lattice_local.vimls.bin }
      }
      nvim_lsp.yamlls.setup {
        on_attach = standard_on_attach,
        capabilities = capabilities,
        cmd = { lattice_local.yamlls.bin, "--stdio" },
        settings = {
          yaml = {
            format = {
              enable = true,
              singleQuote = false,
              bracketSpacing = true
            },
            validate = true,
            completion = true
          }
        }
      }
    end
  }
  use {
    "smjonas/inc-rename.nvim",
    config = function()
      require("inc_rename").setup()
    end,
  }
end

return lsp
