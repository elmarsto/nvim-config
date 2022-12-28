vim.cmd [[
" this is how I do it
au CursorHold,CursorHoldI * checktime
au FocusGained,BufEnter * :checktime
au TermOpen * setlocal scrollback=-1
let &showbreak = '⮩'
set autoread
set backspace=indent,eol,start
set expandtab
set foldlevel=3
set laststatus=2 
set list
set listchars=precedes:«,extends:»
set mouse=a
set nospell
set nu
set relativenumber
set scrollback=100000
set shiftwidth=2
set signcolumn=yes
set smarttab
set softtabstop=2
set tabstop=2
set termguicolors
set undofile
set wrap
]]


-- packer and packages
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
  vim.cmd "packadd packer.nvim"
end
local packer = require "packer"
require "packer.luarocks".install_commands()
packer.startup {
  function(use)
    require 'lattice/avigation'.setup(use)
    require 'lattice/bunt'.setup(use)
    require 'lattice/code'.setup(use)
    require 'lattice/data'.setup(use)
    require 'lattice/git'.setup(use)
    require 'lattice/keyboard'.setup(use)
    require 'lattice/lsp'.setup(use)
    require 'lattice/mpletion'.setup(use)
    require 'lattice/nippets'.setup(use)
    require 'lattice/other'.setup(use)
    require 'lattice/prose'.setup(use)
    require 'lattice/repl'.setup(use)
    require 'lattice/scope'.setup(use)
    require 'lattice/treesitter'.setup(use)
    require 'lattice/unit'.setup(use)
  end
}

-- Set up minimal terminal environment, useful on Windows
local lls = require "lattice_local".shell
vim.o.shell = lls.bin
vim.o.shellredir = lls.redir
vim.o.shellcmdflag = lls.cmdflag
vim.o.shellpipe = lls.pipe
vim.o.shellquote = lls.quote
vim.o.shellxquote = lls.xquote
vim.wo.foldlevel = 6
vim.api.nvim_set_keymap("n", "<leader>z", "<CMD>terminal <cr>", {})
if vim.fn.has("win32") == 1 then
  vim.api.nvim_set_keymap("n", "", "<CMD>terminal <cr>", {})
end
