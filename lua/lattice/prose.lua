local prose = {}

function prose.setup(use)
  use "ellisonleao/glow.nvim"
  use "f3fora/cmp-spell"
  use {
    "jakewvincent/mkdnflow.nvim",
    config = function()
      vim.cmd("autocmd Filetype markdown set autowriteall")
      require("mkdnflow").setup(
        {
          filetypes = { md = true, rmd = true, markdown = true },
          create_dirs = true,
          perspective = {
            priority = "root",
            fallback = "current",
            root_tell = ".git",
            nvim_wd_heel = true
          },
          wrap = false,
          bib = {
            default_path = nil,
            find_in_root = true
          },
          silent = false,
          links = {
            style = "markdown",
            conceal = false,
            implicit_extension = nil,
            transform_implicit = false,
            transform_explicit = function(text)
              text = text:gsub(" ", "-")
              text = text:lower()
              text = os.date("%Y-%m-%d_") .. text
              return (text)
            end
          },
          to_do = {
            symbols = { " ", ".", "x" },
            update_parents = true,
            not_started = " ",
            in_progress = ".",
            complete = "x"
          },
          tables = {
            trim_whitespace = true,
            format_on_move = true
          },
          use_mappings_table = true,
          mappings = {
            MkdnNextLink = { "n", "<Tab>" },
            MkdnPrevLink = { "n", "<S-Tab>" },
            MkdnNextHeading = { "n", "<leader>]" },
            MkdnPrevHeading = { "n", "<leader>[" },
            MkdnGoBack = { "n", "<BS>" },
            MkdnGoForward = { "n", "<Del>" },
            MkdnFollowLink = { { "n", "v" }, "<CR>" },
            MkdnDestroyLink = { "n", "<M-CR>" },
            MkdnMoveSource = { "n", "<F2>" },
            MkdnYankAnchorLink = { "n", "ya" },
            MkdnYankFileAnchorLink = { "n", "yfa" },
            MkdnIncreaseHeading = { "n", "+" },
            MkdnDecreaseHeading = { "n", "-" },
            MkdnToggleToDo = { { "n", "v" }, "<C-Space>" },
            MkdnNewListItem = false,
            MkdnExtendList = false,
            MkdnUpdateNumbering = { "n", "<leader>nn" },
            MkdnTableNextCell = { "i", "<Tab>" },
            MkdnTablePrevCell = { "i", "<S-Tab>" },
            MkdnTableNextRow = false,
            MkdnTablePrevRow = { "i", "<M-CR>" },
            MkdnTableNewRowBelow = { { "n", "i" }, "<leader>ir" },
            MkdnTableNewRowAbove = { { "n", "i" }, "<leader>iR" },
            MkdnTableNewColAfter = { { "n", "i" }, "<leader>ic" },
            MkdnTableNewColBefore = { { "n", "i" }, "<leader>iC" },
            MkdnCR = false,
            MkdnTab = false,
            MkdnSTab = false
          }
        }
      )
    end
  }
  use "preservim/vim-colors-pencil"
  use "preservim/vim-pencil"
  use { "preservim/vim-textobj-quote",
    config = function()
      -- from https://github.com/preservim/vim-textobj-quote README.md
      vim.cmd [[
          filetype plugin on

          augroup textobj_quote
            autocmd!
            autocmd FileType markdown call textobj#quote#init()
            autocmd FileType textile call textobj#quote#init()
            autocmd FileType text call textobj#quote#init({'educate': 0})
          augroup END
        ]]
    end
  }
  use { "preservim/vim-textobj-sentence",
    config = function()
      -- from https://github.com/preservim/vim-textobj-sentence README.md
      vim.cmd [[
          filetype plugin indent on

          augroup textobj_sentence
            autocmd!
            autocmd FileType markdown call textobj#sentence#init()
            autocmd FileType textile call textobj#sentence#init()
          augroup END
        ]]
    end }
  use "preservim/vim-wordy"
  use "pirmd/gemini.vim"
end

return prose
