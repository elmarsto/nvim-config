local nippets = {}

function nippets.setup(use)
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
  use "saadparwaiz1/cmp_luasnip"
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
end

return nippets
