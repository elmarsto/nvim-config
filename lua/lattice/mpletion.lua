local mpletion = {}

function mpletion.setup(use)
  use { "github/copilot.vim",
    after = { "nvim-lspconfig", "nvim-cmp" },
    config = function()
      vim.g.copilot_no_tab_map = true
    end
  }
  use {
    "hrsh7th/nvim-cmp",
    after = { "nvim-treesitter", "LuaSnip" },
    requires = {
      "L3MON4D3/cmp-luasnip-choice",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "lukas-reineke/cmp-rg",
      "ray-x/cmp-treesitter",
      "saadparwaiz1/cmp_luasnip",
      "uga-rosa/cmp-dictionary",
    },
    config = function()
      require('cmp_luasnip_choice').setup();
      local luasnip = require "luasnip"
      local cmp = require "cmp"
      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end
      local insert = cmp.SelectBehavior.Insert
      local replace = cmp.SelectBehavior.replace
      local modes = { 'i', 's', 'c' }
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
            ["<C-c>"] = cmp.mapping.close(),
            ["<Escape>"] = cmp.mapping.close(),
            ["<CR>"] = cmp.mapping.confirm( -- TODO: somehow integrate with copilot?
              {
                behavior = replace,
                select = true
              }
            ),
            ['<C-j>'] = cmp.mapping(function()
              vim.api.nvim_feedkeys(vim.fn['copilot#Accept'](vim.api.nvim_replace_termcodes('<Tab>', true, true, true)),
                'n', true)
            end),
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
              modes
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
              modes
            ),
            -- these two force the completion menu to appear (needed for luasnip_choice)
            ["<leader><Tab>"] = cmp.mapping(
              function(fallback)
                if cmp.visible() then
                  cmp.select_next_item({ behavior = insert })
                else
                  fallback()
                end
              end,
              modes
            ),
            ["<leader><S-Tab>"] = cmp.mapping(
              function(fallback)
                if cmp.visible() then
                  cmp.select_prev_item({ behavior = insert })
                else
                  fallback()
                end
              end,
              modes
            ),
          }),
          experimental = {
            ghost_text = false -- a default, but needed for copilot compat, so made explicit as per docs for cmp
          },
          sources = {
            { name = "luasnip" },
            { name = "luasnip_choice" },
            { name = "nvim_lsp" },
            { name = "cmp_treesitter" },
            { name = "rg" },
            { name = "path" },
            { name = "buffer" },
            { name = "dictionary" }
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
  use {
    "protex/better-digraphs.nvim",
    config = function()
      vim.keymap.set("i", "<C-k><C-k>", "<Cmd>lua require'better-digraphs'.digraphs('insert')<CR>")
      vim.keymap.set("n", "r<C-k><C-k>", "<Cmd>lua require'better-digraphs'.digraphs('normal')<CR>")
      vim.keymap.set("v", "r<C-k><C-k>", "<Cmd>lua require'better-digraphs'.digraphs('visual')<CR>")
    end
  }
  use {
    "ziontee113/icon-picker.nvim",
    config = function()
      require("icon-picker").setup({
        disable_legacy_commands = true,
      })
      vim.keymap.set("i", "<C-k><C-i>", "<Cmd>IconPickerInsert<CR>")
      vim.keymap.set("n", "r<C-k><C-i>", "<Cmd>IconPickerNormal<CR>")
      vim.keymap.set("v", "r<C-k><C-i>", "<Cmd>IconPickerNormal<CR>")
    end

  }
end

return mpletion
