local data = {}

function data.setup(use)
  use {
    "kristijanhusak/vim-dadbod-ui",
    after = { "vim-dadbod" }
  }
  use {
    "tami5/sqlite.lua",
    config = function()
      -- vim.g.sqlite_clib_path = lattice_local.sqlite.lib -- I also set this below (race condition?)
    end
  }
  use {
    "kristijanhusak/vim-dadbod-completion",
    after = { "vim-dadbod", "nvim-cmp" },
    config = function()
      -- TODO: this looks wrong?
      vim.api.nvim_exec(
        [[
            autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })
          ]],
        true
      )
    end
  }
  use "tpope/vim-dadbod"
end

return data
