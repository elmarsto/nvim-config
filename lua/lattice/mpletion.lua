local mpletion = {}

function mpletion.setup(use)
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
  use "lukas-reineke/cmp-rg"
  use "petertriho/cmp-git"
  use "ray-x/cmp-treesitter"
end

return mpletion
