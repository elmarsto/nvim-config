local lsp = {}

function lsp.setup(use)
  use { "j-hui/fidget.nvim", tag = 'legacy', config = function() require "fidget".setup({}) end }
  use { "jinzhongjia/LspUI.nvim", branch = 'main', config = function()
    require('LspUI').setup()
  end
  }
  use {
    'kosayoda/nvim-lightbulb',
    requires = 'antoinemadec/FixCursorHold.nvim',
    config = function()
      require('nvim-lightbulb').setup({
        virtual_text = {
          enabled = true,
        },
        autocmd = {
          enabled = true,
        }
      })
    end
  }
  use {
    "neovim/nvim-lspconfig",
    after = { "cmp-nvim-lsp", "nvim-cmp" },
    requires = {
      "SmiteshP/nvim-navbuddy",
      "SmiteshP/nvim-navic",  -- transitive on navbuddy
      "MunifTanjim/nui.nvim", -- transitive on navbuddy
      "b0o/schemastore.nvim",
      "lukas-reineke/lsp-format.nvim",
    },
    config = function()
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
      nvim_lsp.bashls.setup {
        on_attach = on_attach_w_navbuddy,
        capabilities = capabilities,
      }
      nvim_lsp.ccls.setup {
        on_attach = on_attach_w_navbuddy,
        capabilities = capabilities,
      }
      nvim_lsp.cmake.setup {
        on_attach = on_attach_w_navbuddy,
        capabilities = capabilities,
      }
      nvim_lsp.cssls.setup {
        on_attach = on_attach_w_navbuddy,
        capabilities = capabilities,
      }
      nvim_lsp.eslint.setup {
        on_attach = function(client, bufnr)
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
          })
          standard_on_attach(client, bufnr)
        end,
        capabilities = capabilities,
        init_options = { documentFormatting = true },
      }
      nvim_lsp.graphql.setup {
        capabilities = capabilities,
      }
      nvim_lsp.html.setup {
        on_attach = on_attach_w_navbuddy,
        capabilities = capabilities,
      }
      nvim_lsp.jsonls.setup {
        on_attach = on_attach_w_navbuddy,
        capabilities = capabilities,
        settings = {
          schemas = require "schemastore".json.schemas(),
          validate = { enable = true }
        }
      }
      nvim_lsp.marksman.setup {
        capabilities = capabilities,
      }
      nvim_lsp.rnix.setup {
        on_attach = standard_on_attach,
        capabilities = capabilities,
      }
      nvim_lsp.lua_ls.setup {
        on_attach = on_attach_w_navbuddy,
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
        on_attach = on_attach_w_navbuddy,
        settings = {
          sqlls = {
            connections = { vim.g.lattice.sqlls.config }
          }
        }
      }
      nvim_lsp.stylelint_lsp.setup {
        on_attach = standard_on_attach,
        filetypes = { "css" },
        settings = {
          stylelintplus = {}
        }
      }
      nvim_lsp.taplo.setup {
        on_attach = on_attach_w_navbuddy,
        capabilities = capabilities,
      }
      nvim_lsp.tsserver.setup {
        on_attach = on_attach_w_navbuddy,
        capabilities = capabilities,
        filetypes = {
          "javascript",
          "javascriptreact",
          "javascript.jsx",
          "typescript",
          "typescriptreact",
          "typescript.tsx"
        },
      }
      nvim_lsp.vimls.setup {
        on_attach = standard_on_attach,
        capabilities = capabilities,
      }
      nvim_lsp.yamlls.setup {
        on_attach = on_attach_w_navbuddy,
        capabilities = capabilities,
        filetypes = { "yaml", "yml" },
        settings = {
          yaml = {
            schemas = {
              ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
            },
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
  use {
    "stevanmilic/nvim-lspimport",
    config = function()
      vim.keymap.set("n", "<leader>a", require("lspimport").import, { noremap = true })
    end,
  }
end

return lsp
