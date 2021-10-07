-- you are not expected to understand this
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd 'packadd packer.nvim'
end
require('packer').startup {
  function(use)
    use {
      'AckslD/nvim-neoclip.lua',
      requires = { {'tami5/sqlite.lua', module = 'sqlite'} },
      config = function()
        require('neoclip').setup({
          enable_persistant_history = true, -- sic
        })
      end,
    }
    use {
      'APZelos/blamer.nvim', config =
      function()
      end
    }
    use 'bfredl/nvim-luadev'
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
      'folke/trouble.nvim', requires = "kyazdani42/nvim-web-devicons", config =
      function()
        require'trouble'.setup {}
      end
    }
    use { 'glepnir/lspsaga.nvim', config =
      function ()
        require'lspsaga'.init_lsp_saga()
      end
    }
    use {
      'glepnir/galaxyline.nvim', requires = {'kyazdani42/nvim-web-devicons'}, config =
      function()
        require'lattice_line'
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
				-- Showing defaults
				require'nvim-lightbulb'.update_lightbulb {
						sign = {
								enabled = true,
								priority = 10,
						},
						float = {
								enabled = true,
								-- Text to show in the popup float
								-- Available keys for window options:
								-- - height     of floating window
								-- - width      of floating window
								-- - wrap_at    character to wrap at for computing height
								-- - max_width  maximal width of floating window
								-- - max_height maximal height of floating window
								-- - pad_left   number of columns to pad contents at left
								-- - pad_right  number of columns to pad contents at right
								-- - pad_top    number of lines to pad contents at top
								-- - pad_bottom number of lines to pad contents at bottom
								-- - offset_x   x-axis offset of the floating window
								-- - offset_y   y-axis offset of the floating window
								-- - anchor     corner of float to place at the cursor (NW, NE, SW, SE)
								-- - winblend   transparency of the window (0-100)
								win_opts = {},
						},
						virtual_text = {
								enabled = true,
								-- Text to show at virtual text
								hl_mode = "replace",
						},
						status_text = {
								enabled = true,
								-- Text to provide when no actions are available
								text_unavailable = ""
						}
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
        local lattice_local = require'lattice_local'
        local nvim_lsp = require("lspconfig")
        nvim_lsp.cssls.setup {}
        nvim_lsp.html.setup {}
        nvim_lsp.jsonls.setup {
          cmd = { lattice_local.jsonls.bin, "--stdio" }
        }
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
				local sumneko_runtime_path = vim.split(package.path, ';')
				table.insert(sumneko_runtime_path, "lua/?.lua")
				table.insert(sumneko_runtime_path, "lua/?/init.lua")
        nvim_lsp.sumneko_lua.setup {
          cmd = { lattice_local.sumneko.bin, "-E", lattice_local.sumneko.main  },
					settings = {
						Lua = {
							runtime = {
								-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
								version = 'LuaJIT',
								-- Setup your lua path
								path = sumneko_runtime_path,
							},
							diagnostics = {
								-- Get the language server to recognize the `vim` global
								globals = {'vim'},
							},
							workspace = {
								-- Make the server aware of Neovim runtime files
								library = vim.api.nvim_get_runtime_file("", true),
							},
							-- Do not send telemetry data containing a randomized but unique identifier
							telemetry = {
								enable = false,
							},
						},
					}
        }
        nvim_lsp.svelte.setup{}
        nvim_lsp.tsserver.setup {}
      end
    }
    use 'nvim-lua/lsp-status.nvim'
    use { 'nvim-telescope/telescope-frecency.nvim', requires = 'tami5/sqlite.lua' }
    use 'nvim-telescope/telescope-node-modules.nvim'
    use { 'nvim-telescope/telescope-packer.nvim', requires = 'wbthomason/packer.nvim' }
    use { 'nvim-telescope/telescope.nvim',
      requires = {
        'sharkdp/fd',
        'nvim-lua/plenary.nvim',
        'AckslD/nvim-neoclip.lua',
        'nvim-telescope/telescope-frecency.nvim',
        'nvim-telescope/telescope-node-modules.nvim',
        'nvim-telescope/telescope-packer.nvim',
      }, config =
      function()
        local tscope = require('telescope')
        tscope.setup()
        tscope.load_extension'frecency'
        tscope.load_extension'neoclip'
        tscope.load_extension'packer' -- kinda broken
        -- tscope.load_extension'node_modules' -- broken
      end
    }
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config =
      function()
        local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
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
    use 'rafcamlet/nvim-luapad'
    use { 'TimUntersberger/neogit', requires = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim'
    }, config =
      function()
        require'neogit'.setup({
          integrations = {
            diffview = true
          }
        })
      end
    }
    use { 'tami5/sqlite.lua', config =
      function()
        local lattice_local = require'lattice_local'
        vim.g.sqlite_clib_path = lattice_local.sqlite.lib
      end
    }
    use { 'tanvirtin/vgit.nvim', requires = 'nvim-lua/plenary.nvim', config =
      function()
        require('vgit').setup()
      end,
    }
    use 'tpope/vim-abolish'
    use 'tpope/vim-commentary'
    use 'tpope/vim-surround'
    use 'tyru/open-browser.vim'
    use 'vim-pandoc/vim-pandoc-syntax'
    use 'wannesm/wmgraphviz.vim'
    use 'wbthomason/packer.nvim' -- self-control
  end
}
