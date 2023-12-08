local code = {}

function code.setup(use)
  use "averms/black-nvim"
  use {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end
  }
  use "bfredl/nvim-luadev"
  use "David-Kunz/jester"
  use { "folke/trouble.nvim", after = "nvim-web-devicons" }
  use { "mfussenegger/nvim-dap",
    requires = { -- TODO: break up into separate use blocks
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "mxsdev/nvim-dap-vscode-js",
      "jbyuki/one-small-step-for-vimkind",
      {
        "microsoft/vscode-js-debug",
        opt = true,
        run = "npm install --legacy-peer-deps && npm run compile"
      },
    },
    config = function()
      require "dap-vscode-js".setup({
        adapters = { 'pwa-chrome' },
        log_file_path = "/tmp/dap_vscode_js.log",
        log_file_level = vim.log.levels.INFO, -- Logging level for output to file. Set to false to disable file logging.
        log_console_level = vim.log.levels
            .INFO                             -- Logging level for output to console. Set to false to disable console output.
      })
      for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
        require("dap").configurations[language] = {
          {
            type = "pwa-chrome",
            request = "launch",
            name = "Chrome Launch",
          },
        }
        require("nvim-dap-virtual-text").setup({})
        require "dapui".setup()
      end
      -- one-small-step
      require 'dap'.configurations.lua = { {
        type = 'nlua',
        request = 'attach',
        name = 'attach to running neovim instance'
      } }
      -- FIXME: these keybindings are recommended on the README for one-small-step but honestly they're global??
      -- vim.api.nvim_set_keymap('n', '<F8>', [[:lua require"dap".toggle_breakpoint()<CR>]], { noremap = true })
      -- vim.api.nvim_set_keymap('n', '<F9>', [[:lua require"dap".continue()<CR>]], { noremap = true })
      -- vim.api.nvim_set_keymap('n', '<F10>', [[:lua require"dap".step_over()<CR>]], { noremap = true })
      -- vim.api.nvim_set_keymap('n', '<S-F10>', [[:lua require"dap".step_into()<CR>]], { noremap = true })
      -- vim.api.nvim_set_keymap('n', '<F12>', [[:lua require"dap.ui.widgets".hover()<CR>]], { noremap = true })
      -- vim.api.nvim_set_keymap('n', '<F5>', [[:lua require"osv".launch({port = 8086})<CR>]], { noremap = true })
    end
  }
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
  use { "t-troebst/perfanno.nvim", config = function()
    require "perfanno".setup()
  end
  }
  use {
    "windwp/nvim-autopairs",
    config = function()
      require('nvim-autopairs').setup({ disable_filetype = { "TelescopePrompt", "vim", "markdown" } })
    end
  }
end

return code
