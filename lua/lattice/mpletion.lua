local mpletion = {}

function mpletion.setup(use)
  use {
    "hrsh7th/nvim-cmp",
    after = { "nvim-treesitter", "LuaSnip" },
    requires = {
      "dmitmel/cmp-digraphs",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "lukas-reineke/cmp-rg",
      "ray-x/cmp-treesitter",
    },
    config = function()
      local luasnip = require "luasnip"
      local cmp = require "cmp"
      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end
      local insert = cmp.SelectBehavior.Insert
      local replace = cmp.SelectBehavior.replace
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
          mapping = cmp.mapping.preset.insert({
            ["<C-n>"] = cmp.mapping.scroll_docs(-4),
            ["<C-p>"] = cmp.mapping.scroll_docs(4),
            ["<C-c>"] = cmp.mapping.close(),
            ["<Escape>"] = cmp.mapping.close(),
            ["<CR>"] = cmp.mapping.confirm(
              {
                behavior = replace,
                select = true
              }
            ),
            ["<Tab>"] = cmp.mapping(
              function(fallback)
                if cmp.visible() then
                  cmp.select_next_item({ behavior = insert })
                elseif luasnip.expand_or_jumpable() then
                  luasnip.expand_or_jump()
                elseif has_words_before() then
                  cmp.complete({ reason = cmp.ContextReason.Manual })
                else
                  fallback()
                end
              end,
              { "i", "s", "c" }
            ),
            ["<S-Tab>"] = cmp.mapping(
              function(fallback)
                if cmp.visible() then
                  cmp.select_prev_item({ behavior = insert })
                elseif luasnip.expand_or_jumpable() then
                  luasnip.jump(-1)
                else
                  fallback()
                end
              end,
              { "i", "s", "c" }
            ),
          }),
          sources = {
            { name = "emoji" },
            { name = "digraphs" },
            { name = "nvim_lsp" },
            { name = "cmp_treesitter" },
            { name = "rg" },
            { name = "path" }
          }
        }
      )

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          {
            name = 'cmdline',
            option = {
              ignore_cmds = { 'Man', '!' }
            }
          }
        })
      })

      -- see also lspconfig, which loads after nvim-cmp, and sets up the nvim-cmp lsp source
    end
  }
end

return mpletion
