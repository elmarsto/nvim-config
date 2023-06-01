local nippets = {}

function nippets.setup(use)
  use {
    "L3MON4D3/LuaSnip",
    tag = "v1.*",
    run = "make install_jsregexp",
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
      vim.api.nvim_set_keymap("i", "<C-n>", "<Plug>luasnip-next-choice", {})
      vim.api.nvim_set_keymap("s", "<C-n>", "<Plug>luasnip-next-choice", {})
      vim.api.nvim_set_keymap("i", "<C-p>", "<Plug>luasnip-prev-choice", {})
      vim.api.nvim_set_keymap("s", "<C-p>", "<Plug>luasnip-prev-choice", {})
      vim.api.nvim_set_keymap("i", "<C-u>", "<cmd>lua require('luasnip.extras.select_choice')()", {})

      local ls = require("luasnip")
      local s = ls.snippet
      local sn = ls.snippet_node
      -- local isn = ls.indent_snippet_node
      local t = ls.text_node
      local i = ls.insert_node
      -- local f = ls.function_node
      local c = ls.choice_node
      local d = ls.dynamic_node
      -- local r = ls.restore_node
      -- local events = require("luasnip.util.events")
      -- local ai = require("luasnip.nodes.absolute_indexer")
      -- local extras = require("luasnip.extras")
      -- local l = extras.lambda
      -- local rep = extras.rep
      -- local p = extras.partial
      -- local m = extras.match
      -- local n = extras.nonempty
      -- local dl = extras.dynamic_lambda
      -- local fmt = require("luasnip.extras.fmt").fmt
      -- local fmta = require("luasnip.extras.fmt").fmta
      -- local conds = require("luasnip.extras.expand_conditions")
      -- local postfix = require("luasnip.extras.postfix").postfix
      -- local types = require("luasnip.util.types")
      -- local parse = require("luasnip.util.parser").parse_snippet
      -- local ms = ls.multi_snippet
      -- local k = require("luasnip.nodes.key_indexer").new_key

      local date_input = function(_, _, fmt)
        local form = fmt or "%Y-%m-%d"
        return sn(nil, i(1, os.date(form)))
      end --
      -- TODO: dry out; can we have the user choose the register
      ls.add_snippets(
        "all",
        {
          s("now", { d(1, date_input, {}) }),
          s(
            "ln",
            {
              t "[",
              -- i(1),
              c(1, { t "foo", t "bar", t "baz" }),
              t("]("),
              i(2),
              t(")"),
              i(0)
            }
          ),
          s(
            "Xx",
            {
              t "- [",
              i(1),
              t "] ",
              i(0)
            }
          ),
        }
      )
    end
  }
end

return nippets
