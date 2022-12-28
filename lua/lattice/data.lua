local data = {}

function data.setup(use)
  use "kristijanhusak/vim-dadbod-ui"
  use {
    "kristijanhusak/vim-dadbod-completion",
    config = function()
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
