local scope = {}

function scope.setup(use)
  use { "axkirillov/easypick.nvim",
    after = "telescope.nvim",
    config = function()
      local easypick = require("easypick")

      -- only required for the example to work
      local base_branch = "main"

      easypick.setup({
        pickers = {
          -- add your custom pickers here
          -- below you can find some examples of what those can look like

          -- list files inside current folder with default previewer
          {
            -- name for your custom picker, that can be invoked using :Easypick <name> (supports tab completion)
            name = "ls",
            -- the command to execute, output has to be a list of plain text entries
            command = "ls",
            -- specify your custom previwer, or use one of the easypick.previewers
            previewer = easypick.previewers.default()
          },

          -- diff current branch with base_branch and show files that changed with respective diffs in preview
          {
            name = "changed_files",
            command = "git diff --name-only $(git merge-base HEAD " .. base_branch .. " )",
            previewer = easypick.previewers.branch_diff({ base_branch = base_branch })
          },

          -- list files that have conflicts with diffs in preview
          {
            name = "conflicts",
            command = "git diff --name-only --diff-filter=U --relative",
            previewer = easypick.previewers.file_diff()
          },
        }
      })
    end
  }
  use {
    "nvim-telescope/telescope.nvim",
    requires = {
      "debugloop/telescope-undo.nvim",
      "nvim-telescope/telescope-project.nvim",
      "nvim-telescope/telescope-frecency.nvim",
      "nvim-telescope/telescope-symbols.nvim",
      "fdschmidt93/telescope-egrepify.nvim",
      "tami5/sqlite.lua",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local tscope = require("telescope")
      tscope.setup {
        extensions = {
          media_files = {
            filetypes = { "png", "webp", "jpg", "jpeg" },
            find_cmd = "rg"
          },
        }
      }
      tscope.load_extension "egrepify"
      tscope.load_extension "frecency"
      tscope.load_extension "project"
      tscope.load_extension "undo"
    end
  }
  use {
    'LukasPietzschmann/telescope-tabs',
    requires = { 'nvim-telescope/telescope.nvim' },
    config = function()
      require 'telescope-tabs'.setup()
    end
  }
end

return scope
