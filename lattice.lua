require('packer').startup {
function(use)
  use 'APZelos/blamer.nvim'
  use 'chrisbra/csv.vim'
  use 'dense-analysis/ale'
  use 'dmix/elvish.vim'
  use 'ellisonleao/glow.nvim'
  use 'embear/vim-localvimrc'
  use 'folke/lsp-colors.nvim'
  use 'folke/trouble.nvim'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/vim-vsnip'
  use 'junegunn/goyo.vim'
  use 'junegunn/limelight.vim'
  use 'junegunn/seoul256.vim'
  use 'kana/vim-textobj-user'
  use 'karb94/neoscroll.nvim'
  use 'kosayoda/nvim-lightbulb'
  use 'kyazdani42/nvim-web-devicons'
  use 'lotabout/skim.vim'
  use 'mbbill/undotree'
  use 'mfussenegger/nvim-dap'
  use 'neovim/nvim-lspconfig'
  use 'nvim-lua/lsp-status.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'onsails/lspkind-nvim'
  use 'preservim/vim-colors-pencil'
  use 'preservim/vim-lexical'
  use 'preservim/vim-pencil'
  use 'preservim/vim-textobj-quote'
  use 'preservim/vim-textobj-sentence'
  use 'rcarriga/nvim-dap-ui'
  use 'simrat39/symbols-outline.nvim'
  use 'tpope/vim-abolish'
  use 'tpope/vim-commentary'
  use 'tpope/vim-surround'
  use 'tyru/open-browser.vim'
  use 'wannesm/wmgraphviz.vim'
  -- see https://github.com/wbthomason/packer.nvim
end
}
-- TODO move all these into use brackets above
-- neoscroll
require('neoscroll').setup({
  easing_function = "quadratic" -- Default easing function
})
-- trouble
require'trouble'.setup {}
-- treesitter
require'nvim-treesitter.configs'.setup {
 ensure_installed = {  "cpp", "c", "javascript", "markdown", "typescript", "nix", "json", "toml", "lua" },
 highlight = {
   enable = true,              -- false will disable the whole extension
  -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
  -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
  -- Using this option may slow down your editor, and you may see some duplicate highlights.
  -- Instead of true it can also be a list of languages
  additional_vim_regex_highlighting = true,
 },
}
local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()


local on_attach = function(client, bufnr)
  local buf_map = vim.api.nvim_buf_set_keymap
  vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
  vim.cmd("command! LspFormatting lua vim.lsp.buf.formatting()")
  vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
  vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
  vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
  vim.cmd("command! LspRefs lua vim.lsp.buf.references()")
  vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
  vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
  vim.cmd("command! LspDiagPrev lua vim.lsp.diagnostic.goto_prev()")
  vim.cmd("command! LspDiagNext lua vim.lsp.diagnostic.goto_next()")
  vim.cmd("command! LspDiagLine lua vim.lsp.diagnostic.show_line_diagnostics()")
  vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")buf_map(bufnr, "n", "gd", ":LspDef<CR>", {silent = true})
end

-- LSP
local nvim_lsp = require("lspconfig")
nvim_lsp.sumneko_lua.setup{}
nvim_lsp.tsserver.setup {
  -- vim-cmp line
  -- capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  on_attach = function(client)
      client.resolved_capabilities.document_formatting = false
      on_attach(client)

  end
}

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

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
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
local servers = { 'rust_analyzer', 'pyright', 'tsserver', 'rnix', 'sqls', 'svelte', 'html',  }
for _, lsp in ipairs(servers) do
nvim_lsp[lsp].setup {
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  }
}
end
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = false,
  virtual_text = false,
  signs = true,
  update_in_insert = false,
}
)
-- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup({
snippet = {
  expand = function(args)
    -- For `vsnip` user.
    vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` user.

    -- For `luasnip` user.
    -- require('luasnip').lsp_expand(args.body)

    -- For `ultisnips` user.
    -- vim.fn["UltiSnips#Anon"](args.body)
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

  -- For vsnip user.
  { name = 'vsnip' },

  -- For luasnip user.
  -- { name = 'luasnip' },

  -- For ultisnips user.
  -- { name = 'ultisnips' },

  { name = 'buffer' },
}
})
-- end vim-cmp

-- vsnip, I think? snippets?

local t = function(str)
return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
  local col = vim.fn.col('.') - 1
  if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
      return true
  else
      return false
  end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
if vim.fn.pumvisible() == 1 then
  return t "<C-n>"
elseif vim.fn.call("vsnip#available", {1}) == 1 then
  return t "<Plug>(vsnip-expand-or-jump)"
elseif check_back_space() then
  return t "<Tab>"
else
  -- FIXME
  -- return vim.fn['compe#complete']()
end
end
_G.s_tab_complete = function()
if vim.fn.pumvisible() == 1 then
  return t "<C-p>"
elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
  return t "<Plug>(vsnip-jump-prev)"
else
  -- If <S-Tab> is not working in your terminal, change it to <C-h>
  return t "<S-Tab>"
end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
-- FIXME
-- vim.api.nvim_set_keymap("i", "<CR>", [[compe#confirm("<CR>")]], {expr = true, silent = true})
