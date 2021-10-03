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
    use { 'glepnir/lspsaga.nvim', config = 
      function ()
        require'lspsaga'.init_lsp_saga()
      end
    }
    use 'godlygeek/tabular'
    use { 'hrsh7th/nvim-cmp', config =
      function()
				local cmp = require'cmp'
				cmp.setup({
					snippet = {
						expand = function(args)
							vim.fn["vsnip#anonymous"](args.body)
						end,
					},
					mapping = {
						['<C-d>'] = cmp.mapping.scroll_docs(-4),
						['<C-f>'] = cmp.mapping.scroll_docs(4),
						['<C-Space>'] = cmp.mapping.complete(),
						['<C-e>'] = cmp.mapping.close(),
						['<CR>'] = cmp.mapping.confirm({ select = true }),
					},
					sources = {
						{ name = 'nvim_lsp' },
						{ name = 'vsnip' },
						{ name = 'buffer' },
					}
				})
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
          mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>', '<C-y>', '<C-e>', 'zt', 'zz', 'zb'},
          easing_function = "quadratic" -- Default easing function
        })
      end
    }
    use { 'kosayoda/nvim-lightbulb', config =
      function()
        vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
      end
    }
    use { 'kyazdani42/nvim-web-devicons', config =
      function()
        require'nvim-web-devicons'.setup {
           override = {
             -- your personnal icons can go here (to override)
             -- DevIcon will be appended to `name`
           };
           default = true;
          }
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
        nvim_lsp.cssls.setup {}
        nvim_lsp.html.setup {}
        nvim_lsp.jsonls.setup {}
        nvim_lsp.pyright.setup {}
        nvim_lsp.rnix.setup {}
        nvim_lsp.rust_analyzer.setup {
          settings = {
            rust = {
              unstable_features = true,
              build_on_save = false,
              all_features = true,
            },
          },
        }
        nvim_lsp.sqls.setup {}
        nvim_lsp.sumneko_lua.setup{}
        nvim_lsp.svelte.setup{}
        nvim_lsp.tsserver.setup {}
        local on_attach = function(client, bufnr)
          local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
          local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

          -- Enable completion triggered by <c-x><c-o>
          buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

          -- Mappings.
          local opts = { noremap=true, silent=true }

          -- See `:help vim.lsp.*` for documentation on any of the below functions
          buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
          buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
          buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
          buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
          buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
          buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
          buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
          buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
          buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
          buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
          buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
          buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
          buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
          buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
          buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
          buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
          buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
        end

        -- Use a loop to conveniently call 'setup' on multiple servers and
        -- map buffer local keybindings when the language server attaches
        local servers = { 'ccls', 'html','jsonls','pyright','rnix','rust_analyzer','sqls','sumneko_lua','svelte','tsserver' };
        for _, lsp in ipairs(servers) do
          nvim_lsp[lsp].setup {
            on_attach = on_attach,
            flags = {
              debounce_text_changes = 150,
            }
          }
        end

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
        local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
        -- FIXME
        parser_config.sql =  {
          install_info = {
            url = "https://github.com/DerekStride/tree-sitter-sql",
            files = { "src/parser.c" }
          },
          filetype = "sql"
        }
        -- FIXME
        parser_config.diff = {
          install_info = {
            url = "https://github.com/vigoux/tree-sitter-diff",
            files = { "src/parser.c" }
          },
          filetype = "diff"
        }
        require'nvim-treesitter.configs'.setup {
          ensure_installed = {  
						"c",
						"cpp",
						"css",
            "diff",
						"html",
						"javascript",
						"json",
						"ledger",
						"lua",
						"nix",
						"python",
						"rust",
            "sql",
						"svelte",
						"typescript",
						"tsx",
						"toml",
					},
          highlight = {
            enable = true,              -- false will disable the whole extension
            additional_vim_regex_highlighting = true,
          },
					indent = {
						enable = true
					},
					incremental_selection = {
						enable = true,
						keymaps = {
							init_selection = "gnn",
							node_incremental = "grn",
							scope_incremental = "grc",
							node_decremental = "grm",
						},
					},
        }

      end
    }
    use { 'nvim-treesitter/nvim-treesitter-textobjects', config =
      function()
      end
    }
    use { 'oberblastmeister/neuron.nvim', config =
      function()
				-- these are all the default values
				require'neuron'.setup {
						virtual_titles = true,
						mappings = true,
						run = nil, -- function to run when in neuron dir
						neuron_dir = "~/Navaruk", -- the directory of all of your notes, expanded by default (currently supports only one directory for notes, find a way to detect neuron.dhall to use any directory)
						leader = "gz", -- the leader key to for all mappings, remember with 'go zettel'
				}
      end
    }
    use { 'onsails/lspkind-nvim', config =
      function()
      end
    }
    use 'plasticboy/vim-markdown'
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
    use 'vim-pandoc/vim-pandoc-syntax'
    use 'wannesm/wmgraphviz.vim'
  end
}
