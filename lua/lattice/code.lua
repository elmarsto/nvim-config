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
  use "github/copilot.vim"
  use { "mfussenegger/nvim-dap",
    requires = { "rcarriga/nvim-dap-ui", "theHamsta/nvim-dap-virtual-text", "mxsdev/nvim-dap-vscode-js",
      { "microsoft/vscode-js-debug", opt = true, run = "npm install --legacy-peer-deps && npm run compile" },
      'theHamsta/nvim-dap-virtual-text' },
    config = function()
      require "dap-vscode-js".setup({
        -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
        -- debugger_path = "(runtimedir)/site/pack/packer/opt/vscode-js-debug", -- Path to vscode-js-debug installation.
        -- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
        adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, -- which adapters to register in nvim-dap
        -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
        -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
        -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
      })
      for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
        require("dap").configurations[language] = {
          {
            type = "pwa-node",
            request = "launch",
            name = "Node Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "Node Attach",
            processId = require 'dap.utils'.pick_process,
            cwd = "${workspaceFolder}",
          },
          {
            type = "pwa-node",
            request = "launch",
            name = "Node Debug Jest Tests",
            -- trace = true, -- include debugger info
            runtimeExecutable = "node",
            runtimeArgs = {
              "./node_modules/jest/bin/jest.js",
              "--runInBand",
            },
            rootPath = "${workspaceFolder}",
            cwd = "${workspaceFolder}",
            console = "integratedTerminal",
            internalConsoleOptions = "neverOpen",
          },
          {
            type = "pwa-chrome",
            request = "launch",
            name = "Chrome Launch",
            program = "google-chrome-stable ${file}",
            cwd = "${workspaceFolder}",
            browserLaunchLocation = "workspace",
            port = '9222'
          },
          {
            type = "pwa-chrome",
            request = "attach",
            name = "Chrome Attach",
            processId = require 'dap.utils'.pick_process,
            cwd = "${workspaceFolder}",
            urlFilter = "http://localhost*",
            port = '9222'
          },
        }
        require("nvim-dap-virtual-text").setup {
          enabled = true, -- enable this plugin (the default)
          enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
          highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
          highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
          show_stop_reason = true, -- show stop reason when stopped for exceptions
          commented = false, -- prefix virtual text with comment string
          only_first_definition = true, -- only show virtual text at first definition (if there are multiple)
          all_references = false, -- show virtual text on all all references of the variable (not only definitions)
          filter_references_pattern = '<module', -- filter references (not definitions) pattern when all_references is activated (Lua gmatch pattern, default filters out Python modules)
          -- experimental features:
          virt_text_pos = 'eol', -- position of virtual text, see `:h nvim_buf_set_extmark()`
          all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
          virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
          virt_text_win_col = nil -- position the virtual text at a fixed window column (starting from the first text column) ,
          -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
        }
      end
    end
  }
  use "rafcamlet/nvim-luapad"
  use {
    "smjonas/inc-rename.nvim",
    config = function()
      require "inc_rename".setup()
    end
  }
  use {
    "simrat39/rust-tools.nvim",
    config = function()
      require("rust-tools").setup(
        {
          -- from https://github.com/simrat39/rust-tools.nvim/issues/72
          server = {
            settings = {
              ["rust-analyzer"] = {
                unstable_features = true,
                build_on_save = false,
                all_features = true,
                checkOnSave = {
                  enable = true,
                  command = "check",
                  extraArgs = { "--target-dir", "/tmp/rust-analyzer-check" }
                }
              }
            }
          }
        }
      )
    end
  }
  use "tpope/vim-surround"
  use {
    "windwp/nvim-autopairs",
    config = function()
      require('nvim-autopairs').setup({ disable_filetype = { "TelescopePrompt", "vim" } })
    end
  }
end

return code
