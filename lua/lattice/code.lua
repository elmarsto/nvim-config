local code = {}

function code.setup(use)
  use {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end
  }
  use "bfredl/nvim-luadev"
  use "David-Kunz/jester"
  use "dmix/elvish.vim"
  use  { "folke/trouble.nvim", after = "nvim-web-devicons" }
  -- use { "mfussenegger/nvim-dap",
  --   requires = {
  --     "rcarriga/nvim-dap-ui",
  --     "theHamsta/nvim-dap-virtual-text",
  --     "mxsdev/nvim-dap-vscode-js",
  --     {
  --       "microsoft/vscode-js-debug",
  --       opt = true,
  --       run = "npm install --legacy-peer-deps && npm run compile"
  --     },
  --   },
  --   config = function()
  --     require "dap-vscode-js".setup({
  --       adapters = { 'pwa-chrome' },
  --       log_file_path = "/tmp/dap_vscode_js.log",
  --       log_file_level = vim.log.levels.INFO, -- Logging level for output to file. Set to false to disable file logging.
  --       log_console_level = vim.log.levels.INFO -- Logging level for output to console. Set to false to disable console output.
  --     })
  --     for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
  --       require("dap").configurations[language] = {
  --         {
  --           type = "pwa-chrome",
  --           request = "launch",
  --           name = "Chrome Launch",
  --         },
  --       }
  --       require("nvim-dap-virtual-text").setup()
  --       require "dapui".setup()
  --     end
  --   end
  -- }
  -- use {
  --   "simrat39/rust-tools.nvim",
  --   after = { "nvim-cmp", "nvim-lspconfig" },
  --   config = function()
  --     require("rust-tools").setup(
  --       {
  --         -- from https://github.com/simrat39/rust-tools.nvim/issues/72
  --         server = {
  --           settings = {
  --             ["rust-analyzer"] = {
  --               unstable_features = true,
  --               build_on_save = false,
  --               all_features = true,
  --               checkOnSave = {
  --                 enable = true,
  --                 command = "check",
  --                 extraArgs = { "--target-dir", "/tmp/rust-analyzer-check" }
  --               }
  --             }
  --           }
  --         }
  --       }
  --     )
  --   end
  -- }
  use "tpope/vim-surround"
  use {
    "windwp/nvim-autopairs",
    config = function()
      require('nvim-autopairs').setup({ disable_filetype = { "TelescopePrompt", "vim" } })
    end
  }
end

return code
