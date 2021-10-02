require('packer').startup {
  function(use)
    use {
      'APZelos/blamer.nvim', config =
      function() 
      end
    }
    use  'chrisbra/csv.vim'
    use 'dense-analysis/ale'
    use 'dmix/elvish.vim'
    use {
      'ellisonleao/glow.nvim', config =
      function() 
      end
    }
    use 'embear/vim-localvimrc'
    use {
      'folke/lsp-colors.nvim', config = 
      function() 
      end
    }
    use { 
      'folke/trouble.nvim', config = 
      function() 
        require'trouble'.setup {}
      end
    }
    use { 'hrsh7th/nvim-cmp', config =
      function()
      end
    }
    use { 'hrsh7th/vim-vsnip', config =
      function()
      end
    }
    use 'junegunn/goyo.vim'
    use 'junegunn/limelight.vim'
    use 'junegunn/seoul256.vim'
    use 'kana/vim-textobj-user'
    use { 
      'karb94/neoscroll.nvim', config =
      function()
        require('neoscroll').setup({
          easing_function = "quadratic" -- Default easing function
        })
      end
    }
    use { 'kosayoda/nvim-lightbulb', config =
      function()
      end
    }
    use { 'kyazdani42/nvim-web-devicons', config =
      function()
      end
    }
    use 'lotabout/skim.vim'
    use 'mbbill/undotree'
    use { 'mfussenegger/nvim-dap', config =
      function()
      end
    }
    use { 'neovim/nvim-lspconfig', config =
      function()
        local nvim_lsp = require("lspconfig")
        nvim_lsp.sumneko_lua.setup{}
        nvim_lsp.tsserver.setup {}
        nvim_lsp.rnix.setup {}
        nvim_lsp.sqls.setup {}
        nvim_lsp.pyright.setup {}
        nvim_lsp.rust_analyzer.setup {
          settings = {
            rust = {
              unstable_features = true,
              build_on_save = false,
              all_features = true,
            },
          },
        }
        nvim_lsp.svelte.setup{}
        nvim_lsp.html.setup {}
        nvim_lsp.cssls.setup {}
        nvim_lsp.jsonls.setup {}
      end
    }
    use { 'nvim-lua/lsp-status.nvim', config =
      function()
      end
    }
    use { 'nvim-telescope/telescope.nvim',
      requires = { 
        {'sharkdp/fd'}, 
        {'nvim-lua/plenary.nvim'} 
      }, config =
      function()
        require('telescope').setup{
          defaults = {
            -- Default configuration for telescope goes here:
            -- config_key = value,
            -- ..
          },
          pickers = {
            -- Default configuration for builtin pickers goes here:
            -- picker_name = {
            --   picker_config_key = value,
            --   ...
            -- }
            -- Now the picker_config_key will be applied every time you call this
            -- builtin picker
          },
          extensions = {
            -- Your extension configuration goes here:
            -- extension_name = {
            --   extension_config_key = value,
            -- }
            -- please take a look at the readme of the extension you want to configure
          }
        }
      end
    }
    use { 'nvim-telescope/telescope-frecency.nvim', requires = {'tami5/sqlite.lua'}, config = 
      function()
        require'telescope'.load_extension('frecency')
      end
    }
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config =
      function()
        require'nvim-treesitter.configs'.setup {
          ensure_installed = {  "cpp", "c", "javascript", "typescript", "nix", "json", "toml", "lua" },
          highlight = {
            enable = true,              -- false will disable the whole extension
            additional_vim_regex_highlighting = true,
          },
        }
      end
    }
    use { 'nvim-treesitter/nvim-treesitter-textobjects', config =
      function()
      end
    }
    use { 'onsails/lspkind-nvim', config =
      function()
      end
    }
    use 'preservim/vim-colors-pencil'
    use 'preservim/vim-lexical'
    use 'preservim/vim-pencil'
    use 'preservim/vim-textobj-quote'
    use 'preservim/vim-textobj-sentence'
    use { 'rcarriga/nvim-dap-ui', config =
      function()
      end
    }
    use { 'simrat39/symbols-outline.nvim', config =
      function()
      end
    }
    use 'tpope/vim-abolish'
    use 'tpope/vim-commentary'
    use 'tpope/vim-surround'
    use 'tyru/open-browser.vim'
    use 'wannesm/wmgraphviz.vim'
  end
}
