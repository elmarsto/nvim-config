local mpletion = {}

function mpletion.setup(use)
  use {
    "hrsh7th/nvim-cmp",
    requires = {
      "L3MON4D3/LuaSnip",
      "lukas-reineke/cmp-rg",
      "petertriho/cmp-git",
      "ray-x/cmp-treesitter",
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      "dmitmel/cmp-digraphs",
    },
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
          mapping = cmp.mapping.preset.insert({
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
            ["<C-PageDown>"] = cmp.mapping(
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
            ["<C-PageUp>"] = cmp.mapping(
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
            ),
            ["<c-space>"] = cmp.mapping {
              i = cmp.mapping.complete { reason = cmp.ContextReason.Manual },
            }
          }),
          sources = {
            { name = "buffer" },
            { name = "cmp_git" },
            { name = "cmp_treesitter" },
            { name = "digraphs" },
            { name = "emoji" },
            { name = "luasnip" },
            { name = "nvim_lsp" },
            { name = "rg" },
            { name = "path" }
          }
        }
      )
    end
  }
end

return mpletion
