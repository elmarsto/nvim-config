local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
-- local c = ls.choice_node
local d = ls.dynamic_node
-- local l = require("luasnip.extras").lambda
-- local r = require("luasnip.extras").rep
-- local p = require("luasnip.extras").partial
-- local m = require("luasnip.extras").match
-- local n = require("luasnip.extras").nonempty
-- local dl = require("luasnip.extras").dynamic_lambda
-- local fmt = require("luasnip.extras.fmt").fmt
-- local fmta = require("luasnip.extras.fmt").fmta
-- local types = require("luasnip.util.types")
-- local conds = require("luasnip.extras.conditions")

-- -- args is a table, where 1 is the text in Placeholder 1, 2 the text in
-- -- placeholder 2,...
-- local function copy(args)
--   return args[1]
-- end
-- --
-- -- 'recursive' dynamic snippet. Expands to some text followed by itself.
-- local rec_ls
-- rec_ls = function()
--   return sn(
--     nil,
--     c(
--       1,
--       {
--         -- Order is important, sn(...) first would cause infinite loop of expansion.
--         t(""),
--         sn(nil, {t({"", "\t\\item "}), i(1), d(2, rec_ls, {})})
--       }
--     )
--   )
-- end
-- --
-- -- Make sure to not pass an invalid command, as io.popen() may write over nvim-text.
-- local function bash(_, _, command)
--   local file = io.popen(command, "r")
--   local res = {}
--   for line in file:lines() do
--     table.insert(res, line)
--   end
--   return res
-- end
-- -- Returns a snippet_node wrapped around an insert_node whose initial
-- -- text value is set to the current date in the desired format.

local date_input = function(_, _, fmt)
  local form = fmt or "%Y-%m-%d"
  return sn(nil, i(1, os.date(form)))
end

-- TODO: dry out; can we have the user choose the register
ls.snippets = {
  all = {
    s( "now", { d(1, date_input, {}) }),
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
      "ln=",
      {
        t "[",
        i(1),
        t("]("),
        f(
          function(_)
            return vim.fn.getreg("=") or {}
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
      "link_url",
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
}
